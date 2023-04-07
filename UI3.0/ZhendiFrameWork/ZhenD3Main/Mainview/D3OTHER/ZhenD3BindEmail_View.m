
#import "ZhenD3BindEmail_View.h"
#import "ZhenD3Account_Server.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "YLAF_VerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"

@interface ZhenD3BindEmail_View () <KeenWireFieldDelegate, YLAF_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) KeenWireField *zd31_bindMail_inputAccView;
@property (nonatomic, strong) YLAF_VerifyInPutTextField_View *zd31_bindMail_inputVerifyView;
@property (nonatomic, strong) UILabel *zd33_descLab;
@property (nonatomic, strong) UIButton *zd32_bindEmailBtn;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@end

@implementation ZhenD3BindEmail_View

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
    self.title = MUUQYLocalizedString(@"MUUQYKey_EmailBind_Text");
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.blmg_width - 70, 100)];
    [self addSubview:inputBgView];
    
    self.zd31_bindMail_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 0, inputBgView.blmg_width, 40)];
    self.zd31_bindMail_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_BindEmail_Placeholder_Text");
    self.zd31_bindMail_inputAccView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.zd31_bindMail_inputAccView.delegate = self;
    [inputBgView addSubview:self.zd31_bindMail_inputAccView];
    
    self.zd31_bindMail_inputAccView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageblueMail"];

    self.zd31_bindMail_inputVerifyView = [[YLAF_VerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.zd31_bindMail_inputAccView.blmg_bottom + 20, inputBgView.blmg_width, 40)];
    self.zd31_bindMail_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
    self.zd31_bindMail_inputVerifyView.delegate = self;
    [inputBgView addSubview:self.zd31_bindMail_inputVerifyView];
    
    inputBgView.blmg_height = self.zd31_bindMail_inputVerifyView.blmg_bottom;
    
    self.zd31_bindMail_inputVerifyView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    self.zd33_descLab = [[UILabel alloc] initWithFrame:CGRectMake(inputBgView.blmg_left, inputBgView.blmg_bottom + 10, inputBgView.blmg_width, 25)];
    self.zd33_descLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd33_descLab.textColor = [YLAF_Theme_Utils zd32_colorWithHexString:@"#FC2323"];
    self.zd33_descLab.text = MUUQYLocalizedString(@"MUUQYKey_BindEmail_Tips_Text");
    [self addSubview:self.zd33_descLab];
    
    self.zd32_bindEmailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd32_bindEmailBtn.frame = CGRectMake(0, self.zd33_descLab.blmg_bottom + 20, 120, 35);
    self.zd32_bindEmailBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_bindEmailBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    self.zd32_bindEmailBtn.layer.cornerRadius = 17.0;
    self.zd32_bindEmailBtn.layer.masksToBounds = YES;
    [self.zd32_bindEmailBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.zd32_bindEmailBtn addTarget:self action:@selector(onClickBindEmailBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd32_bindEmailBtn];
    
    [self.zd32_bindEmailBtn sizeToFit];
    self.zd32_bindEmailBtn.blmg_size = CGSizeMake(MAX(self.zd32_bindEmailBtn.blmg_width + 30, 120), 34);
    self.zd32_bindEmailBtn.blmg_centerX = self.blmg_width / 2.0;
    
    self.blmg_height = self.zd32_bindEmailBtn.blmg_bottom + 20;
}


- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (_zd31_HandleBeforeClosedView) {
        _zd31_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_handleClosedBindEmailView_Delegate:)]) {
        [_delegate zd31_handleClosedBindEmailView_Delegate:self];
    }
}

- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (_zd31_HandleBeforeClosedView) {
        _zd31_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_handleClosedBindEmailView_Delegate:)]) {
        [_delegate zd31_handleClosedBindEmailView_Delegate:self];
    }
}


- (void)onClickBindEmailBtn:(id)sender {
    NSString *email = self.zd31_bindMail_inputAccView.zd32_TextField.text;
    NSString *verifyCode = self.zd31_bindMail_inputVerifyView.zd32_TextField.text;
    
    if (!email || [email isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_BindEmail_Miss_Alert_Text")];
        return;
    }
    if ([email validateEmail] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_FormatError_Alert_Text")];
        return;
    }
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
        
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_BindEmail:email withVerifyCode:verifyCode responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            
            [GrossAlertCrlV showAlertMessage:MUUQYLocalizedString(@"MUUQYKey_BindSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil];
            
            if (weakSelf.zd31_HandleBeforeClosedView) {
                weakSelf.zd31_HandleBeforeClosedView();
            }
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd31_handleBindEmailSuccess_Delegate:)]) {
                [weakSelf.delegate zd31_handleBindEmailSuccess_Delegate:weakSelf];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}


- (BOOL)zd32_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.zd31_bindMail_inputAccView) {
        [self.zd31_bindMail_inputVerifyView.zd32_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)zd32_HorizontalInputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    
}


- (BOOL)zd32_VerifyInputTextFieldViewShouldReturn:(YLAF_VerifyInPutTextField_View *)inputView {
    [self onClickBindEmailBtn:nil];
    return YES;
}

- (void)zd32_VerifyInputTextFieldViewTextDidChange:(YLAF_VerifyInPutTextField_View *)inputView {
    
}

- (BOOL)zd32_HandleSendVerifyCode:(YLAF_VerifyInPutTextField_View *)inputView {
    NSString *email = self.zd31_bindMail_inputAccView.zd32_TextField.text;
    
    if (!email || [email isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_BindEmail_Miss_Alert_Text")];
        return NO;
    }
    if ([email validateEmail] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_FormatError_Alert_Text")];
        return NO;
    }
    
    [self.zd31_AccountServer zd31_SendBindEmailVerifyCode2Email:email responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError) {
            [inputView zd32_ResetNormalSendStates];
        }
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
    return YES;
}
@end
