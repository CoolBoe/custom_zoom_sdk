package com.phoeniixx.custom_zoom_sdk;
import io.flutter.plugin.common.PluginRegistry.Registrar;
/** CustomZoomSdkPlugin */
public class CustomZoomSdkPlugin {

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    registrar.platformViewRegistry().registerViewFactory("custom_zoom_sdk", new ZoomViewHandler(registrar.messenger()));
  }
}
