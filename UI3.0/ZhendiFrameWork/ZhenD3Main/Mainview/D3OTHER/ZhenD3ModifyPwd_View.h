
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3ModifyPwd_View;
@protocol YLAH_ModifyPwd_ViewDelegate <NSObject>

- (void)zd31_HandleCloseModifyPwdView_Delegate:(ZhenD3ModifyPwd_View *)modifyPwdView;
@end

@interface ZhenD3ModifyPwd_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_ModifyPwd_ViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
