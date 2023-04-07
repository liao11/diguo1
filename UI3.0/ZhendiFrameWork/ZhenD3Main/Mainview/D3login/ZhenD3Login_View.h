
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3Login_View;

@protocol YLAH_Login_ViewDelegate <NSObject>

- (void)zd33_CloseLoginView:(ZhenD3Login_View *)loginView loginSucess:(BOOL)success;
- (void)zd33_RegisterAtLoginView:(ZhenD3Login_View *)loginView;
- (void)zd33_PushAccountLoginView:(ZhenD3Login_View *)loginView;
- (void)zd33_CloseAccountLoginView:(ZhenD3Login_View *)accountLoginView loginSucess:(BOOL)success;
- (void)zd33_ForgetPwdAtLoginView:(ZhenD3Login_View *)accountLoginView;

@end
@interface ZhenD3Login_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_Login_ViewDelegate> delegate;

- (void)zd31_HiddenHistoryTable;

@end

NS_ASSUME_NONNULL_END
