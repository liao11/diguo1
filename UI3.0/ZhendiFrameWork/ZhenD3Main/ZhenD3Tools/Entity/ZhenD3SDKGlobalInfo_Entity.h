
#import <UIKit/UIKit.h>
#import "ZhenD3GameInfo_Entity.h"
#import "ZhenD3UserInfo_Entity.h"
#import "ZhenD3SDKConfig_Entity.h"
#import "ZhenD3ResponseObject_Entity.h"
#import "ZhenD3TelDataServer.h"
#define MYMGSDKGlobalInfo [ZhenD3SDKGlobalInfo_Entity SharedInstance]

typedef NS_OPTIONS(NSUInteger, YLAF_SDKFlagOptions) {
    YLAF_SDKFlagNone         = 0,
    YLAF_SDKFlagFB           = 1 << 0, 
    YLAF_SDKFlagApple        = 1 << 1, 
    YLAF_SDKFlagShortcut     = 1 << 2, 
    YLAF_SDKFlagBindemail    = 1 << 3, 
    YLAF_SDKFlagHeart        = 1 << 4,
    YLAF_SDKFlagCoup         = 1 << 5,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3SDKGlobalInfo_Entity : NSObject

@property (nonatomic, strong) ZhenD3GameInfo_Entity *gameInfo;
@property (nonatomic, strong) ZhenD3UserInfo_Entity *userInfo;
@property (nonatomic, strong) NSSet<NSString *> * productIdentifiers;
@property (nonatomic, strong) NSString *customorSeviceMail;
@property (nonatomic, strong) NSArray *purchaseProduces;
@property (nonatomic, strong) ZhenD3AdjustConfig_Entity *adjustConfig;
@property (nonatomic, assign) YLAF_SDKServer sdkConnectServer;

@property (nonatomic, assign) BOOL sdkIsLogin;
@property (nonatomic, assign) BOOL lastWayLogin;
@property (nonatomic, assign) BOOL iszd3_openDevLog;
@property (nonatomic, assign) BOOL isEnterGame;
@property (nonatomic, assign) BOOL isShowedLoginView;

@property (nonatomic, assign) BOOL zd31_GvCheck;
@property (nonatomic, assign) YLAF_SDKFlagOptions zd32_sdkFlag;
@property (nonatomic, assign) NSInteger lightState;

@property (nonatomic, copy) NSString *login_agree;
@property (nonatomic, copy) NSString *reg_agree;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *notice;

- (UIViewController *)zd32_CurrentVC;

+ (instancetype)SharedInstance;
- (void)zd32_parserUserInfoFromResponseResult:(NSDictionary *)result;
- (void)blmg_parserTelInfoFromResponseResult:(NSDictionary *)result;
- (void)clearUselessInfo;

- (void)zd32_PresendWithUrlString:(NSString *)URLString;
- (void)zd32_SendEmail:(NSString *)email;
@end

NS_ASSUME_NONNULL_END
