
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3ResponseObject_Entity;

@interface ZhenD3SDKMainView_Controller : UIView

+ (void)zd31_showLoginView;
+ (void)zd31_showAccountView;
+ (void)zd31_showCustomerServiceView;
+ (void)zd32_showRencentV;
+ (void)zd31_logoutAction;
+ (void)zd33_showModifyPwdV;
+ (void)zd33_showPresentV;
+ (void)zd32_showChongV;
+ (void)blmg_showTaskV;
+ (void)zd32_showCouponV;
+ (void)zd32_showConfirmV;
+ (void)zd33_showUpgradVCompletion:(void(^)(void))completion;
+ (void)zd33_showTieMailCompletion:(void(^)(void))completion;
+ (void)zd31_showMyShopV;
+ (void)zd32_showRencent2V;
+ (void)blmg_showMyAccV;
+ (void)zd32_showPersonInfoV;
+ (void)zd33_showBindTelCompletion:(void(^)(void))completion;
+ (void)zd33_showBindTelVWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId;
- (void)zd32_u_PushView:(UIView *)view fromView:(UIView *)parentView animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
