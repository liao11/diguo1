
#import "ZhenD3Register_View.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3Account_Server.h"
#import "KeenWireField.h"
#import "YLAF_VerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"

@interface ZhenD3Register_View () <KeenWireFieldDelegate, YLAF_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) UIView *khxl_inputBgView;
@property (nonatomic, assign) NSInteger zd3_type;
@property (nonatomic, strong) UISegmentedControl *zd32_segment;
@property (nonatomic, strong) KeenWireField *zd31_inputAccView;
@property (nonatomic, strong) KeenWireField *zd31_inputPwdView;
@property (nonatomic, strong) YLAF_VerifyInPutTextField_View *zd31_inputVerifyView;
@property (nonatomic, strong) UIButton *zd31_verifyProtoclBtn;
@property (nonatomic, strong) UIButton *khxl_protocolBtn;
@property (nonatomic, strong) UIButton *zd33_regBtn;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;

@end

@implementation ZhenD3Register_View

- (instancetype)init {
    self = [super initWithCurType:@"0"];
    if (self) {
        [self zd32_setupViews];
    }
    return self;
}


- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}


- (void)zd32_setupViews {
    [self zd32_ShowBackBtn:YES];
    
    self.zd3_type = 0;
    
    self.khxl_inputBgView = [self zd31_mailReg_inputViewWithFrame:CGRectMake(35, 60, self.blmg_width - 35 - 35, 189)];
    [self addSubview:self.khxl_inputBgView];
    
            
    self.zd31_verifyProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_verifyProtoclBtn.frame = CGRectMake(self.khxl_inputBgView.blmg_left - 11.5, self.khxl_inputBgView.blmg_bottom - 5, 35, 35);
    self.zd31_verifyProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    
    [self.zd31_verifyProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageunPick"] forState:UIControlStateNormal];
    [self.zd31_verifyProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagepick"] forState:UIControlStateSelected];
    [self.zd31_verifyProtoclBtn addTarget:self action:@selector(onClickRegisterCheckProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd31_verifyProtoclBtn];
            
    self.khxl_protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.khxl_protocolBtn.frame = CGRectMake(self.zd31_verifyProtoclBtn.blmg_right+5, self.zd31_verifyProtoclBtn.blmg_top + 5, self.khxl_inputBgView.blmg_width-self.zd31_verifyProtoclBtn.blmg_width-5, 25);
    self.khxl_protocolBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_SmallFont];
    self.khxl_protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.khxl_protocolBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -11.5, 0, 0);
    [self.khxl_protocolBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_RegisterProtocol_Text") forState:UIControlStateNormal];
    [self.khxl_protocolBtn setTitleColor:[YLAF_Theme_Utils khxl_color_GrayColor] forState:UIControlStateNormal];
    [self.khxl_protocolBtn addTarget:self action:@selector(onClickRegisterProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.khxl_protocolBtn];
            
    self.zd33_regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd33_regBtn.frame = CGRectMake(0, self.khxl_protocolBtn.blmg_bottom + 5, 127, 34);
    self.zd33_regBtn.tag = 100;
    self.zd33_regBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd33_regBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    self.zd33_regBtn.layer.cornerRadius = 17.0;
    self.zd33_regBtn.layer.masksToBounds = YES;
    [self.zd33_regBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmRegister_Text") forState:UIControlStateNormal];
    [self.zd33_regBtn addTarget:self action:@selector(onClickRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd33_regBtn];
    
    [self.zd33_regBtn sizeToFit];
    self.zd33_regBtn.blmg_size = CGSizeMake(MAX(self.zd33_regBtn.blmg_width + 30, 127), 35);
    self.zd33_regBtn.blmg_centerX = self.khxl_inputBgView.blmg_centerX;
    
    [self zd32_u_UpdateButtonStates];
}

- (UIView *)zd31_mailReg_inputViewWithFrame:(CGRect)frame {
    
    UIView *khxl_inputBgView = [[UIView alloc] initWithFrame:frame];
    
    self.zd32_segment = [[UISegmentedControl alloc] initWithItems:@[MUUQYLocalizedString(@"MUUQYKey_Email_Text"), MUUQYLocalizedString(@"MUUQYKey_WordTel")]];
    self.zd32_segment.tintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    [self.zd32_segment setBackgroundColor:[YLAF_Theme_Utils khxl_color_headBgColor]];
    NSDictionary *zd32_atru = [NSDictionary dictionaryWithObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
    [self.zd32_segment setTitleTextAttributes:zd32_atru forState:UIControlStateNormal];
    if (@available(iOS 13.0, *)) {
        self.zd32_segment.selectedSegmentTintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    } else {
        
    }
    
    self.zd32_segment.frame = CGRectMake(30, 0, khxl_inputBgView.blmg_width-60, 30);
    [self.zd32_segment addTarget:self action:@selector(zd31_SegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.zd32_segment.selectedSegmentIndex = 0;
    self.zd32_segment.tag = 200;
    [khxl_inputBgView addSubview:self.zd32_segment];
    
    self.zd31_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 45, khxl_inputBgView.blmg_width, 40)];
    self.zd31_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Email_Placeholder_Text");
    self.zd31_inputAccView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.zd31_inputAccView.delegate = self;
    [khxl_inputBgView addSubview:self.zd31_inputAccView];
    
    self.zd31_inputAccView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageacc"];
    
    self.zd31_inputPwdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd31_inputAccView.blmg_bottom + 10, khxl_inputBgView.blmg_width, 40)];
    self.zd31_inputPwdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Password_Placeholder_Text");
    self.zd31_inputPwdView.zd32_TextField.secureTextEntry = YES;
    self.zd31_inputPwdView.delegate = self;
    [khxl_inputBgView addSubview:self.zd31_inputPwdView];
    
    self.zd31_inputPwdView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagepwd"];
    
    self.zd31_inputVerifyView = [[YLAF_VerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.zd31_inputPwdView.blmg_bottom + 10, khxl_inputBgView.blmg_width, 40)];
    self.zd31_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
    self.zd31_inputVerifyView.delegate = self;
    [khxl_inputBgView addSubview:self.zd31_inputVerifyView];
    
    self.zd31_inputVerifyView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    khxl_inputBgView.blmg_height = self.zd31_inputVerifyView.blmg_bottom;
        
    return khxl_inputBgView;
}

- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
            //对应placeholder要更改
            
            
        case 0:
        {
            self.zd31_inputAccView.zd32_TextField.text = @"";
            self.zd3_type = 0;
            self.zd31_inputAccView.zd3_tel = false;
            self.zd31_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Email_Placeholder_Text");
            self.zd31_inputPwdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Password_Placeholder_Text");
            self.zd31_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
        }
            break;
        default:
        {
            self.zd31_inputAccView.zd32_TextField.text = @"";
            self.zd3_type = 1;
            self.zd31_inputAccView.zd3_tel = true;
            self.zd31_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_pleaseTel");
            self.zd31_inputPwdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Password_Placeholder_Text");
            self.zd31_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_pleaseVerify");
        }
            break;
    }
}


- (void)zd32_u_UpdateButtonStates {
    UIButton *zd32_regBtn = [self viewWithTag:100];
    if (self.zd31_inputAccView.zd32_TextField.text.length > 0 && self.zd31_inputPwdView.zd32_TextField.text.length > 0 && self.zd31_inputVerifyView.zd32_TextField.text.length > 0 && self.zd31_verifyProtoclBtn.selected) {
        zd32_regBtn.enabled = YES;
        zd32_regBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    } else {
        zd32_regBtn.enabled = NO;
        zd32_regBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_DisableColor];
    }
}


- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandlePopRegisterView:)]) {
        [_delegate zd31_HandlePopRegisterView:self];
    }
}


- (void)onClickRegisterCheckProtoclBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self zd32_u_UpdateButtonStates];
}

- (void)onClickRegisterProtoclBtn:(id)sender {
    self.zd31_verifyProtoclBtn.selected = YES;
    [self zd32_u_UpdateButtonStates];
    
    [MYMGSDKGlobalInfo zd32_PresendWithUrlString:MYMGSDKGlobalInfo.reg_agree];
}

- (void)onClickRegisterBtn:(id)sender {
    NSString *userName = self.zd31_inputAccView.zd32_TextField.text;
    NSString *password = self.zd31_inputPwdView.zd32_TextField.text;
    NSString *verifyCode = self.zd31_inputVerifyView.zd32_TextField.text;
    
    if (self.zd3_type == 0) {
        [self blmg_emailTypeRegisterWithUsername:userName password:password verifyCode:verifyCode];
    }else{
        [self blmg_telTypeRegisterWithUsername:userName password:password verifyCode:verifyCode];
    }
}

- (void)blmg_emailTypeRegisterWithUsername:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode{
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_Miss_Alert_Text")];
        return;
    }
    if ([userName validateEmail] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_FormatError_Alert_Text")];
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
    if ([password validatePassword] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_FormatError_Alert_Text")];
        return;
    }
    if (password.length < 6 || password.length > 20) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_LengthError_Alert_Text")];
        return;
    }
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_RegisterAccountWithUserName:userName password:password verifyCode:verifyCode regType:@"1" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            NSString *_msg = [NSString stringWithFormat:@"%@%@ %@！",MUUQYLocalizedString(@"MUUQYKey_RegisterSuccess_Pre_Tips_Text"),MYMGSDKGlobalInfo.userInfo.userName, MUUQYLocalizedString(@"MUUQYKey_RegisterSuccess_Suf_Tips_Text")];
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_RegisterSuccess_Text") message:_msg actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil];
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd31_HandleDidRegistSuccess:)]) {
                [weakSelf.delegate zd31_HandleDidRegistSuccess:weakSelf];
            }
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)blmg_telTypeRegisterWithUsername:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode{
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_pleaseTel")];
        return;
    }
    if ([userName isValidateMobile] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_rightTel")];
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
    if ([password validatePassword] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_FormatError_Alert_Text")];
        return;
    }
    if (password.length < 6 || password.length > 20) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_LengthError_Alert_Text")];
        return;
    }
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_RegisterAccountWithTel:userName password:password verifyCode:verifyCode zd3_telDist:MUUQYLocalizedString(@"MUUQYKey_nowDist") responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            NSString *_msg = [NSString stringWithFormat:@"%@%@ %@！",MUUQYLocalizedString(@"MUUQYKey_RegisterSuccess_Pre_Tips_Text"),MYMGSDKGlobalInfo.userInfo.userName, MUUQYLocalizedString(@"MUUQYKey_RegisterSuccess_Suf_Tips_Text")];
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_RegisterSuccess_Text") message:_msg actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil];
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd31_HandleDidRegistSuccess:)]) {
                [weakSelf.delegate zd31_HandleDidRegistSuccess:weakSelf];
            }
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}


- (BOOL)zd32_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.zd31_inputAccView) {
        [self.zd31_inputPwdView.zd32_TextField becomeFirstResponder];
    } else if (inputView == self.zd31_inputPwdView) {
        [self.zd31_inputVerifyView.zd32_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)zd32_InputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    [self zd32_u_UpdateButtonStates];
}


- (BOOL)zd32_VerifyInputTextFieldViewShouldReturn:(YLAF_VerifyInPutTextField_View *)inputView {
    [self onClickRegisterBtn:nil];
    return YES;
}

- (void)zd32_VerifyInputTextFieldViewTextDidChange:(YLAF_VerifyInPutTextField_View *)inputView {
    [self zd32_u_UpdateButtonStates];
}

- (BOOL)zd32_HandleSendVerifyCode:(YLAF_VerifyInPutTextField_View *)inputView {
    NSString *userName = self.zd31_inputAccView.zd32_TextField.text;
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_AccountNum_Miss_Alert_Text")];
        return NO;
    }
    
    if (self.zd3_type == 0) {
        [self zd31_sendEmailCodeWithUserName:userName andInputView:inputView];
    }else{
        [self zd31_sendTelCodeWithUserName:userName zd3_telDist:MUUQYLocalizedString(@"MUUQYKey_nowDist") andInputView:inputView];
    }
    
    return YES;
}

- (void)zd31_sendEmailCodeWithUserName:(NSString *)userName andInputView:(YLAF_VerifyInPutTextField_View *)inputView
{
    [self.zd31_AccountServer zd31_SendRegisterVerify2Email:userName responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError) {
            [inputView zd32_ResetNormalSendStates];
        }
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd31_sendTelCodeWithUserName:(NSString *)userName zd3_telDist:(NSString *)zd3_telDist andInputView:(YLAF_VerifyInPutTextField_View *)inputView
{
    [self.zd31_AccountServer zd31_SendBindTelCodeRequestWithzd32_telNum:userName zd3_telDist:zd3_telDist?:@"" zd31_ut:@"1" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError) {
            [inputView zd32_ResetNormalSendStates];
        }
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}



@end
