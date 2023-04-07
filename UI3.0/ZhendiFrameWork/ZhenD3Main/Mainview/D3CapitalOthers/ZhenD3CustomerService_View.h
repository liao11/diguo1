
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN
@class ZhenD3CustomerService_View;
@protocol YLAH_CustomerService_ViewDelegate <NSObject>

- (void)zd31_HandleCloseCustomerServiceView_Delegate:(ZhenD3CustomerService_View *)accountView;
@end

@interface ZhenD3CustomerService_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_CustomerService_ViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
