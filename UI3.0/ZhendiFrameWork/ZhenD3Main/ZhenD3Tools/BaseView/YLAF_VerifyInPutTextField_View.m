
#import "YLAF_VerifyInPutTextField_View.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_Helper_Utils.h"
#import "UIView+GrossExtension.h"
#import "YLAF_TimerButton_View.h"

@interface YLAF_VerifyInPutTextField_View () <UITextFieldDelegate, YLAF_TimerButton_ViewDelegate>

@property (nonatomic, strong) UIView *zd32_TextFieldBgView;
@property (nonatomic, strong) YLAF_TimerButton_View *zd32_TimerButton;
@property (nonatomic, strong) UIView *blmg_rightView;
@end

@implementation YLAF_VerifyInPutTextField_View

- (void)dealloc {
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zd32_SetupDefaultViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self zd32_SetupDefaultViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _blmg_rightView.blmg_centerY = _zd32_TextFieldBgView.blmg_centerY;
    _blmg_rightView.blmg_right = _zd32_TextFieldBgView.blmg_width - 5;
    _zd32_TextField.blmg_width = _zd32_TextFieldBgView.blmg_width - 45 - _blmg_rightView.blmg_width;
}

- (void)zd32_SetupDefaultViews {
    
    self.zd32_TextFieldBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.blmg_width, self.blmg_height)];
    self.zd32_TextFieldBgView.backgroundColor = [YLAF_Theme_Utils khxl_color_MaskInputColor];
    self.zd32_TextFieldBgView.layer.borderColor =  [YLAF_Theme_Utils khxl_color_LineColor].CGColor;
    self.zd32_TextFieldBgView.layer.borderWidth = YLAF_1_PIXEL_SIZE;
    self.zd32_TextFieldBgView.layer.cornerRadius = 20.0;
    self.zd32_TextFieldBgView.layer.masksToBounds = YES;
    [self addSubview:self.zd32_TextFieldBgView];
    
    self.zd32_fieldLeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(18, 12, 16, 16)];
    [self.zd32_TextFieldBgView addSubview:self.zd32_fieldLeftIcon];
    
    self.zd32_TextField = [[YLAF_BaseTextField alloc] initWithFrame:CGRectMake(43, 2, self.zd32_TextFieldBgView.blmg_width-45, self.zd32_TextFieldBgView.blmg_height-4)];
    self.zd32_TextField.delegate = self;
    self.zd32_TextField.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.zd32_TextField.placeholderColor = [YLAF_Theme_Utils khxl_textPlaceholderColor];
    self.zd32_TextField.textColor = [YLAF_Theme_Utils khxl_color_DarkGrayColor];
    [self.zd32_TextField addTarget:self action:@selector(zd32_TextFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.zd32_TextFieldBgView addSubview:self.zd32_TextField];
    
    self.zd32_TimerButton = [[YLAF_TimerButton_View alloc] initWithFrame:CGRectMake(0, 0, 77, self.blmg_height)];
    self.zd32_TimerButton.zd32_BtnTitle = MUUQYLocalizedString(@"MUUQYKey_SendButton_Text");
    self.zd32_TimerButton.delegate = self;
    [self zd32_setRightView:self.zd32_TimerButton];
}

- (void)zd32_setRightView:(UIView *)rightView {
    if (![self.subviews containsObject:rightView]) {
        self.blmg_rightView = rightView;
        [self addSubview:rightView];
    }
    
    rightView.blmg_centerY = _zd32_TextFieldBgView.blmg_centerY;
    rightView.blmg_right = _zd32_TextFieldBgView.blmg_width - 5;
    _zd32_TextField.blmg_width = _zd32_TextFieldBgView.blmg_width - 45 - rightView.blmg_width;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"] && object == self.zd32_TextField) {
        NSString *newText = change[NSKeyValueChangeNewKey];
        NSString *oldText = change[NSKeyValueChangeOldKey];
        if (newText && oldText) {
            if ([newText isEqualToString:oldText] == NO) {
                if (newText.length == 0) {
                    [self zd32_u_SetNodataNotActionStateLayout];
                } else if (oldText.length == 0) {
                    [self zd32_u_SetActiveOrHasDataStateLayout];
                }
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)zd32_SetInputCornerRadius:(CGFloat)cornerRadius {
    self.zd32_TextFieldBgView.layer.cornerRadius = cornerRadius;
}

- (void)zd32_ResetNormalSendStates {
    [_zd32_TimerButton zd32_ResetNormalSendStates];
}

- (void)zd32_u_SetNodataNotActionStateLayout {
}

- (void)zd32_u_SetActiveOrHasDataStateLayout {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_VerifyInputTextFieldViewShouldReturn:)]) {
        return [_delegate zd32_VerifyInputTextFieldViewShouldReturn:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self zd32_u_SetActiveOrHasDataStateLayout];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self zd32_u_SetNodataNotActionStateLayout];
    }
}

- (void)zd32_TextFieldTextDidChange:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_VerifyInputTextFieldViewTextDidChange:)]) {
        [_delegate zd32_VerifyInputTextFieldViewTextDidChange:self];
    }
}


- (BOOL)zd32_ClickedTimerButtonView:(YLAF_TimerButton_View *)view {
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_HandleSendVerifyCode:)]) {
        return [_delegate zd32_HandleSendVerifyCode:self];
    }
    return YES;
}

@end
