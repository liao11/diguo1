//
//  ZhenD3OneClickLoginV.m
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenD3OneClickLoginV.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3Account_Server.h"
#import "KeenWireField.h"
#import "YLAF_VerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"

@interface ZhenD3OneClickLoginV () <KeenWireFieldDelegate,YLAF_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) UIView *khxl_inputBgView;
@property (nonatomic, strong) KeenWireField *zd31_inputAccView;
@property (nonatomic, strong) YLAF_VerifyInPutTextField_View *zd31_inputVerifyView;
@property (nonatomic, strong) UIButton *zd31_verifyProtoclBtn;
@property (nonatomic, strong) UIButton *khxl_protocolBtn;
@property (nonatomic, strong) UIButton *zd33_regBtn;
@property (nonatomic, strong) UIButton *zd32_loginBtn;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;

@end

@implementation ZhenD3OneClickLoginV

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
    
    self.title = MUUQYLocalizedString(@"MUUQYKey_SuperLogin");
    
    [self zd32_ShowBackBtn:YES];
        
    self.khxl_inputBgView = [self zd31_mailReg_inputViewWithFrame:CGRectMake(35, 60, self.blmg_width - 35 - 35, 120)];
    [self addSubview:self.khxl_inputBgView];
            
    self.zd33_regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd33_regBtn.frame = CGRectMake(0, self.khxl_inputBgView.blmg_bottom + 15, self.khxl_inputBgView.blmg_width, 40);
    self.zd33_regBtn.tag = 100;
    self.zd33_regBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd33_regBtn.backgroundColor = [YLAF_Theme_Utils khxl_SmallGrayColor];
    self.zd33_regBtn.layer.cornerRadius = 20.0;
    self.zd33_regBtn.layer.masksToBounds = YES;
    [self.zd33_regBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmRegister_Text") forState:UIControlStateNormal];
    [self.zd33_regBtn addTarget:self action:@selector(onClickRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd33_regBtn];
    self.zd33_regBtn.blmg_centerX = self.khxl_inputBgView.blmg_centerX;
        
    self.zd31_verifyProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_verifyProtoclBtn.frame = CGRectMake(self.khxl_inputBgView.blmg_left - 11.5, self.zd33_regBtn.blmg_bottom + 15, 35, 35);
    self.zd31_verifyProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    
    [self.zd31_verifyProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageunPick"] forState:UIControlStateNormal];
    [self.zd31_verifyProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagepick"] forState:UIControlStateSelected];
    self.zd31_verifyProtoclBtn.selected = true;
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
    
    self.zd32_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd32_loginBtn.frame = CGRectMake(0, self.khxl_protocolBtn.blmg_bottom + 10, 150, 40);
    self.zd32_loginBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LargeFont];
    self.zd32_loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.zd32_loginBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_EmailFastLogin") forState:UIControlStateNormal];
    [self.zd32_loginBtn setTitleColor:[YLAF_Theme_Utils khxl_SmallGrayColor] forState:UIControlStateNormal];
    [self.zd32_loginBtn addTarget:self action:@selector(zd32_HandleClickedToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd32_loginBtn];
    self.zd32_loginBtn.blmg_centerX = self.khxl_inputBgView.blmg_centerX;
    
    UIView *zd31_lineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.zd32_loginBtn.blmg_bottom, 120, 1)];
    zd31_lineV.backgroundColor = [YLAF_Theme_Utils khxl_SmallGrayColor];
    [self addSubview:zd31_lineV];
    zd31_lineV.blmg_centerX = self.khxl_inputBgView.blmg_centerX;
    
    [self zd32_u_UpdateButtonStates];
}

- (UIView *)zd31_mailReg_inputViewWithFrame:(CGRect)frame {
    
    UIView *khxl_inputBgView = [[UIView alloc] initWithFrame:frame];
    
    self.zd31_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 25, khxl_inputBgView.blmg_width, 40)];
    self.zd31_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Email_Placeholder_Text");
    self.zd31_inputAccView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.zd31_inputAccView.delegate = self;
    [khxl_inputBgView addSubview:self.zd31_inputAccView];
    
    self.zd31_inputAccView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageblueMail"];
    
    self.zd31_inputVerifyView = [[YLAF_VerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.zd31_inputAccView.blmg_bottom + 10, khxl_inputBgView.blmg_width, 40)];
    self.zd31_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Placeholder_Text");
    self.zd31_inputVerifyView.zd32_TextField.keyboardType = UIKeyboardTypeNumberPad;
    self.zd31_inputVerifyView.delegate = self;
    [khxl_inputBgView addSubview:self.zd31_inputVerifyView];
    
    self.zd31_inputVerifyView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    khxl_inputBgView.blmg_height = self.zd31_inputVerifyView.blmg_bottom;
        
    return khxl_inputBgView;
}


- (void)zd32_u_UpdateButtonStates {
    UIButton *zd32_regBtn = [self viewWithTag:100];
    if (self.zd31_inputAccView.zd32_TextField.text.length > 0 && self.zd31_inputVerifyView.zd32_TextField.text.length > 0 && self.zd31_verifyProtoclBtn.selected) {
        zd32_regBtn.enabled = YES;
        zd32_regBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    } else {
        zd32_regBtn.enabled = NO;
        zd32_regBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_DisableColor];
    }
}


- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandlePopToLastV:)]) {
        [_delegate zd31_HandlePopToLastV:self];
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

- (void)zd32_HandleClickedToLogin:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(zd33_PresentFromOneClickToLogin:)]) {
        [_delegate zd33_PresentFromOneClickToLogin:self];
    }
}

- (void)onClickRegisterBtn:(id)sender {
    NSString *userName = self.zd31_inputAccView.zd32_TextField.text;
    NSString *verifyCode = self.zd31_inputVerifyView.zd32_TextField.text;
    [self blmg_emailTypeRegisterWithUsername:userName verifyCode:verifyCode];
}

- (void)blmg_emailTypeRegisterWithUsername:(NSString *)userName verifyCode:(NSString *)verifyCode
{
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_Miss_Alert_Text")];
        return;
    }
    if ([userName validateEmail] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_FormatError_Alert_Text")];
        return;
    }
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_RegisterAccountWithUserName:userName password:@"" verifyCode:verifyCode regType:@"2" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {

            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd31_HandleDidOneClickEmailSuccess:)]) {
                [weakSelf.delegate zd31_HandleDidOneClickEmailSuccess:weakSelf];
            }
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (BOOL)zd32_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.zd31_inputAccView) {
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
    
    [self zd31_sendEmailCodeWithUserName:userName andInputView:inputView];
    
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

@end
