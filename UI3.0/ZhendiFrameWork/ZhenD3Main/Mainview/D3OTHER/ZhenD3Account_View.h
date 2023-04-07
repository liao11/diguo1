
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3Account_View;
@protocol YLAH_Account_ViewDelegate <NSObject>

- (void)zd31_handleCloseAccount_Delegate:(ZhenD3Account_View *)accountView;
- (void)zd31_handleAccount_Delegate:(ZhenD3Account_View *)accountView onClickBtn:(NSInteger)tag;
@end

@interface ZhenD3Account_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_Account_ViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
