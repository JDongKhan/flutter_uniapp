import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uniapp/flutter_uniapp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FlutterUniapp.initSDK();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            child: const Text('打开小程序'),
            onPressed: () {
              FlutterUniapp.openMini(
                  remoteUrl:
                      'https://native-res.dcloud.net.cn/unimp-sdk/__UNI__7AEA00D.wgt',
                  path: '');
            },
          ),
        ),
      ),
    );
  }
}
