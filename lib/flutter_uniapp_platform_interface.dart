import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_uniapp_method_channel.dart';

abstract class FlutterUniappPlatform extends PlatformInterface {
  /// Constructs a FlutterUniappPlatform.
  FlutterUniappPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUniappPlatform _instance = MethodChannelFlutterUniapp();

  /// The default instance of [FlutterUniappPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUniapp].
  static FlutterUniappPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUniappPlatform] when
  /// they register themselves.
  static set instance(FlutterUniappPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> initSDK() {
    throw UnimplementedError('initSDK() has not been implemented.');
  }

  Future<bool?> openMini({String? remoteUrl, String? password, String? path}) {
    throw UnimplementedError('openMini() has not been implemented.');
  }
}
