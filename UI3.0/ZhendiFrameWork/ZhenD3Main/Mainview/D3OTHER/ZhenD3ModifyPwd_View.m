
#import "ZhenD3ModifyPwd_View.h"
#import "KeenWireField.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3Account_Server.h"
#import "GrossAlertCrlV.h"

@interface ZhenD3ModifyPwd_View () <KeenWireFieldDelegate>

@property (nonatomic, strong) KeenWireField *zd31_Pwd_InputView;
@property (nonatomic, strong) KeenWireField *zd31_NewPwd1_InputView;
@property (nonatomic, strong) KeenWireField *zd31_NewPwd2_InputView;
@property (nonatomic, strong) UIButton *zd32_confirmBtn;
@property (nonatomic, strong) ZhenD3Account_Server *accountServer;
@end

@implementation ZhenD3ModifyPwd_View

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (ZhenD3Account_Server *)accountServer {
    if (!_accountServer) {
        _accountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _accountServer;
}

- (void)zd32_setupViews {
    self.title = MUUQYLocalizedString(@"MUUQYKey_ModifyPassword_Text");
    
    [self zd32_ShowCloseBtn:YES];
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(40, 55, self.blmg_width - 80, 180)];
    [self addSubview:inputBgView];
    
    self.zd31_Pwd_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 0, inputBgView.blmg_width, 40)];
    self.zd31_Pwd_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_OldPassword_Placeholder_Text");
    self.zd31_Pwd_InputView.zd32_TextField.secureTextEntry = YES;
    self.zd31_Pwd_InputView.delegate = self;
    [inputBgView addSubview:self.zd31_Pwd_InputView];
    
    self.zd31_Pwd_InputView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageoldPwd"];
    
    self.zd31_NewPwd1_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd31_Pwd_InputView.blmg_bottom + 20, inputBgView.blmg_width, 40)];
    self.zd31_NewPwd1_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPassword_Placeholder_Text");
    self.zd31_NewPwd1_InputView.zd32_TextField.secureTextEntry = YES;
    self.zd31_NewPwd1_InputView.delegate = self;
    [inputBgView addSubview:self.zd31_NewPwd1_InputView];
    
    self.zd31_NewPwd1_InputView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    self.zd31_NewPwd2_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd31_NewPwd1_InputView.blmg_bottom + 20, inputBgView.blmg_width, 40)];
    self.zd31_NewPwd2_InputView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_NewPasswordAgain_Placeholder_Text");
    self.zd31_NewPwd2_InputView.zd32_TextField.secureTextEntry = YES;
    self.zd31_NewPwd2_InputView.delegate = self;
    [inputBgView addSubview:self.zd31_NewPwd2_InputView];
    
    self.zd31_NewPwd2_InputView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    inputBgView.blmg_height = self.zd31_NewPwd2_InputView.blmg_bottom;
    
    self.zd32_confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd32_confirmBtn.frame = CGRectMake(0, inputBgView.blmg_bottom + 20, 120, 44);
    self.zd32_confirmBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_confirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    self.zd32_confirmBtn.layer.cornerRadius = 22.0;
    self.zd32_confirmBtn.layer.masksToBounds = YES;
    [self.zd32_confirmBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.zd32_confirmBtn addTarget:self action:@selector(zd31_HandleClickedModifyPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd32_confirmBtn];
    
    [self.zd32_confirmBtn sizeToFit];
    self.zd32_confirmBtn.blmg_size = CGSizeMake(MAX(self.zd32_confirmBtn.blmg_width + 30, 120), 45);
    self.zd32_confirmBtn.blmg_centerX = self.blmg_width / 2.0;
    
    self.blmg_height = self.zd32_confirmBtn.blmg_bottom + 20;
}


- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandleCloseModifyPwdView_Delegate:)]) {
        [_delegate zd31_HandleCloseModifyPwdView_Delegate:self];
    }
}


- (void)zd31_HandleClickedModifyPwdBtn:(id)sender {
    NSString *pwd = self.zd31_Pwd_InputView.zd32_TextField.text;
    NSString *newPwd1 = self.zd31_NewPwd1_InputView.zd32_TextField.text;
    NSString *newPwd2 = self.zd31_NewPwd2_InputView.zd32_TextField.text;
    
    if (!pwd || [pwd isEmpty] || !newPwd1 || [newPwd1 isEmpty] || !newPwd2 || [newPwd2 isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_Miss_Alert_Text")];
        return;
    }
    if ([newPwd1 isEqualToString:newPwd2] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_2EnterNoMatch_Alert_Text")];
        return;
    }
    if ([newPwd1 isEqualToString:pwd]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_NewOldSame_Alert_Text")];
        return;
    }
    if ([newPwd1 validatePassword] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_FormatError_Alert_Text")];
        return;
    }
    if (newPwd1.length < 6 || newPwd1.length > 20) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_LengthError_Alert_Text")];
        return;
    }
    
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.accountServer zd31_ModifyPassword:pwd newPassword:newPwd1 reNewPassword:newPwd2 responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_ModifyPassword_Text") message:MUUQYLocalizedString(@"MUUQYKey_ModifySuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil];
            [weakSelf zd32_HandleClickedBackBtn:sender];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}


- (BOOL)zd32_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.zd31_Pwd_InputView) {
        [self.zd31_NewPwd1_InputView.zd32_TextField becomeFirstResponder];
    }
    else if (inputView == self.zd31_NewPwd1_InputView) {
        [self.zd31_NewPwd2_InputView.zd32_TextField becomeFirstResponder];
    }
    else if (inputView == self.zd31_NewPwd2_InputView) {
        
        [self endEditing:YES];
    }
    return YES;
}

@end
