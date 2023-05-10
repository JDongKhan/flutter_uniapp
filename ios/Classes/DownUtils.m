//
//  DownUtils.m
//  flutter_uniapp
//
//  Created by sn on 2023/5/10.
//

#import "DownUtils.h"

@implementation DownUtils


+ (void)downFile:(NSString *)remoteUrl  success:(void(^)(NSString *path))successBlock{
    NSString *fileName = remoteUrl.lastPathComponent;
    NSString *appId = [fileName stringByDeletingPathExtension];
    //在沙盒中得存储路径
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [str stringByAppendingPathComponent:@"miniApp"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if(![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:path]){
        successBlock(path);
        return;
    }
    // 下载地址
    NSURL *url = [NSURL URLWithString:remoteUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        //////  因为任务下载是存在沙盒的temp文件中，并且下载完成后会被立即清除，所以这里将下载的文件剪切到caches中
        // location : 临时文件的路径（下载好的文件）
//        NSString *cacheStr = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
//        NSString *path = [cacheStr stringByAppendingPathComponent:response.suggestedFilename];
//
        // 将临时文件剪切或者复制Caches文件夹
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // AtPath : 剪切前的文件路径
        // ToPath : 剪切后的文件路径
        [mgr moveItemAtPath:location.path toPath:path error:nil];
        successBlock(path);
    }];
    
    // 开始任务
    [task resume];
}

@end
