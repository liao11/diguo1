
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3ResetPwd_View;
@protocol YLAH_ResetPwd_ViewDelegate <NSObject>

- (void)zd31_onClickCloseResetPwdView_Delegate:(ZhenD3ResetPwd_View *)resetPwdView isFromLogin:(BOOL)isFromLogin;
- (void)zd31_resetPwdSuccess_Delegate:(ZhenD3ResetPwd_View *)resetPwdView;
@end
@interface ZhenD3ResetPwd_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_ResetPwd_ViewDelegate> delegate;
@property (nonatomic, assign) BOOL isFromLogin;

@end

NS_ASSUME_NONNULL_END
