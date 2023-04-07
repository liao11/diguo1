//
//  ZhenD3BindTelView.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenD3BindTelView.h"
#import "ZhenD3Account_Server.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "YLAF_VerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenD3Login_Server.h"

@interface ZhenD3BindTelView () <KeenWireFieldDelegate, YLAF_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) KeenWireField *blmg_bindTel_inputAccView;
@property (nonatomic, strong) YLAF_VerifyInPutTextField_View *zd32_bindTel_inputVerifyView;
@property (nonatomic, strong) UILabel *zd33_descLab;
@property (nonatomic, strong) UIButton *zd33_bindTelBtn;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@end

@implementation ZhenD3BindTelView

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
    self.title = MUUQYLocalizedString(@"MUUQYKey_tiTel");
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.blmg_width - 70, 100)];
    [self addSubview:inputBgView];
    
    self.blmg_bindTel_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 0, inputBgView.blmg_width, 40)];
    self.blmg_bindTel_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_pleaseTel");
    self.blmg_bindTel_inputAccView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.blmg_bindTel_inputAccView.delegate = self;
    [inputBgView addSubview:self.blmg_bindTel_inputAccView];
    
    self.blmg_bindTel_inputAccView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagemobile"];

    self.zd32_bindTel_inputVerifyView = [[YLAF_VerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.blmg_bindTel_inputAccView.blmg_bottom + 20, inputBgView.blmg_width, 40)];
    self.zd32_bindTel_inputVerifyView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_pleaseVerify");
    self.zd32_bindTel_inputVerifyView.delegate = self;
    [inputBgView addSubview:self.zd32_bindTel_inputVerifyView];
    
    inputBgView.blmg_height = self.zd32_bindTel_inputVerifyView.blmg_bottom;
    
    self.zd32_bindTel_inputVerifyView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagenewPwd"];
    
    self.zd33_descLab = [[UILabel alloc] initWithFrame:CGRectMake(inputBgView.blmg_left, inputBgView.blmg_bottom + 10, inputBgView.blmg_width, 25)];
    self.zd33_descLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd33_descLab.textColor = [YLAF_Theme_Utils zd32_colorWithHexString:@"#FC2323"];
    self.zd33_descLab.text = MUUQYLocalizedString(@"MUUQYKey_BindTel_Tips_Text");
    [self addSubview:self.zd33_descLab];
    
    self.zd33_bindTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd33_bindTelBtn.frame = CGRectMake(0, self.zd33_descLab.blmg_bottom + 20, 120, 35);
    self.zd33_bindTelBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd33_bindTelBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    self.zd33_bindTelBtn.layer.cornerRadius = 17.0;
    self.zd33_bindTelBtn.layer.masksToBounds = YES;
    [self.zd33_bindTelBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.zd33_bindTelBtn addTarget:self action:@selector(blmg_onClickBindTelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd33_bindTelBtn];
    
    [self.zd33_bindTelBtn sizeToFit];
    self.zd33_bindTelBtn.blmg_size = CGSizeMake(MAX(self.zd33_bindTelBtn.blmg_width + 30, 120), 34);
    self.zd33_bindTelBtn.blmg_centerX = self.blmg_width / 2.0;
    
    self.blmg_height = self.zd33_bindTelBtn.blmg_bottom + 20;
}


- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (_zd31_HandleBeforeClosedView) {
        _zd31_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_handleClosedBindTelView_Delegate:)]) {
        [_delegate zd31_handleClosedBindTelView_Delegate:self];
    }
}

- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (_zd31_HandleBeforeClosedView) {
        _zd31_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_handleClosedBindTelView_Delegate:)]) {
        [_delegate zd31_handleClosedBindTelView_Delegate:self];
    }
}


- (void)blmg_onClickBindTelBtn:(id)sender {
    NSString *tel = self.blmg_bindTel_inputAccView.zd32_TextField.text;
    NSString *verifyCode = self.zd32_bindTel_inputVerifyView.zd32_TextField.text;
    
    if (!tel || [tel isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_pleaseTel")];
        return;
    }
    if ([tel isValidateMobile] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_rightTel")];
        return;
    }
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
        
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_bindMobileCodeRequestWithzd32_telNum:tel zd3_telDist:MUUQYLocalizedString(@"MUUQYKey_nowDist") verifyCode:verifyCode responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            
            if (!weakSelf.blmg_needTiePresent) {
                [GrossAlertCrlV showAlertMessage:MUUQYLocalizedString(@"MUUQYKey_BindTelSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {

                } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") otherButtonTitles:nil];
            }
            
            if (weakSelf.zd31_HandleBeforeClosedView) {
                weakSelf.zd31_HandleBeforeClosedView();
            }
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd31_handleBindTelSuccess_Delegate:)]) {
                [weakSelf.delegate zd31_handleBindTelSuccess_Delegate:weakSelf];
            } else {
                [weakSelf removeFromSuperview];
            }
            
            
            if (weakSelf.blmg_needTiePresent) {
                [[ZhenD3Login_Server new] lhxy_tiePresentWithGameId:weakSelf.zd31_gameId zd32_roleId:weakSelf.zd32_roleId Request:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
                    
                    if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
                        [MBProgressHUD zd32_showSuccess_Toast:MUUQYLocalizedString(@"MUUQYKey_tiePresentSuccess")];
                        YLMXGSDKAPI.blmg_tiePresent = true;
                    } else {
                        [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
                    }
                    
                    if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_checkPresentFinish:)]) {
                        [YLMXGSDKAPI.delegate zd3_checkPresentFinish:result];
                    }
                }];
            }
            
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}


- (BOOL)zd32_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.blmg_bindTel_inputAccView) {
        [self.zd32_bindTel_inputVerifyView.zd32_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)zd32_HorizontalInputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    
}


- (BOOL)zd32_VerifyInputTextFieldViewShouldReturn:(YLAF_VerifyInPutTextField_View *)inputView {
    [self blmg_onClickBindTelBtn:nil];
    return YES;
}

- (void)zd32_VerifyInputTextFieldViewTextDidChange:(YLAF_VerifyInPutTextField_View *)inputView {
    
}

- (BOOL)zd32_HandleSendVerifyCode:(YLAF_VerifyInPutTextField_View *)inputView {
    NSString *tel = self.blmg_bindTel_inputAccView.zd32_TextField.text;
    
    if (!tel || [tel isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Bindtel_Miss_Alert_Text")];
        return NO;
    }
    if ([tel isValidateMobile] == NO) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Email_FormatError_Alert_Text")];
        return NO;
    }
    
    [self.zd31_AccountServer zd31_SendUpgradeTelCodeRequestWithzd32_telNum:tel zd3_telDist:MUUQYLocalizedString(@"MUUQYKey_nowDist") responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
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
