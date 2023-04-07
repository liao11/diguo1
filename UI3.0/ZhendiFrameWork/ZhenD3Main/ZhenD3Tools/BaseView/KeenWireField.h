
#import <UIKit/UIKit.h>
#import "YLAF_BaseTextField.h"
NS_ASSUME_NONNULL_BEGIN

@class KeenWireField;
@protocol KeenWireFieldDelegate <NSObject>
@optional

- (BOOL)zd32_InputTextFieldViewShouldReturn:(KeenWireField *)inputView;
- (void)zd32_InputTextFieldViewTextDidChange:(KeenWireField *)inputView;
@end

@interface KeenWireField : UIView

@property (nonatomic, assign) bool zd3_tel;
@property (nonatomic, strong) UIButton *blmg_telBtn;
@property (nonatomic, strong) UIImageView *zd32_fieldLeftIcon;
@property (nonatomic, strong) YLAF_BaseTextField *zd32_TextField;
@property (nullable, nonatomic, weak) id<KeenWireFieldDelegate> delegate;
- (void)zd32_setRightView:(UIView *)rightView;

@end

NS_ASSUME_NONNULL_END
