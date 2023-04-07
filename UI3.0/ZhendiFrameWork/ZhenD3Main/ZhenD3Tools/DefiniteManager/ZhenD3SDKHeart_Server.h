
#import "ZhenD3RemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN

#define MYMGSDKHeart [ZhenD3SDKHeart_Server sharedInstance]

@interface ZhenD3SDKHeart_Server : ZhenD3RemoteData_Server

+ (instancetype)sharedInstance;

- (void)zd32_startRefreshTokenTimer;
- (void)zd32_stopRefreshTokenTimer;
- (void)zd32_startSDKHeartBeat;
- (void)zd32_stopSDKHeartBeat;

@end

NS_ASSUME_NONNULL_END
