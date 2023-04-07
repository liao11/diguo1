
#import "KeenWireField.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"
#import <objc/runtime.h>
#import "YLAF_Helper_Utils.h"
@interface KeenWireField () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *zd32_TextFieldBgView;
@property (nonatomic, strong) UIView *blmg_rightView;
@end

@implementation KeenWireField

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zd32_SetupDefaultViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
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
    
    self.zd32_TextFieldBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.blmg_width, 40)];
    self.zd32_TextFieldBgView.backgroundColor = [YLAF_Theme_Utils khxl_color_MaskInputColor];
    self.zd32_TextFieldBgView.layer.borderColor =  [YLAF_Theme_Utils khxl_color_LineColor].CGColor;
    self.zd32_TextFieldBgView.layer.borderWidth = YLAF_1_PIXEL_SIZE;
    self.zd32_TextFieldBgView.layer.cornerRadius = 20.0;
    self.zd32_TextFieldBgView.layer.masksToBounds = YES;
    [self addSubview:self.zd32_TextFieldBgView];
    
    self.zd32_TextField = [[YLAF_BaseTextField alloc] initWithFrame:CGRectMake(43, 2, self.zd32_TextFieldBgView.blmg_width-45, self.zd32_TextFieldBgView.blmg_height-4)];
    self.zd32_TextField.delegate = self;
    self.zd32_TextField.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.zd32_TextField.placeholderColor = [YLAF_Theme_Utils khxl_textPlaceholderColor];
    self.zd32_TextField.textColor = [YLAF_Theme_Utils khxl_color_DarkGrayColor];
    [self.zd32_TextField addTarget:self action:@selector(zd32_TextFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.zd32_TextFieldBgView addSubview:self.zd32_TextField];
    
    self.zd32_fieldLeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(18, 12, 16, 16)];
    [self.zd32_TextFieldBgView addSubview:self.zd32_fieldLeftIcon];
    
    self.blmg_telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.blmg_telBtn.frame = CGRectMake(18, 12, 16, 16);
    [self.blmg_telBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_nowDist") forState:UIControlStateNormal];
    [self.blmg_telBtn setTitleColor:[YLAF_Theme_Utils khxl_color_ButtonColor] forState:UIControlStateNormal];
    [self.blmg_telBtn addTarget:self action:@selector(zd33_telClick) forControlEvents:UIControlEventTouchUpInside];
    self.blmg_telBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_SmallFont];
    [self.zd32_TextFieldBgView addSubview:self.blmg_telBtn];
    self.blmg_telBtn.hidden = true;
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

- (void)setzd3_tel:(bool)zd3_tel{
    if (zd3_tel) {
        self.zd32_fieldLeftIcon.hidden = true;
        self.blmg_telBtn.hidden = false;
    }else{
        self.zd32_fieldLeftIcon.hidden = false;
        self.blmg_telBtn.hidden = true;
    }
}

- (void)zd33_telClick{
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_InputTextFieldViewShouldReturn:)]) {
        return [_delegate zd32_InputTextFieldViewShouldReturn:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)zd32_TextFieldTextDidChange:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_InputTextFieldViewTextDidChange:)]) {
        [_delegate zd32_InputTextFieldViewTextDidChange:self];
    }
}

@end
