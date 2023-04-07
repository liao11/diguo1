
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN
@class ZhenD3PresentPackage_View;
@protocol YLAH_PresentPackage_ViewDelegate <NSObject>

- (void)zd31_HandleClosePresentPackageView_Delegate:(ZhenD3PresentPackage_View *)view;
@end

@interface ZhenD3PresentPackage_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_PresentPackage_ViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
