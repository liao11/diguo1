
#import "PureHFieldV.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"

@interface PureHFieldV () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *zd32_TextFieldBgView;
@property (nonatomic, strong) UIView *blmg_rightView;
@end

@implementation PureHFieldV

- (void)dealloc {
    [self.zd32_TextField removeObserver:self forKeyPath:@"text" context:nil];
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
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
    
    if (_zd32_FixedTitleWidth > 0) {
        _zd32_TitleLab.blmg_width = _zd32_FixedTitleWidth;
    } else {
        [_zd32_TitleLab sizeToFit];
    }
    
    _zd32_TitleLab.blmg_centerY = self.blmg_height / 2.0;
    _zd32_TextFieldBgView.blmg_height = MIN(30.0, self.blmg_height);
    _zd32_TextFieldBgView.blmg_centerY = _zd32_TitleLab.blmg_centerY;
    _zd32_TextFieldBgView.blmg_left = _zd32_TitleLab.blmg_right + 5;
    _zd32_TextFieldBgView.blmg_width = self.blmg_width - _zd32_TitleLab.blmg_right - 5;
    _zd32_TextField.frame = CGRectMake(8, 2, _zd32_TextFieldBgView.blmg_width - 10 - _blmg_rightView.blmg_width, _zd32_TextFieldBgView.blmg_height-4);
}

- (void)zd32_SetupDefaultViews {
    self.zd32_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.blmg_width/4.0, self.blmg_height)];
    self.zd32_TitleLab.font = [YLAF_Theme_Utils khxl_color_LargeFont];
    self.zd32_TitleLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    [self addSubview:self.zd32_TitleLab];
    
    self.zd32_TextFieldBgView = [[UIView alloc] initWithFrame:CGRectMake(self.zd32_TitleLab.blmg_right + 5, 0, self.blmg_width - self.zd32_TitleLab.blmg_right, self.blmg_height)];
    self.zd32_TextFieldBgView.backgroundColor = [YLAF_Theme_Utils khxl_color_MaskInputColor];
    self.zd32_TextFieldBgView.layer.borderColor =  [YLAF_Theme_Utils khxl_color_LineColor].CGColor;
    self.zd32_TextFieldBgView.layer.borderWidth = YLAF_1_PIXEL_SIZE;
    self.zd32_TextFieldBgView.layer.cornerRadius = 3.0;
    [self addSubview:self.zd32_TextFieldBgView];
    
    self.zd32_TextField = [[YLAF_BaseTextField alloc] initWithFrame:CGRectMake(8, 2, self.zd32_TextFieldBgView.blmg_width-10, self.zd32_TextFieldBgView.blmg_height-4)];
    self.zd32_TextField.delegate = self;
    self.zd32_TextField.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.zd32_TextField.textColor = [YLAF_Theme_Utils khxl_color_DarkGrayColor];
    self.zd32_TextField.placeholderColor = [YLAF_Theme_Utils khxl_textPlaceholderColor];
    [self.zd32_TextField addTarget:self action:@selector(zd32_TextFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.zd32_TextField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.zd32_TextFieldBgView addSubview:self.zd32_TextField];
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

- (void)zd32_setRightView:(UIView *)rightView {
    if (![self.subviews containsObject:rightView]) {
        self.blmg_rightView = rightView;
        [self addSubview:rightView];
    }
    
    rightView.blmg_centerY = _zd32_TextField.blmg_centerY;
    rightView.blmg_right = self.blmg_width;
    
    _zd32_TextFieldBgView.blmg_width = self.blmg_width - _zd32_TitleLab.blmg_right - 5;
    _zd32_TextField.frame = CGRectMake(8, 2, _zd32_TextFieldBgView.blmg_width - 10 - _blmg_rightView.blmg_width, _zd32_TextFieldBgView.blmg_height-4);
}

- (void)zd32_u_SetNodataNotActionStateLayout {
}

- (void)zd32_u_SetActiveOrHasDataStateLayout {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_HorizontalInputTextFieldViewShouldReturn:)]) {
        return [_delegate zd32_HorizontalInputTextFieldViewShouldReturn:self];
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
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_HorizontalInputTextFieldViewTextDidChange:)]) {
        [_delegate zd32_HorizontalInputTextFieldViewTextDidChange:self];
    }
}

@end
