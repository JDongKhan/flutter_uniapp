// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_uniapp_platform_interface.dart';

/// A web implementation of the FlutterUniappPlatform of the FlutterUniapp plugin.
class FlutterUniappWeb extends FlutterUniappPlatform {
  /// Constructs a FlutterUniappWeb
  FlutterUniappWeb();

  static void registerWith(Registrar registrar) {
    FlutterUniappPlatform.instance = FlutterUniappWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<bool?> initSDK() {
    throw UnimplementedError('initSDK() has not been implemented.');
  }

  @override
  Future<bool?> openMini({String? remoteUrl, String? path}) {
    throw UnimplementedError('openMini() has not been implemented.');
  }
}
