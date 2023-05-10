import 'flutter_uniapp_platform_interface.dart';

class FlutterUniapp {
  static Future<bool?> initSDK() {
    return FlutterUniappPlatform.instance.initSDK();
  }

  static Future<bool?> openMini({String? remoteUrl, String? path}) {
    return FlutterUniappPlatform.instance
        .openMini(remoteUrl: remoteUrl, path: path);
  }
}
