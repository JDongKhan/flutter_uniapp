import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_uniapp_platform_interface.dart';

/// An implementation of [FlutterUniappPlatform] that uses method channels.
class MethodChannelFlutterUniapp extends FlutterUniappPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_uniapp');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> initSDK() async {
    final result = await methodChannel.invokeMethod<bool>('initSDK');
    return result;
  }

  @override
  Future<bool?> openMini({String? remoteUrl, String? path}) async {
    final result = await methodChannel.invokeMethod<bool>('openMini', {
      'remoteUrl': remoteUrl,
      'path': path,
    });
    return result;
  }
}
