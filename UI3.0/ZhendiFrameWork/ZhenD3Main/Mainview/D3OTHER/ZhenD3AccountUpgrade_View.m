
#import "ZhenD3AccountUpgrade_View.h"
#import "ZhenD3Account_Server.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "YLAF_VerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"

@interface ZhenD3AccountUpgrade_View () <KeenWireFieldDelegate, YLAF_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) UISegmentedControl *zd32_segment;
@property (nonatomic, assign) NSInteger zd3_type;
@property (nonatomic, strong) KeenWireField *zd31_AccountUpgrade_inputAccView;
@property (nonatomic, strong) KeenWireField *zd31_AccountUpgrade_inputPwdView;
@property (nonatomic, strong) YLAF_VerifyInPutTextField_View *zd31_AccountUpgrade_inputVerifyView;
@property (nonatomic, strong) UIButton *zd31_CheckProtoclBtn;
@property (nonatomic, strong) UIButton *zd33_protocolBtn;
@property (nonatomic, strong) UIButton *zd32_confirmBtn;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@end

@implementation ZhenD3AccountUpgrade_View

- (instancetype)init {
    self = [super initWithCurType:@"0"];
    if (self) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_zd31_HandleBeforeClosedView) {
        [self zd32_ShowCloseBtn:YES];
        [self zd32_ShowBackBtn:NO];
    } else {
        [self zd32_ShowCloseBtn:NO];
        [self zd32_ShowBackBtn:YES];
    }
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}


- (void)zd32_setupViews {
    self.title = MUUQYLocalizedString(@"MUUQYKey_AccountUpgrade_Text");
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.blmg_width - 70, 180)];
    [self addSubview:inputBgView];
    
    self.zd32_segment = [[UISegmentedControl alloc] initWithItems:@[MUUQYLocalizedString(@"MUUQYKey_Email_Text"), MUUQYLocalizedString(@"MUUQYKey_WordTel")]];
    self.zd32_segment.tintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    [self.zd32_segment setBackgroundColor:[YLAF_Theme_Utils khxl_color_headBgColor]];
    NSDictionary *zd32_atru = [NSDictionary dictionaryWithObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
    [self.zd32_segment setTitleTextAttributes:zd32_atru forState:UIControlStateNormal];
    if (@available(iOS 13.0, *)) {
        self.zd32_segment.selectedSegmentTintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    } else {
        
    }
    
    self.zd32_segment.frame = CGRectMake(30, 0, inputBgView.blmg_width-60, 30);
    [self.zd32_segment addTarget:self action:@selector(zd31_SegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.zd32_segment.selectedSegmentIndex = 0;
    self.zd32_segment.tag = 200;
    [inputBgView addSubview:self.zd32_segment];
    
    self.zd31_AccountUpgrade_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd32_segment.blmg_bottom + 10, inputBgView.blmg_width, 40)];
    self.zd31_AccountUpgrade_inputAccView.zd32_TextField.secureTextEntry = false;
    self.zd31_AccountUpgrade_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_BindEmail_Placeholder_Text");
    self.zd31_AccountUpgrade_inputAccView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.zd31_AccountUpgrade_inputAccView.delegate = self;
    [inputBgView addSubview:self.zd31_AccountUpgrade_inputAccView];
    
    self.zd31_AccountUpgrade_inputAccView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageblueMail"];
    
    self.zd31_AccountUpgrade_inputPwdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd31_AccountUpgrade_inputAccView.blmg_bottom + 20, inputBgView.blmg_width, 40)];
    self.zd31_AccountUpgrade_inputPwdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPassword_Placeholder_Text");
    self.zd31_AccountUpgrade_inputPwdView.zd32_TextField.secureTextEntry = YES;
    self.zd31_AccountUpgrade_inputPwdView.delegate = self;
    [inputBgView addSubview:self.zd31_AccountUpgrade_inputPwdView];
    
    self.zd31_AccountUpgrade_inputPwdView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eyeBtn.frame = CGRectMake(0, 0, 32, 32);
    eyeBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    eyeBtn.selected = YES;
    [eyeBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageclear"] forState:UIControlStateNormal];
    [eyeBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagemiss"] forState:UIControlStateSelected];
    [eyeBtn addTarget:self action:@selector(zd31_HandleClickedEyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd31_AccountUpgrade_inputPwdView zd32_setRightView:eyeBtn];
    
    self.zd31_AccountUpgrade_inputVerifyView = [[YLAF_VerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.zd31_AccountUpgrade_inputPwdView.blmg_bottom + 20, inputBgView.blmg_width, 40)];
    self.zd31_AccountUpgrade_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
    self.zd31_AccountUpgrade_inputVerifyView.delegate = self;
    [inputBgView addSubview:self.zd31_AccountUpgrade_inputVerifyView];
    
    inputBgView.blmg_height = self.zd31_AccountUpgrade_inputVerifyView.blmg_bottom;
    
    self.zd31_AccountUpgrade_inputVerifyView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    self.zd31_CheckProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_CheckProtoclBtn.frame = CGRectMake(inputBgView.blmg_left - 11.5, inputBgView.blmg_bottom, 35, 35);
    self.zd31_CheckProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    [self.zd31_CheckProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageunPick"] forState:UIControlStateNormal];
    [self.zd31_CheckProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagepick"] forState:UIControlStateSelected];
    
    [self.zd31_CheckProtoclBtn addTarget:self action:@selector(zd31_HandleCheckProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd31_CheckProtoclBtn];
            
    self.zd33_protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd33_protocolBtn.frame = CGRectMake(self.zd31_CheckProtoclBtn.blmg_right+5, self.zd31_CheckProtoclBtn.blmg_top + 5, inputBgView.blmg_width-self.zd31_CheckProtoclBtn.blmg_width-5, 25);
    self.zd33_protocolBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_SmallFont];
    self.zd33_protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.zd33_protocolBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -11.5, 0, 0);
    [self.zd33_protocolBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_RegisterProtocol_Text") forState:UIControlStateNormal];
    [self.zd33_protocolBtn setTitleColor:[YLAF_Theme_Utils khxl_color_GrayColor] forState:UIControlStateNormal];
    [self.zd33_protocolBtn addTarget:self action:@selector(zd31_HandleClickProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd33_protocolBtn];
    
    self.zd32_confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd32_confirmBtn.tag = 100;
    self.zd32_confirmBtn.frame = CGRectMake(0, self.zd33_protocolBtn.blmg_bottom + 5, 120, 34);
    self.zd32_confirmBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_confirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    self.zd32_confirmBtn.layer.cornerRadius = 17;
    self.zd32_confirmBtn.layer.masksToBounds = YES;
    [self.zd32_confirmBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.zd32_confirmBtn addTarget:self action:@selector(zd31_HandleConfirmUpgradeAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd32_confirmBtn];
    
    [self.zd32_confirmBtn sizeToFit];
    self.zd32_confirmBtn.blmg_size = CGSizeMake(MAX(self.zd32_confirmBtn.blmg_width + 30, 120), 34);
    self.zd32_confirmBtn.blmg_centerX = inputBgView.blmg_centerX;
    
    UILabel *descLab = [[UILabel alloc] initWithFrame:CGRectMake(20, self.zd32_confirmBtn.blmg_bottom + 10, self.blmg_width - 40, 10)];
    descLab.font = [UIFont systemFontOfSize:7];
    descLab.textAlignment = NSTextAlignmentRight;
    descLab.textColor = [YLAF_Theme_Utils zd32_colorWithHexString:@"#FC2323"];
    descLab.text = MUUQYLocalizedString(@"MUUQYKey_AccountUpgrade_Tips_Text");
    [self addSubview:descLab];
    
    self.blmg_height = descLab.blmg_bottom + 20;
    [self zd32_u_UpdateButtonStates];
}

- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
            //对应placeholder要更改
            
        case 0:
        {
            self.zd3_type = 0;
            self.zd31_AccountUpgrade_inputAccView.zd3_tel = false;
            self.zd31_AccountUpgrade_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_BindEmail_Placeholder_Text");
            self.zd31_AccountUpgrade_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
            self.zd31_AccountUpgrade_inputPwdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPassword_Placeholder_Text");
        }
            break;
        default:
        {
            self.zd3_type = 1;
            self.zd31_AccountUpgrade_inputAccView.zd3_tel = true;
            self.zd31_AccountUpgrade_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_pleaseTel");
            self.zd31_AccountUpgrade_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
            self.zd31_AccountUpgrade_inputPwdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPassword_Placeholder_Text");
        }
            break;
    }
}

- (void)zd32_u_UpdateButtonStates {
    UIButton *zd32_confirmBtn = [self viewWithTag:100];
    if (self.zd31_AccountUpgrade_inputAccView.zd32_TextField.text.length > 0 && self.zd31_AccountUpgrade_inputPwdView.zd32_TextField.text.length > 0 && self.zd31_AccountUpgrade_inputVerifyView.zd32_TextField.text.length > 0 && self.zd31_CheckProtoclBtn.selected) {
        zd32_confirmBtn.enabled = YES;
        zd32_confirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    } else {
        zd32_confirmBtn.enabled = NO;
        zd32_confirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_DisableColor];
    }
}


- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (_zd31_HandleBeforeClosedView) {
        _zd31_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandlePopAccountUpgradeView_Delegate:)]) {
        [_delegate zd31_HandlePopAccountUpgradeView_Delegate:self];
    }
}

- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (_zd31_HandleBeforeClosedView) {
        _zd31_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandlePopAccountUpgradeView_Delegate:)]) {
        [_delegate zd31_HandlePopAccountUpgradeView_Delegate:self];
    }
}


- (void)zd31_HandleClickedEyeBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.zd31_AccountUpgrade_inputPwdView.zd32_TextField.secureTextEntry = sender.selected;
}

- (void)zd31_HandleCheckProtoclBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self zd32_u_UpdateButtonStates];
}

- (void)zd31_HandleClickProtoclBtn:(UIButton *)sender {
    self.zd31_CheckProtoclBtn.selected = YES;
    [self zd32_u_UpdateButtonStates];
    
    [MYMGSDKGlobalInfo zd32_PresendWithUrlString:MYMGSDKGlobalInfo.reg_agree];
}

- (void)zd31_HandleConfirmUpgradeAccount:(id)sender {
    NSString *userName = self.zd31_AccountUpgrade_inputAccView.zd32_TextField.text;
    NSString *password = self.zd31_AccountUpgrade_inputPwdView.zd32_TextField.text;
    NSString *verifyCode = self.zd31_AccountUpgrade_inputVerifyView.zd32_TextField.text;
    
    if (self.zd3_type == 0) {
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_BindEmail_Miss_Alert_Text")];
            return;
        }
        if (!password || [password isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_Miss_Alert_Text")];
            return;
        }
        if (!verifyCode || [verifyCode isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Miss_Alert_Text")];
            return;
        }
        
        [MBProgressHUD zd32_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.zd31_AccountServer zd31_UpgradeAccount:userName withPassword:password andVerifyCode:verifyCode responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD zd32_DismissLoadingHUD];
            if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
                
                NSAttributedString *_title = [[NSAttributedString alloc] initWithString:MUUQYLocalizedString(@"MUUQYKey_AccountUpgrade_Text")];
                NSAttributedString *_msg = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@： %@",MUUQYLocalizedString(@"MUUQYKey_UpgradeSuccess_Tips_Text"), MUUQYLocalizedString(@"MUUQYKey_YourMuuAccountNum_Text"),userName?:MYMGSDKGlobalInfo.userInfo.userID]];
                
                [GrossAlertCrlV showAttTitle:_title attMessage:_msg preferredStyle:UIAlertControllerStyleAlert actionBlock:^(NSInteger btnIndex) {
                    
                } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil buttonColor:nil];
                
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd31_HandleDismissAccountUpgradeView_Delegate:)]) {
                    [weakSelf.delegate zd31_HandleDismissAccountUpgradeView_Delegate:weakSelf];
                }
            } else {
                [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
            }
        }];
    }else{
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_pleaseTel")];
            return;
        }
        if (!password || [password isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_Miss_Alert_Text")];
            return;
        }
        if (!verifyCode || [verifyCode isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Miss_Alert_Text")];
            return;
        }
        
        [MBProgressHUD zd32_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.zd31_AccountServer zd31_UpgradeAccountWithTel:userName withPassword:password andVerifyCode:verifyCode zd3_telDist:@"84" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD zd32_DismissLoadingHUD];
            if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
                
                NSAttributedString *_title = [[NSAttributedString alloc] initWithString:MUUQYLocalizedString(@"MUUQYKey_AccountUpgrade_Text")];
                NSAttributedString *_msg = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@： %@",MUUQYLocalizedString(@"MUUQYKey_UpgradeSuccess_Tips_Text"), MUUQYLocalizedString(@"MUUQYKey_YourMuuAccountNum_Text"),userName?:MYMGSDKGlobalInfo.userInfo.userID]];
                
                [GrossAlertCrlV showAttTitle:_title attMessage:_msg preferredStyle:UIAlertControllerStyleAlert actionBlock:^(NSInteger btnIndex) {
                    
                } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil buttonColor:nil];
                
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd31_HandleDismissAccountUpgradeView_Delegate:)]) {
                    [weakSelf.delegate zd31_HandleDismissAccountUpgradeView_Delegate:weakSelf];
                }
            } else {
                [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
            }
        }];
    }
}


- (BOOL)zd32_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.zd31_AccountUpgrade_inputAccView) {
        [self.zd31_AccountUpgrade_inputPwdView.zd32_TextField becomeFirstResponder];
    } else if (inputView == self.zd31_AccountUpgrade_inputPwdView) {
        [self.zd31_AccountUpgrade_inputVerifyView.zd32_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)zd32_HorizontalInputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    [self zd32_u_UpdateButtonStates];
}


- (BOOL)zd32_VerifyInputTextFieldViewShouldReturn:(YLAF_VerifyInPutTextField_View *)inputView {
    
    return YES;
}

- (void)zd32_VerifyInputTextFieldViewTextDidChange:(YLAF_VerifyInPutTextField_View *)inputView {
    [self zd32_u_UpdateButtonStates];
}

- (BOOL)zd32_HandleSendVerifyCode:(YLAF_VerifyInPutTextField_View *)inputView {
    NSString *userName = self.zd31_AccountUpgrade_inputAccView.zd32_TextField.text;
    
    if (self.zd3_type == 0) {
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_BindEmail_Miss_Alert_Text")];
            return NO;
        }
        
        [self blmg_getEmailVerifyCodeWithEmail:userName zd32_inputView:inputView];
        
        return YES;
    }else{
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_pleaseTel")];
            return NO;
        }
        
        [self zd3_getTelVerifyCodeWithTel:userName blmg_inputView:inputView];
        
        return YES;
    }
    
    
    
}

- (void)blmg_getEmailVerifyCodeWithEmail:(NSString *)zd31_email zd32_inputView:(YLAF_VerifyInPutTextField_View *)zd32_inputView{
    [self.zd31_AccountServer zd31_SendUpgradeVerifyCode2Email:zd31_email responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError) {
            [zd32_inputView zd32_ResetNormalSendStates];
        }
        
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd3_getTelVerifyCodeWithTel:(NSString *)zd32_tel blmg_inputView:(YLAF_VerifyInPutTextField_View *)blmg_inputView{
    [self.zd31_AccountServer zd31_SendUpgradeTelCodeRequestWithzd32_telNum:zd32_tel zd3_telDist:@"84" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError) {
            [blmg_inputView zd32_ResetNormalSendStates];
        }
        
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

@end
