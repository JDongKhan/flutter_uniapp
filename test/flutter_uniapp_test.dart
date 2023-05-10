import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uniapp/flutter_uniapp_method_channel.dart';
import 'package:flutter_uniapp/flutter_uniapp_platform_interface.dart';

void main() {
  final FlutterUniappPlatform initialPlatform = FlutterUniappPlatform.instance;
  test('$MethodChannelFlutterUniapp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUniapp>());
  });
}
