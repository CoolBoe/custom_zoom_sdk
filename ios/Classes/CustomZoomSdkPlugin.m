#import "CustomZoomSdkPlugin.h"
#if __has_include(<custom_zoom_sdk/custom_zoom_sdk-Swift.h>)
#import <custom_zoom_sdk/custom_zoom_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "custom_zoom_sdk-Swift.h"
#endif

@implementation CustomZoomSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCustomZoomSdkPlugin registerWithRegistrar:registrar];
}
@end
