#import "CustomZoomSdkPlugin.h"
#import <custom_zoom_sdk/custom_zoom_sdk-Swift.h>

@implementation CustomZoomSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCustomZoomSdkPlugin registerWithRegistrar:registrar];
}
@end
