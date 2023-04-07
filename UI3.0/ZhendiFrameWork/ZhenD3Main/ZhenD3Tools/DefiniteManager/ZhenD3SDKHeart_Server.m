
#import "ZhenD3SDKHeart_Server.h"
#import "YLAF_WeakProxy_Utils.h"
#import "ZhenD3OpenAPI.h"
#import "YLAF_Helper_Utils.h"

@interface ZhenD3SDKHeart_Server ()
{
    NSTimer *zd32_RefreshTokenTimer;
    NSTimer *zd32_heartBeatTimer;
    NSDate  *zd32_heartBeatStartDate;
}

@end

@implementation ZhenD3SDKHeart_Server

+ (instancetype)sharedInstance {
    static ZhenD3SDKHeart_Server* shareHeart = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareHeart = [[self alloc] init];
    });
    return shareHeart;
}

- (void)dealloc {
    [self zd32_stopSDKHeartBeat];
    [self zd32_stopRefreshTokenTimer];
}

- (void)zd32_startRefreshTokenTimer {
    [self zd32_stopRefreshTokenTimer];
    
    zd32_RefreshTokenTimer = [NSTimer scheduledTimerWithTimeInterval:5*60
                                                              target:[YLAF_WeakProxy_Utils proxyWithTarget:self]
                                                            selector:@selector(zd32_doRefreshTokenAction:)
                                                            userInfo:nil
                                                             repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:zd32_RefreshTokenTimer forMode:NSRunLoopCommonModes];
    [zd32_RefreshTokenTimer fire];
}

- (void)zd32_stopRefreshTokenTimer {
    if (zd32_RefreshTokenTimer != nil) {
        if (zd32_RefreshTokenTimer.isValid) {
            [zd32_RefreshTokenTimer invalidate];
        }
        zd32_RefreshTokenTimer = nil;
    }
}
- (void)zd32_startSDKHeartBeat {
    zd32_heartBeatStartDate = [NSDate date];
    
    [self zd32_startSDKHeartBeatWithTimeInterval:60];
}

- (void)zd32_startSDKHeartBeatWithTimeInterval:(NSTimeInterval)heartBeatTi {
    [self zd32_stopSDKHeartBeat];
    
    zd32_heartBeatTimer = [NSTimer timerWithTimeInterval:heartBeatTi
                                                  target:[YLAF_WeakProxy_Utils proxyWithTarget:self]
                                                selector:@selector(zd32_doHeartBeatAction:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:zd32_heartBeatTimer forMode:NSRunLoopCommonModes];
    [zd32_heartBeatTimer fire];
}

- (void)zd32_stopSDKHeartBeat {
    if (zd32_heartBeatTimer != nil) {
        if (zd32_heartBeatTimer.isValid) {
            [zd32_heartBeatTimer invalidate];
        }
        zd32_heartBeatTimer = nil;
    }
}

- (void)zd32_doRefreshTokenAction:(NSTimer *)timer {
    MYMGLog(@"RefreshToken～ 间隔 = %f", timer.timeInterval);
    [self zd32_RefreshToken:^(ZhenD3ResponseObject_Entity * _Nonnull result) {}];
}

- (void)zd32_doHeartBeatAction:(NSTimer *)timer {
    NSTimeInterval durationHeartBeat = [NSDate date].timeIntervalSince1970 - zd32_heartBeatStartDate.timeIntervalSince1970;
    MYMGLog(@"心跳蹦～ 持续时间 = %f, 间隔 = %f", durationHeartBeat, timer.timeInterval);
    if (timer.timeInterval == 1*60 && ABS(durationHeartBeat) >= 5*60) {
        [self zd32_startSDKHeartBeatWithTimeInterval:5*60];
    } else {
        [self zd32_keepSDKHeartBeat:^(ZhenD3ResponseObject_Entity *result) {}];
    }
}


- (void)zd32_keepSDKHeartBeat:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    [params setObject:MYMGSDKGlobalInfo.gameInfo.sessionID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySessionID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.chServerID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyServiceID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.chRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRoleID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRoleID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleName]];
    [params setObject:@(MYMGSDKGlobalInfo.gameInfo.cpRoleLevel).stringValue forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleLevel]];
    
    [self zd32_SetDeviceInfosIntoParams:params];

    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpHeartbeatPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

@end
