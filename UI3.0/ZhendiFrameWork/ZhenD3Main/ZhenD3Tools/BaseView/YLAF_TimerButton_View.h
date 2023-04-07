
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YLAF_TimerButton_View;
@protocol YLAF_TimerButton_ViewDelegate <NSObject>
@optional

- (BOOL)zd32_ClickedTimerButtonView:(YLAF_TimerButton_View *)view;
@end

@interface YLAF_TimerButton_View : UIView

@property (nonatomic, assign) NSTimeInterval zd32_TimeInterval;
@property (nonatomic, copy) NSString * zd32_BtnTitle;
@property (nullable, nonatomic, weak) id<YLAF_TimerButton_ViewDelegate> delegate;

- (void)zd32_ResetNormalSendStates;
@end

NS_ASSUME_NONNULL_END
