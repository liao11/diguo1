
#import "ZhenD3GuestAccountPrompt_View.h"

@implementation ZhenD3GuestAccountPrompt_View

- (instancetype)init {
    self = [super initWithCurType:@"0"];
    if (self) {
        [self zd32_setupViews];
    }
    return self;
}


- (void)zd32_setupViews {
    self.title = MUUQYLocalizedString(@"MUUQYKey_GuestAccount_Text");
    
    NSString *labelText = MUUQYLocalizedString(@"MUUQYKey_GuestAccount_Tips_Text");
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[YLAF_Theme_Utils khxl_color_NormalFont]}];
    
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, self.blmg_width-40, 500)];
    messageLab.numberOfLines = 0;
    messageLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    messageLab.textColor = [YLAF_Theme_Utils zd32_colorWithHexString:@"#FC2323"];
    messageLab.attributedText = attributedString;
    [self addSubview:messageLab];
    [messageLab sizeToFit];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    cancelBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_SecondaryColor];
    cancelBtn.layer.cornerRadius = 5.0;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_RefuseUpgrade_Text") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(zd31_HandleClickedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    confirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_MainColor];
    confirmBtn.layer.cornerRadius = 5.0;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_UpdateAtOnce_Text") forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(zd31_HandleClickedConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    
    [cancelBtn sizeToFit];
    [confirmBtn sizeToFit];
    CGFloat maxW = (messageLab.blmg_width - 20) / 2.0;
    CGFloat caW = cancelBtn.blmg_width + 30;
    if (caW < 127.0) {
        caW = 127.0;
    }
    if (caW > maxW) {
        caW = maxW;
    }
    CGFloat coW = confirmBtn.blmg_width + 30;
    if (coW < 127.0) {
        coW = 127.0;
    }
    if (coW > maxW) {
        coW = maxW;
    }
    CGFloat btnW = MAX(caW, coW);
    cancelBtn.blmg_size = CGSizeMake(btnW, 35);
    confirmBtn.blmg_size = CGSizeMake(btnW, 35);
    cancelBtn.blmg_right = self.blmg_width/2.0 - 10;
    confirmBtn.blmg_left = self.blmg_width/2.0 + 10;
    cancelBtn.blmg_top = messageLab.blmg_bottom + 20;
    confirmBtn.blmg_bottom = cancelBtn.blmg_bottom;
    
    self.blmg_height = confirmBtn.blmg_bottom + 20;
}


- (void)zd31_HandleClickedCancelBtn:(id)sender {
    if (_zd31_HandleBeforeClosedView) {
        _zd31_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandleClosePromptView:)]) {
        [_delegate zd31_HandleClosePromptView:self];
    }
}

- (void)zd31_HandleClickedConfirmBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandleUpgrateFromPromptView:upgrateCompletion:)]) {
        [_delegate zd31_HandleUpgrateFromPromptView:self upgrateCompletion:_zd31_HandleBeforeClosedView];
    }
}

@end
