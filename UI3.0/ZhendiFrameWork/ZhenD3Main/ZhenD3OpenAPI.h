
#import <UIKit/UIKit.h>

#import "ZhenD3SDKConfig_Entity.h"
#import "ZhenD3ResponseObject_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZhenD3OpenAPIDelegate <NSObject>
@optional

- (void)zd3_initialSDKFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_loginFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_enterGameFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_logoutFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_deleteFinished:(ZhenD3ResponseObject_Entity *)response;

- (void)zd3_registerServerInfoFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_commitGameRoleLevelFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_getPurchaseProducesFinished:(ZhenD3ResponseObject_Entity *)response;

- (void)zd3_startPurchaseProduceOrderFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_checkOrderAppleReceiptFinished:(ZhenD3ResponseObject_Entity *)response;
- (void)zd3_checkPresentFinish:(ZhenD3ResponseObject_Entity *)response;

@end

#define YLMXGSDKAPI [ZhenD3OpenAPI SharedInstance]

@class ZhenD3UserInfo_Entity, ZhenD3GameInfo_Entity, ZhenD3CPPurchaseOrder_Entity;
@interface ZhenD3OpenAPI : NSObject
@property (nonatomic, weak) id<ZhenD3OpenAPIDelegate> delegate;
@property (nonatomic, strong, nullable) UIViewController *context;
@property (nonatomic, assign) YLAF_Language zd3_localizedLanguage;
@property (nonatomic, assign) BOOL blmg_tiePresent;
@property (nonatomic, strong, nullable, readonly) ZhenD3UserInfo_Entity *userInfo;
@property (nonatomic, strong, nullable, readonly) ZhenD3GameInfo_Entity *gameInfo;
@property (nonatomic, readonly) NSString *zd3_SDKVersion;
+ (instancetype)SharedInstance;
+ (void)zd3_openDevLog:(BOOL)isOpen;
+ (void)zd3_launchSDKWithConfig:(ZhenD3SDKConfig_Entity *)config application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;
+ (void)zd3_initialSDK;
+ (void)activateApp;
+ (void)zd3_completeNoviceTask;
//
// cdn 开始
+ (void)zd3_begincdnTask;
// cdn 结束
+ (void)zd3_finishcdnTask;
// 新手引导开始
+ (void)zd3_beginNoviceTask;

+ (void)zd3_setShortCutHidden:(BOOL)hidden;
+ (void)blmg_obtainPresentWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId;
+ (void)zd3_firebaseEventWithName:(NSString *)name parameters:(nullable NSDictionary<NSString *, id> *)parameters;
+ (void)zd3_adjustEventWithEventToken:(NSString *)eventToken parameters:(nullable NSDictionary<NSString *, id> *)parameters;
#pragma mark - 游戏 API
+ (void)showLoginView;
+ (void)logout:(BOOL)showAlertView;
+ (void)zd3_enterGameIntoServerId:(NSString *)serverId
                   serverName:(NSString *)serverName
                   withRoleId:(NSString *)roleId
                     roleName:(NSString *)roleName
                 andRoleLevel:(NSUInteger)roleLevel;
+ (void)zd3_updateAndCommitGameRoleLevel:(NSUInteger)level;
+ (BOOL)zd3_clearAllHistoryAccounts;
+ (void)zd3_delete:(BOOL)showAlertView;
#pragma mark - Purchase API
+ (void)zd3_getPurchaseProduces;
+ (void)zd3_startPurchaseProduceOrder:(ZhenD3CPPurchaseOrder_Entity *)purchaseOrder;

#pragma mark - Req SDK
+ (void)zd3_sdkRequestPath:(NSString *)path parameters:(NSDictionary *)parameters responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
@end

NS_ASSUME_NONNULL_END
