#import "IovationFlutterPlugin.h"
#if __has_include(<iovation_flutter/iovation_flutter-Swift.h>)
#import <iovation_flutter/iovation_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "iovation_flutter-Swift.h"
#endif

@implementation IovationFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIovationFlutterPlugin registerWithRegistrar:registrar];
}
@end
