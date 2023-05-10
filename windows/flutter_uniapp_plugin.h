#ifndef FLUTTER_PLUGIN_FLUTTER_UNIAPP_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_UNIAPP_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_uniapp {

class FlutterUniappPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterUniappPlugin();

  virtual ~FlutterUniappPlugin();

  // Disallow copy and assign.
  FlutterUniappPlugin(const FlutterUniappPlugin&) = delete;
  FlutterUniappPlugin& operator=(const FlutterUniappPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_uniapp

#endif  // FLUTTER_PLUGIN_FLUTTER_UNIAPP_PLUGIN_H_
