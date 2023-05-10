import Flutter
import UIKit

public class FlutterUniappPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_uniapp", binaryMessenger: registrar.messenger())
    let instance = FlutterUniappPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
 
      if (call.method == "initSDK") {
          FlutterUniAppManager.shared().initSDK()
          result(true)
      } else if (call.method == "openMini"){
          let map:Dictionary<String,Any>? = call.arguments as? Dictionary<String,Any>
          let remoteUrl:String? = map?["remoteUrl"] as? String
          let path:String? = map?["path"] as? String
          let password:String? = map?["password"] as? String
          FlutterUniAppManager.shared().openMini(remoteUrl, password:password,path: path)
          result(true)
      }

  }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        FlutterUniAppManager.shared().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        FlutterUniAppManager.shared().applicationDidBecomeActive(application)
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        FlutterUniAppManager.shared().applicationWillResignActive(application)
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        FlutterUniAppManager.shared().applicationDidEnterBackground(application)
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        FlutterUniAppManager.shared().applicationWillEnterForeground(application)
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        FlutterUniAppManager.shared().applicationWillTerminate(application)
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return FlutterUniAppManager.shared().application(application, open: url,options:options)
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]) -> Void) -> Bool {
        return FlutterUniAppManager.shared().application(application, continue: userActivity) { restoring in
            restorationHandler(restoring ?? [])
        }
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FlutterUniAppManager.shared().application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        FlutterUniAppManager.shared().application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        FlutterUniAppManager.shared().application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        return true
    }
    
}
