#include "include/imgy/imgy_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "imgy_plugin.h"

void ImgyPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  imgy::ImgyPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
