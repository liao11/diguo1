
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3AccountLogin_View,ZhenD3ResponseObject_Entity;
@protocol YLAH_AccountLogin_ViewDelegate <NSObject>

- (void)zd33_CloseAccountLoginView:(ZhenD3AccountLogin_View *)accountLoginView loginSucess:(BOOL)success;
- (void)zd33_ForgetPwdAtLoginView:(ZhenD3AccountLogin_View *)accountLoginView;
@end

@interface ZhenD3AccountLogin_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_AccountLogin_ViewDelegate> delegate;
- (void)zd31_HiddenHistoryTable;
@end

NS_ASSUME_NONNULL_END
