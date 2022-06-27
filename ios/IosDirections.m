#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(IosDirections, NSObject)

RCT_EXTERN_METHOD(getDirections:(double)originLatitude
                  withOriginLongitude:(double)originLongitude
                  withDestinationLatitude:(double)destinationLatitude
                  withDestinationLongitude:(double)destinationLongitude
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
