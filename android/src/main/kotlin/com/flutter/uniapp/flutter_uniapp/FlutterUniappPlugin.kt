package com.flutter.uniapp.flutter_uniapp

import android.content.Context
import androidx.annotation.NonNull
import com.flutter.uniapp.flutter_uniapp.uniapp.UniAppManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterUniappPlugin */
class FlutterUniappPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_uniapp")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "initSDK") {
      UniAppManager.initSDK(context)
      result.success(true)
    } else if  (call.method == "openMini") {
      val param = call.arguments as Map<*, *>
      val remoteUrl = param["remoteUrl"]?.toString()
      val path = param["path"]?.toString()
      val password = param["password"]?.toString()
      if (remoteUrl != null && remoteUrl.isNotEmpty()) {
        UniAppManager.openRemoteMini(context, remoteUrl, password,path)
      } else {
        UniAppManager.openMini(context,path)
      }
      result.success(true)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
