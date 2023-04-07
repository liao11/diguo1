
#import "ZhenD3Account_View.h"

@interface ZhenD3Account_View ()

@property (nonatomic, strong) UIView *zd31_ButtonContainerView;
@end

@implementation ZhenD3Account_View

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (UIView *)zd31_ButtonContainerView {
    if (!_zd31_ButtonContainerView) {
        _zd31_ButtonContainerView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.blmg_width - 70, 100)];
    }
    return _zd31_ButtonContainerView;
}

- (void)zd32_setupViews {
    self.title = MUUQYLocalizedString(@"MUUQYKey_Account_Text");
    
    [self zd32_ShowCloseBtn:YES];
    
    [self addSubview:self.zd31_ButtonContainerView];
    [self zd31_UpdateInterface];
}

- (void)zd32_u_SetAccountButtons:(NSArray *)buttonNames {
    [self.zd31_ButtonContainerView blmg_removeAllSubviews];
    
    if (buttonNames && buttonNames.count > 0) {
        CGFloat buttonHeight = 30.0f;
        CGFloat buttonWidth = self.zd31_ButtonContainerView.blmg_width;
        CGFloat buttonGap = 10;
        [buttonNames enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, idx * (buttonHeight + buttonGap), buttonWidth, buttonHeight);
            button.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
            button.layer.cornerRadius = 5.0;
            button.layer.masksToBounds = YES;
            button.tag = [obj[0] integerValue];
            button.showsTouchWhenHighlighted = YES;
            button.backgroundColor = idx == 0 ? [YLAF_Theme_Utils khxl_color_MainColor] : [YLAF_Theme_Utils khxl_color_SecondaryColor];
            [button setTitle:obj[1] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(zd31_HandleClickedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.zd31_ButtonContainerView addSubview:button];
        }];
        
        self.zd31_ButtonContainerView.blmg_height = (buttonHeight + buttonGap) * buttonNames.count;
        self.blmg_height = self.zd31_ButtonContainerView.blmg_bottom + 20;
    }
}

- (void)zd31_UpdateInterface {
    NSArray *btns = nil;
    
    NSArray *btn0 = @[@"0",MUUQYLocalizedString(@"MUUQYKey_PersonCenter_Text")];
    NSArray *btn1 = @[@"1",MUUQYLocalizedString(@"MUUQYKey_AccountUpgrade_Text")];
    NSArray *btn2 = @[@"2",MUUQYLocalizedString(@"MUUQYKey_EmailBind_Text")];
    NSArray *btn3 = @[@"3",MUUQYLocalizedString(@"MUUQYKey_ModifyPassword_Text")];
    NSArray *btn4 = @[@"4",MUUQYLocalizedString(@"MUUQYKey_PresentCollection_Text")];
    NSArray *btn5 = @[@"5",MUUQYLocalizedString(@"MUUQYKey_Logout_Text")];
    
    switch (MYMGSDKGlobalInfo.userInfo.accountType) {
        case YLAF_AccountTypeMuu:
        {
            if (MYMGSDKGlobalInfo.userInfo.isBindEmail) {
                btns = @[btn0, btn3, btn4, btn5];
            } else {
                btns = @[btn0, btn2, btn3, btn4, btn5];
            }
        }
            break;
        case YLAF_AccountTypeGuest:
        {
            if (MYMGSDKGlobalInfo.userInfo.isBindEmail) {
                btns = @[btn4, btn5];
            } else {
                btns = @[btn1, btn4, btn5];
            }
        }
            break;
        default:
        {
            if (MYMGSDKGlobalInfo.userInfo.isBindEmail) {
                btns = @[btn0, btn4, btn5];
            } else {
                btns = @[btn0, btn2, btn4, btn5];
            }
        }
            break;
    }
    [self zd32_u_SetAccountButtons:btns];
}


- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseAccount_Delegate:)]) {
        [self.delegate zd31_handleCloseAccount_Delegate:self];
    }
}


- (void)zd31_HandleClickedBtnAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleAccount_Delegate:onClickBtn:)]) {
        [self.delegate zd31_handleAccount_Delegate:self onClickBtn:button.tag];
    }
}

@end
