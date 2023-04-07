
#import "ZhenD3RemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3Login_Server : ZhenD3RemoteData_Server

- (void)lhxy_InitSDK:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_DeviceActivate:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_DeviceActivate:(NSString *)username md5Password:(NSString *)password responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_QuickLogin:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_FacebookLogin:(void(^)(void))showHubBlock responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_VerifySignInWithApple:(NSString *)userId email:(NSString *)email authorizationCode:(NSString *)authorizationCode identityToken:(NSString *)identityToken responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_Logout:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
- (void)lhxy_Delte:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_EnterGame:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

//手机登录
- (void)lhxy_telLogin:(NSString *)username md5Password:(NSString *)password zd32_telDist:(NSString *)zd32_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)lhxy_tiePresentWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId Request:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

@end

NS_ASSUME_NONNULL_END
