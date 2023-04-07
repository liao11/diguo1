
#import "ZhenD3ResetPwd_View.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "YLAF_VerifyInPutTextField_View.h"
#import "ZhenD3Account_Server.h"
#import "GrossAlertCrlV.h"
#define YLAF_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define YLAF_RGB(r,g,b)          YLAF_RGBA(r,g,b,1.0f)
@interface ZhenD3ResetPwd_View () <KeenWireFieldDelegate, YLAF_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) UISegmentedControl *zd32_segment;
@property (nonatomic, assign) NSInteger zd3_type;
@property (nonatomic, strong) KeenWireField *zd32_Mail_InputView;
@property (nonatomic, strong) YLAF_VerifyInPutTextField_View *zd32_VerifyCode_InputView;
@property (nonatomic, strong) KeenWireField *zd32_Pwd_InputView;
@property (nonatomic, strong) KeenWireField *zd32_Pwd2_InputView;
@property (nonatomic, strong) UIButton *zd31_resetBtn;

@property (nonatomic, strong) ZhenD3Account_Server *zd32_AccountServer;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;

@end

@implementation ZhenD3ResetPwd_View

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (ZhenD3Account_Server *)zd32_AccountServer {
    if (!_zd32_AccountServer) {
        _zd32_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd32_AccountServer;
}

- (void)zd32_setupViews {
    [self zd32_ShowBackBtn:YES];
    
    self.zd3_type = 0;
    
    self.title = MUUQYLocalizedString(@"MUUQYKey_ResetPassword_Text");
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(35, 65, self.blmg_width - 70, 180)];
    [self addSubview:inputBgView];
    
    self.zd32_segment = [[UISegmentedControl alloc] initWithItems:@[MUUQYLocalizedString(@"MUUQYKey_Email_Text"), MUUQYLocalizedString(@"MUUQYKey_WordTel")]];
    self.zd32_segment.tintColor = YLAF_RGB(255, 135, 101);
    [self.zd32_segment setBackgroundColor:YLAF_RGB(243, 243, 243)];
    NSDictionary *zd32_atru = [NSDictionary dictionaryWithObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
    [self.zd32_segment setTitleTextAttributes:zd32_atru forState:UIControlStateNormal];
    if (@available(iOS 13.0, *)) {
        self.zd32_segment.selectedSegmentTintColor =  YLAF_RGB(255, 135, 101);
    } else {
        
    }
    
    self.zd32_segment.frame = CGRectMake(30, 0, inputBgView.blmg_width-60, 30);
    [self.zd32_segment addTarget:self action:@selector(zd31_SegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.zd32_segment.selectedSegmentIndex = 0;
    self.zd32_segment.tag = 200;
    [inputBgView addSubview:self.zd32_segment];
    
    self.zd32_Mail_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd32_segment.blmg_bottom + 10, inputBgView.blmg_width, 40)];
    self.zd32_Mail_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_BindEmail_Placeholder_Text");
    self.zd32_Mail_InputView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.zd32_Mail_InputView.delegate = self;
    [inputBgView addSubview:self.zd32_Mail_InputView];
    self.zd32_Mail_InputView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageacc"];
    
    if ([MYMGSDKGlobalInfo.userInfo.userName isValidateMobile]) {
        self.zd32_segment.hidden = true;
        self.zd3_type = 1;
        self.zd32_Mail_InputView.zd32_TextField.text = MYMGSDKGlobalInfo.userInfo.userName;
        self.zd32_Mail_InputView.userInteractionEnabled = false;
        self.zd32_Mail_InputView.frame = CGRectMake(0, 20, inputBgView.blmg_width, 40);
    }else if ([MYMGSDKGlobalInfo.userInfo.userName validateEmail]) {
        self.zd32_segment.hidden = true;
        self.zd3_type = 0;
        self.zd32_Mail_InputView.zd32_TextField.text = MYMGSDKGlobalInfo.userInfo.userName;
        self.zd32_Mail_InputView.userInteractionEnabled = false;
        self.zd32_Mail_InputView.frame = CGRectMake(0, 20, inputBgView.blmg_width, 40);
    }
    
    self.zd32_VerifyCode_InputView = [[YLAF_VerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.zd32_Mail_InputView.blmg_bottom + 10, inputBgView.blmg_width, 40)];
    self.zd32_VerifyCode_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
    self.zd32_VerifyCode_InputView.delegate = self;
    [inputBgView addSubview:self.zd32_VerifyCode_InputView];
    self.zd32_VerifyCode_InputView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    self.zd32_Pwd_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd32_VerifyCode_InputView.blmg_bottom + 10, inputBgView.blmg_width, 40)];
    self.zd32_Pwd_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPassword_Placeholder_Text");
    self.zd32_Pwd_InputView.zd32_TextField.secureTextEntry = YES;
    self.zd32_Pwd_InputView.delegate = self;
    [inputBgView addSubview:self.zd32_Pwd_InputView];
    self.zd32_Pwd_InputView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageresetPwd"];
    
    self.zd32_Pwd2_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd32_Pwd_InputView.blmg_bottom + 10, inputBgView.blmg_width, 40)];
    self.zd32_Pwd2_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPasswordAgain_Placeholder_Text");
    self.zd32_Pwd2_InputView.zd32_TextField.secureTextEntry = YES;
    self.zd32_Pwd2_InputView.delegate = self;
    [inputBgView addSubview:self.zd32_Pwd2_InputView];
    self.zd32_Pwd2_InputView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageresetPwd"];
    
    inputBgView.blmg_height = self.zd32_Pwd2_InputView.blmg_bottom;
    
    self.zd31_resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_resetBtn.frame = CGRectMake(0, inputBgView.blmg_bottom + 20, 127, 34);
    self.zd31_resetBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd31_resetBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_MainColor];
    self.zd31_resetBtn.layer.cornerRadius = 17.0;
    self.zd31_resetBtn.layer.masksToBounds = YES;
    self.zd31_resetBtn.tag = 100;
    [self.zd31_resetBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.zd31_resetBtn addTarget:self action:@selector(zd32_HandleResetPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd31_resetBtn];
    
    [self.zd31_resetBtn sizeToFit];
    self.zd31_resetBtn.blmg_size = CGSizeMake(MAX(self.zd31_resetBtn.blmg_width + 30, 127), 34);
    self.zd31_resetBtn.blmg_centerX = self.blmg_centerX;
    
    [self zd32_u_UpdateButtonStates];
    
    
}

- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
            //对应placeholder要更改
        case 0:
        {
            self.zd3_type = 0;
            self.zd32_Mail_InputView.zd3_tel = false;
            self.zd32_Mail_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Email_Placeholder_Text");
            self.zd32_VerifyCode_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
            self.zd32_Pwd_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPassword_Placeholder_Text");
            self.zd32_Pwd2_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPasswordAgain_Placeholder_Text");
        }
            break;
        default:
        {
            self.zd3_type = 1;
            self.zd32_Mail_InputView.zd3_tel = true;
            self.zd32_Mail_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_pleaseTel");
            self.zd32_VerifyCode_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
            self.zd32_Pwd_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPassword_Placeholder_Text");
            self.zd32_Pwd2_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPasswordAgain_Placeholder_Text");
        }
            break;
    }
}

- (void)zd32_u_UpdateButtonStates {
    UIButton *confirmBtn = [self viewWithTag:100];
    if (self.zd32_Mail_InputView.zd32_TextField.text.length > 0 && self.zd32_VerifyCode_InputView.zd32_TextField.text.length > 0 && self.zd32_Pwd_InputView.zd32_TextField.text.length > 0 && self.zd32_Pwd2_InputView.zd32_TextField.text.length > 0) {
        confirmBtn.enabled = YES;
        confirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    } else {
        confirmBtn.enabled = NO;
        confirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_DisableColor];
    }
}


- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_onClickCloseResetPwdView_Delegate:isFromLogin:)]) {
        [_delegate zd31_onClickCloseResetPwdView_Delegate:self isFromLogin:self.isFromLogin];
    }
}


- (void)zd32_HandleResetPwdBtn:(id)sender {
    NSString *email = self.zd32_Mail_InputView.zd32_TextField.text;
    NSString *password = self.zd32_Pwd_InputView.zd32_TextField.text;
    NSString *password2 = self.zd32_Pwd2_InputView.zd32_TextField.text;
    NSString *verifyCode = self.zd32_VerifyCode_InputView.zd32_TextField.text;

    if (self.zd3_type == 0)
    {
        if (!email || [email isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_Miss_Alert_Text")];
            return;
        }
        if ([email validateEmail] == NO) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_FormatError_Alert_Text")];
            return;
        }
    }else{
        if (!email || [email isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_pleaseTel")];
            return;
        }
        if ([email isValidateMobile] == NO) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_rightTel")];
            return;
        }
    }
    
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
    if (!password || [password isEmpty] || !password2 || [password2 isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_Miss_Alert_Text")];
        return;
    }
    if ([password2 isEqualToString:password] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_2EnterNoMatch_Alert_Text")];
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
    
    
    if (self.zd3_type == 0)
    {
        [self blmg_ResetEmailWithEmail:email password:password verifyCode:verifyCode sender:sender];
    }else{
        [self blmg_ResetTelWithTel:email password:password verifyCode:verifyCode sender:sender];
    }
    
}

- (void)blmg_ResetEmailWithEmail:(NSString *)email password:(NSString *)password verifyCode:(NSString *)verifyCode sender:(id)sender{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd32_AccountServer zd31_ResetPwdWithBindEmail:email verifyCode:verifyCode newPassword:password responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_ResetPassword_Text") message:MUUQYLocalizedString(@"MUUQYKey_ResetSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil];
            
            [weakSelf zd32_HandleClickedBackBtn:sender];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)blmg_ResetTelWithTel:(NSString *)tel password:(NSString *)password verifyCode:(NSString *)verifyCode sender:(id)sender{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd32_AccountServer zd31_ResetPwdWithBindTel:tel verifyCode:verifyCode newPassword:password zd31_ut:@"2" zd3_telDist:@"84" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_ResetPassword_Text") message:MUUQYLocalizedString(@"MUUQYKey_ResetSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil];
            
            [weakSelf zd32_HandleClickedBackBtn:sender];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}



- (BOOL)zd32_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.zd32_Mail_InputView) {
        [self.zd32_VerifyCode_InputView.zd32_TextField becomeFirstResponder];
    } else if (inputView == self.zd32_Pwd_InputView) {
        [self.zd32_Pwd2_InputView.zd32_TextField becomeFirstResponder];
    } else if (inputView == self.zd32_Pwd2_InputView) {
        [self endEditing:YES];
    }
    return YES;
}

- (void)zd32_InputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    [self zd32_u_UpdateButtonStates];
}


- (BOOL)zd32_VerifyInputTextFieldViewShouldReturn:(YLAF_VerifyInPutTextField_View *)inputView {
    if (inputView == self.zd32_VerifyCode_InputView) {
        [self.zd32_Pwd2_InputView.zd32_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)zd32_VerifyInputTextFieldViewTextDidChange:(YLAF_VerifyInPutTextField_View *)inputView {
    [self zd32_u_UpdateButtonStates];
}

- (BOOL)zd32_HandleSendVerifyCode:(YLAF_VerifyInPutTextField_View *)inputView {
    NSString *mail = self.zd32_Mail_InputView.zd32_TextField.text;
    
    if (self.zd3_type == 0) {
        if (!mail || [mail isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_Miss_Alert_Text")];
            return NO;
        }
        if ([mail validateEmail] == NO) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_FormatError_Alert_Text")];
            return NO;
        }
        [self.zd32_AccountServer zd31_SendFindAccountVerufy2Email:mail responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError) {
                [inputView zd32_ResetNormalSendStates];
            }
            if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
                [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
            }
        }];
    }else{
        
        if (!mail || [mail isEmpty]) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_pleaseTel")];
            return NO;
        }
        if ([mail isValidateMobile] == NO) {
            [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_rightTel")];
            return NO;
        }
        
        [self zd31_sendTelCodeWithUserName:mail zd3_telDist:MUUQYLocalizedString(@"MUUQYKey_nowDist") andInputView:inputView];
    }
    
    return YES;
}

- (void)zd31_sendTelCodeWithUserName:(NSString *)userName zd3_telDist:(NSString *)zd3_telDist andInputView:(YLAF_VerifyInPutTextField_View *)inputView
{
    [self.zd31_AccountServer zd31_SendBindTelCodeRequestWithzd32_telNum:userName zd3_telDist:zd3_telDist?:@"" zd31_ut:@"2" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError) {
            [inputView zd32_ResetNormalSendStates];
        }
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}


@end
