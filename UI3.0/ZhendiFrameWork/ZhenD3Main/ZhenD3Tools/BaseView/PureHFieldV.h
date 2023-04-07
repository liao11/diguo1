
#import <UIKit/UIKit.h>
#import "YLAF_BaseTextField.h"
NS_ASSUME_NONNULL_BEGIN

@class PureHFieldV;
@protocol PureHFieldVDelegate <NSObject>
@optional

- (BOOL)zd32_HorizontalInputTextFieldViewShouldReturn:(PureHFieldV *)inputView;
- (void)zd32_HorizontalInputTextFieldViewTextDidChange:(PureHFieldV *)inputView;
@end

@interface PureHFieldV : UIView

@property (nonatomic, strong) UILabel *zd32_TitleLab;
@property (nonatomic, strong) YLAF_BaseTextField *zd32_TextField;
@property (nonatomic, assign) CGFloat zd32_FixedTitleWidth;
@property (nullable, nonatomic, weak) id<PureHFieldVDelegate> delegate;
- (void)zd32_setRightView:(UIView *)rightView;
@end

NS_ASSUME_NONNULL_END
