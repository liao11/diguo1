
#import <UIKit/UIKit.h>
#import "YLAF_BaseTextField.h"
NS_ASSUME_NONNULL_BEGIN

@class YLAF_VerifyInPutTextField_View;
@protocol YLAF_VerifyInputTextFieldDelegate <NSObject>
@optional

- (BOOL)zd32_VerifyInputTextFieldViewShouldReturn:(YLAF_VerifyInPutTextField_View *)inputView;
- (void)zd32_VerifyInputTextFieldViewTextDidChange:(YLAF_VerifyInPutTextField_View *)inputView;
- (BOOL)zd32_HandleSendVerifyCode:(YLAF_VerifyInPutTextField_View *)inputView;
@end

@interface YLAF_VerifyInPutTextField_View : UIView

@property (nonatomic, strong) UIImageView *zd32_fieldLeftIcon;
@property (nonatomic, strong) YLAF_BaseTextField *zd32_TextField;
@property (nullable, nonatomic, weak) id<YLAF_VerifyInputTextFieldDelegate> delegate;
- (void)zd32_SetInputCornerRadius:(CGFloat)cornerRadius;
- (void)zd32_ResetNormalSendStates;
@end

NS_ASSUME_NONNULL_END
