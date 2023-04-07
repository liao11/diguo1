
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3PersonalCenter_View;
@protocol YLAH_PersonalCenter_ViewDelegate <NSObject>

- (void)zd31_handleClosePersonalCenter_Delegate:(ZhenD3PersonalCenter_View *)personalCenter;
- (void)zd31_handleBindEmailInPersonalCenter_Delegate:(ZhenD3PersonalCenter_View *)personalCenter;
@end

@interface ZhenD3PersonalCenter_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_PersonalCenter_ViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
