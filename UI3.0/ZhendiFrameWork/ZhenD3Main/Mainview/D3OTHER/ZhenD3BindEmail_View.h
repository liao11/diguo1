
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3BindEmail_View;
@protocol YLAH_BindEmail_ViewDelegate <NSObject>

- (void)zd31_handleClosedBindEmailView_Delegate:(ZhenD3BindEmail_View *)bindEmailView;
- (void)zd31_handleBindEmailSuccess_Delegate:(ZhenD3BindEmail_View *)bindEmailView;
@end

@interface ZhenD3BindEmail_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_BindEmail_ViewDelegate> delegate;
@property (nonatomic, assign) NSInteger zd31_fromFlags;
@property (nonatomic, copy, nullable) void(^zd31_HandleBeforeClosedView)(void);
@end

NS_ASSUME_NONNULL_END
