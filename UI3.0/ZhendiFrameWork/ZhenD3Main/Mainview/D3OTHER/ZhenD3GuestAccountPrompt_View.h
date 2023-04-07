
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3GuestAccountPrompt_View;
@protocol YLAH_GuestAccountPrompt_ViewDelegate <NSObject>

- (void)zd31_HandleClosePromptView:(ZhenD3GuestAccountPrompt_View *)promptView;
- (void)zd31_HandleUpgrateFromPromptView:(ZhenD3GuestAccountPrompt_View *)promptView upgrateCompletion:(void(^)(void))completion;
@end

@interface ZhenD3GuestAccountPrompt_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_GuestAccountPrompt_ViewDelegate> delegate;
@property (nonatomic, copy, nullable) void(^zd31_HandleBeforeClosedView)(void);
@end

NS_ASSUME_NONNULL_END
