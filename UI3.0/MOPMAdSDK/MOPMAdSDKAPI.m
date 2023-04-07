
#import "MOPMAdSDKAPI.h"
#import <AdTimingSDK/AdTimingSDK.h>
#import "MOPM_AdConstant_Define.h"

@interface MOPMAdSDKAPI () <AdTimingRewardedVideoDelegate>

@property (nonatomic, copy) NSString *zd31_ShowAdId;
@end

@implementation MOPMAdSDKAPI

- (instancetype)init {
    self = [super init];
    if (self) {
        [[AdTimingRewardedVideo sharedInstance] addDelegate:self];
    }
    return self;
}


- (void)adtimingRewardedVideoChangedAvailability:(BOOL)available {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoChangedAvailability:available];
    }
}

- (void)adtimingRewardedVideoDidOpen:(AdTimingScene*)scene {
    [ZhenD3OpenAPI zd3_setShortCutHidden:YES];
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidOpen:[self zd32_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoPlayStart:(AdTimingScene*)scene {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoPlayStart:[self zd32_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoPlayEnd:(AdTimingScene*)scene {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoPlayEnd:[self zd32_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidClick:(AdTimingScene*)scene {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidClick:[self zd32_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidReceiveReward:(AdTimingScene*)scene {
//    if (self.zd31_ShowAdId && self.zd31_ShowAdId.length > 0) {
//        [ZhenD3OpenAPI zd3_sdkRequestPath:zd32_rcpUprewordAdPath parameters:@{zd32_ckeyUpRewardAdId : self.zd31_ShowAdId?:@""} responseBlock:^(DiGResponseObject_Entity * _Nonnull result) {
//        }];
//    }
//    
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidReceiveReward:[self zd32_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidClose:(AdTimingScene*)scene {
    [ZhenD3OpenAPI zd3_setShortCutHidden:NO];
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidClose:[self zd32_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidFailToShow:(AdTimingScene*)scene withError:(NSError *)error {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidFailToShow:[self zd32_u_AdSceneWithAdTimingScene:scene] withError:error];
    }
}

- (MOPM_AdScene_Entity *)zd32_u_AdSceneWithAdTimingScene:(AdTimingScene *)scene {
    if (scene) {
        MOPM_AdScene_Entity *zd31_scene = [[MOPM_AdScene_Entity alloc] init];
        zd31_scene.adId = scene.sceneName;
        zd31_scene.originData = scene.originData;
        return zd31_scene;
    }
    return nil;
}
+ (instancetype)SharedInstance {
    static MOPMAdSDKAPI* shareApi = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareApi = [[self alloc] init];
    });
    return shareApi;
}

+ (void)initSDKWithAppKey:(NSString *)appKey {
    [AdTiming initWithAppKey:appKey];
}


+ (void)showRewardVideoAd:(NSString*)adId inViewController:(UIViewController *)viewController {
    if ([[AdTimingRewardedVideo sharedInstance] isReady]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MOPMAdSDKAPI SharedInstance].zd31_ShowAdId = adId;
            [[AdTimingRewardedVideo sharedInstance] showWithViewController:viewController scene:adId];
        });
    } else {
        
    }
}

@end
