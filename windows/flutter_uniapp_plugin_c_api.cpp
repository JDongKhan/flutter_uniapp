#include "include/flutter_uniapp/flutter_uniapp_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_uniapp_plugin.h"

void FlutterUniappPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_uniapp::FlutterUniappPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
