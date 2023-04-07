
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZhenD3AutoLogin_View,ZhenD3UserInfo_Entity;
@protocol YLAH_AutoLogin_ViewDelegate <NSObject>

- (void)zd33_FastAutLoginView:(ZhenD3AutoLogin_View *)autoLoginView loginSucess:(BOOL)success;

@end

@interface ZhenD3AutoLogin_View : UIView

@property (nonatomic, weak) id<YLAH_AutoLogin_ViewDelegate> delegate;

- (void)zd31_AutoLoginWithLastLoginUser:(ZhenD3UserInfo_Entity *)lastLoginUser;
@end

NS_ASSUME_NONNULL_END
