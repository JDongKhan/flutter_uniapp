//
//  FlutterUniAppManager.m
//  flutter_uniapp
//
//  Created by sn on 2023/5/10.
//

#import "FlutterUniAppManager.h"
#import "DCUniMP.h"
#import "DownUtils.h"

#define k_AppId1 @"__UNI__11E9B73" // uniapp 示例工程，在 HBuilderX 中新建 uniapp 示例项目可获取示例源码
#define k_AppId2 @"__UNI__CBDCE04" // 演示扩展 Module 及 Component 等功能示例小程序，工程 GitHub 地址： https://github.com/dcloudio/UniMPExample


static id _instance = nil;  //定义static全局变量

@interface FlutterUniAppManager() <DCUniMPSDKEngineDelegate>

@property (nonatomic, weak) DCUniMPInstance *uniMPInstance; /**< 保存当前打开的小程序应用的引用 注意：请使用 weak 修辞，否则应在关闭小程序时置为 nil */

@end

@implementation FlutterUniAppManager

+ (instancetype)shared {
    // static修饰标记变量
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)initSDK {
   
    // 注册 module 注：module的 Name 需要保证唯一， class：为 module 的类名
//    [WXSDKEngine registerModule:@"TestModule" withClass:NSClassFromString(@"TestModule")];
    // 注册 component 注：component 的 Name 需要保证唯一， class：为 component 的类名
//    [WXSDKEngine registerComponent:@"testmap" withClass:NSClassFromString(@"TestMapComponent")];
    
    
    DCUniMPMenuActionSheetItem *item1 = [[DCUniMPMenuActionSheetItem alloc] initWithTitle:@"将小程序隐藏到后台" identifier:@"enterBackground"];
    DCUniMPMenuActionSheetItem *item2 = [[DCUniMPMenuActionSheetItem alloc] initWithTitle:@"关闭小程序" identifier:@"closeUniMP"];
    
//     运行内置的 __UNI__CBDCE04 小程序，点击进去 小程序-原生通讯 页面，打开下面的注释，并将 item3 添加到 MenuItems 中，可以测试原生向小程序发送事件
//    DCUniMPMenuActionSheetItem *item3 = [[DCUniMPMenuActionSheetItem alloc] initWithTitle:@"SendUniMPEvent" identifier:@"SendUniMPEvent"];
    // 添加到全局配置
    [DCUniMPSDKEngine setDefaultMenuItems:@[item1,item2]];
    
    // 设置 delegate
    [DCUniMPSDKEngine setDelegate:self];

}

- (void)openMini:(NSString *_Nullable)remoteUrl password:(NSString *)password path:(NSString *_Nullable)path {
    NSString *fileName = remoteUrl.lastPathComponent;
    NSString *appId = [fileName stringByDeletingPathExtension];
    
    [DownUtils downFile:remoteUrl success:^(NSString * _Nonnull path) {
        //解压
        [self checkUniMPResource:appId appResourcePath:path password:password];
        
        // 获取配置信息
        DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
        // 配置启动小程序时传递的数据（目标小程序可在 App.onLaunch，App.onShow 中获取到启动时传递的数据）
        configuration.extraData = @{ @"launchInfo":@"Hello UniMP" };
        // 配置小程序启动后直接打开的页面路径 例：@"pages/component/view/view?action=redirect&password=123456"
    //    configuration.path = @"pages/component/view/view?action=redirect&password=123456";
        // 开启后台运行
        configuration.enableBackground = YES;
        // 设置打开方式
        configuration.openMode = DCUniMPOpenModePush;
        // 启用侧滑手势关闭小程序
        configuration.enableGestureClose = YES;
        __weak __typeof(self)weakSelf = self;
        // 打开小程序
        [DCUniMPSDKEngine openUniMP:appId configuration:configuration completed:^(DCUniMPInstance * _Nullable uniMPInstance, NSError * _Nullable error) {
            if (uniMPInstance) {
                weakSelf.uniMPInstance = uniMPInstance;
            } else {
                NSLog(@"打开小程序出错：%@",error);
            }
        }];
        
    }];
    
}

- (void)openLocalMini:(NSString *_Nullable)remoteUrl path:(NSString *_Nullable)path {
    NSString *appResourcePath = [[NSBundle mainBundle] pathForResource:k_AppId2 ofType:@"wgt"];
    [self checkUniMPResource:k_AppId2 appResourcePath:appResourcePath password:nil];
    
    // 获取配置信息
    DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
    
    // 开启后台运行
    configuration.enableBackground = YES;
    
    // 设置打开方式
    configuration.openMode = DCUniMPOpenModePresent;
    
    // 启用侧滑手势关闭小程序
    configuration.enableGestureClose = YES;
    
    
    __weak __typeof(self)weakSelf = self;
    // 预加载小程序
    [DCUniMPSDKEngine preloadUniMP:k_AppId2 configuration:configuration completed:^(DCUniMPInstance * _Nullable uniMPInstance, NSError * _Nullable error) {
        if (uniMPInstance) {
            weakSelf.uniMPInstance = uniMPInstance;
            // 预加载后打开小程序
            [uniMPInstance showWithCompletion:^(BOOL success, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"show 小程序失败：%@",error);
                }
            }];
        } else {
            NSLog(@"预加载小程序出错：%@",error);
        }
    }];
}


/// 检查运行目录是否存在应用资源，不存在将应用资源部署到运行目录
- (void)checkUniMPResource:(NSString *)appid appResourcePath:(NSString *)appResourcePath password:(NSString *)password {
#warning 注意：isExistsUniMP: 方法判断的仅是运行路径中是否有对应的应用资源，宿主还需要做好内置wgt版本的管理，如果更新了内置的wgt也应该执行 releaseAppResourceToRunPathWithAppid 方法应用最新的资源
    if (![DCUniMPSDKEngine isExistsUniMP:appid]) {
        // 读取导入到工程中的wgt应用资源
        if (!appResourcePath) {
            NSLog(@"资源路径不正确，请检查");
            return;
        }
        // 将应用资源部署到运行路径中
        NSError *error;
        if ([DCUniMPSDKEngine installUniMPResourceWithAppid:appid resourceFilePath:appResourcePath password:password error:&error]) {
            NSLog(@"小程序 %@ 应用资源文件部署成功，版本信息：%@",appid,[DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appid]);
        } else {
            NSLog(@"小程序 %@ 应用资源部署失败： %@",appid,error);
        }
    } else {
        NSLog(@"已存在小程序 %@ 应用资源，版本信息：%@",appid,[DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appid]);
    }
}



#pragma mark - DCUniMPSDKEngineDelegate
/// 胶囊按钮‘x’关闭按钮点击回调
- (void)closeButtonClicked:(NSString *)appid {
    NSLog(@"点击了 小程序 %@ 的关闭按钮",appid);
}

/// DCUniMPMenuActionSheetItem 点击触发回调方法
- (void)defaultMenuItemClicked:(NSString *)appid identifier:(NSString *)identifier {
    NSLog(@"标识为 %@ 的 item 被点击了", identifier);
    
    // 将小程序隐藏到后台
    if ([identifier isEqualToString:@"enterBackground"]) {
        __weak __typeof(self)weakSelf = self;
        [self.uniMPInstance hideWithCompletion:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"小程序 %@ 进入后台",weakSelf.uniMPInstance.appid);
            } else {
                NSLog(@"hide 小程序出错：%@",error);
            }
        }];
    }
    // 关闭小程序
    else if ([identifier isEqualToString:@"closeUniMP"]) {
        [self.uniMPInstance closeWithCompletion:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"小程序 closed");
            } else {
                NSLog(@"close 小程序出错：%@",error);
            }
        }];
    }
    // 向小程序发送消息
    else if ([identifier isEqualToString:@"SendUniMPEvent"]) {
        [self.uniMPInstance sendUniMPEvent:@"NativeEvent" data:@{@"msg":@"native message"}];
    }
}

/// 返回打开小程序时的自定义闪屏视图
- (UIView *)splashViewForApp:(NSString *)appid {
    UIView *splashView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    splashView.backgroundColor = UIColor.redColor;
    return splashView;
}

/// 小程序关闭回调方法
- (void)uniMPOnClose:(NSString *)appid {
    NSLog(@"小程序 %@ 被关闭了",appid);
    
    self.uniMPInstance = nil;
    
    // 可以在这个时机再次打开小程序
//    [self openUniMP:nil];
}


/// 小程序向原生发送事件回调方法
/// @param appid 对应小程序的appid
/// @param event 事件名称
/// @param data 数据：NSString 或 NSDictionary 类型
/// @param callback 回调数据给小程序
- (void)onUniMPEventReceive:(NSString *)appid event:(NSString *)event data:(id)data callback:(DCUniMPKeepAliveCallback)callback {
    NSLog(@"Receive UniMP:%@ event:%@ data:%@",appid,event,data);
    
    // 回传数据给小程序
    // DCUniMPKeepAliveCallback 用法请查看定义说明
    if (callback) {
        callback(@"native callback message",NO);
    }
}

#pragma mark - App 生命周期方法

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 配置参数
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
    // 设置 debug YES 会在控制台输出 js log，默认不输出 log，注：需要引入 liblibLog.a 库
    [options setObject:[NSNumber numberWithBool:YES] forKey:@"debug"];
    // 初始化引擎
    [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:options];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [DCUniMPSDKEngine destory];
}

#pragma mark - 如果需要使用 URL Scheme 或 通用链接相关功能，请实现以下方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 通过 url scheme 唤起 App
    [DCUniMPSDKEngine application:app openURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    // 通过通用链接唤起 App
    [DCUniMPSDKEngine application:application continueUserActivity:userActivity];
    return YES;
}

#pragma mark - 如需使用远程推送相关功能，请实现以下方法
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 远程通知注册成功，收到 deviceToken 调用sdk方法，传入 deviceToken
    [DCUniMPSDKEngine application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // 远程通知注册失败
    [DCUniMPSDKEngine application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // 收到远程推送消息
    [DCUniMPSDKEngine application:application didReceiveRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - 如需使用本地推送通知功能，请实现以下方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // 收到本地推送消息
    [DCUniMPSDKEngine application:application didReceiveLocalNotification:notification];
}


@end
