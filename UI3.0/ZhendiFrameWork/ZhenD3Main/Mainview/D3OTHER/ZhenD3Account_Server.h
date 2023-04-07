
#import "ZhenD3RemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3Account_Server : ZhenD3RemoteData_Server

- (void)zd31_RegisterAccountWithUserName:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode regType:(NSString *)regType responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_findAccount:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_SendFindAccountVerufy2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_SendRegisterVerify2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_ResetPwdWithBindEmail:(NSString *)email verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_SendBindEmailVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_BindEmail:(NSString *)email withVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_UpdateAndCommitGameRoleLevel:(NSUInteger)level responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_GetUserInfo:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_SendUpgradeVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_UpgradeAccount:(NSString *)email withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_ModifyPassword:(NSString *)password newPassword:(NSString *)newPassword reNewPassword:(NSString *)reNewPassword responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_GetAllPresent:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_GetPresent:(NSInteger)presentId responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_GetMyPresents:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_GetCustomerService:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_GetOrderListRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
- (void)zd31_GetNewsListRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
- (void)zd31_SendBindTelCodeRequestWithzd32_telNum:(NSString *)zd32_telNum zd3_telDist:(NSString *)zd3_telDist zd31_ut:(NSString *)zd31_ut responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
//账号升级发送验证码
- (void)zd31_SendUpgradeTelCodeRequestWithzd32_telNum:(NSString *)zd32_telNum zd3_telDist:(NSString *)zd3_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
//完成新手任务
- (void)zd31_sendFinishNewTaskRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
//优惠券列表
- (void)khxl_obtainCouponLsitWithzd3_lt:(NSInteger)zd3_lt responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
//保存优惠券
- (void)zd3_saveCouponLsitWithblmg_couponId:(NSInteger)blmg_couponId responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
//任务中心
- (void)lhxy_getTaskLsitRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
//币明细
- (void)zd3_getKionDetailRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

//手机注册
- (void)zd31_RegisterAccountWithTel:(NSString *)tel password:(NSString *)password verifyCode:(NSString *)verifyCode zd3_telDist:(NSString *)zd3_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

//签到
- (void)lhxy_userSignRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

//获取角色
- (void)lhxy_getUserRoleRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

//交换礼品？
- (void)lhxy_exchangePresentWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId Request:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

//手机绑定
- (void)zd31_bindMobileCodeRequestWithzd32_telNum:(NSString *)zd32_telNum zd3_telDist:(NSString *)zd3_telDist verifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

//修改手机密码
- (void)zd31_ResetPwdWithBindTel:(NSString *)tel verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword zd31_ut:(NSString *)zd31_ut zd3_telDist:(NSString *)zd3_telDist  responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_UpgradeAccountWithTel:(NSString *)tel withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode zd3_telDist:(NSString *)zd3_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_getGoodTypeRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_getGoodListWithblmg_goodType:(NSString *)blmg_goodType responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd32_delAccResponseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

@end

NS_ASSUME_NONNULL_END
