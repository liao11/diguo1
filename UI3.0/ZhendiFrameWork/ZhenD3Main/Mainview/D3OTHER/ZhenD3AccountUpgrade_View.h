
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3AccountUpgrade_View;
@protocol YLAH_AccountUpgrade_ViewDelegate <NSObject>

- (void)zd31_HandleDismissAccountUpgradeView_Delegate:(ZhenD3AccountUpgrade_View *)accountUpgradeView;
- (void)zd31_HandlePopAccountUpgradeView_Delegate:(ZhenD3AccountUpgrade_View *)accountUpgradeView;
@end

@interface ZhenD3AccountUpgrade_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_AccountUpgrade_ViewDelegate> delegate;
@property (nonatomic, copy, nullable) void(^zd31_HandleBeforeClosedView)(void);
@end

NS_ASSUME_NONNULL_END
