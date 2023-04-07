//
//  ZhenD3ChooseLoginView.m
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenD3ChooseLoginView.h"
#import "ZhenD3Login_Server.h"
@interface ZhenD3ChooseLoginView ()

@property (strong, nonatomic) UIView *zd33_viewBg;
@property (strong, nonatomic) UIButton *zd31_gstLogBtn;
@property (strong, nonatomic) UIButton *zd31_cusRegBtn;
@property (strong, nonatomic) UIButton *zd33_fblogBtn;


@property (strong, nonatomic) UIButton *zd31_verifyProtoclBtn;

@property (strong, nonatomic) UIButton *khxl_protocolBtn;

@property (strong, nonatomic) ZhenD3Login_Server *zd32_LoginServer;

@end

@implementation ZhenD3ChooseLoginView

- (instancetype)init {
    self = [super initWithCurType:@"0"];
    if (self) {
        [self zd32_setupViews];
    }
    return self;
}


- (ZhenD3Login_Server *)zd32_LoginServer {
    if (!_zd32_LoginServer) {
        _zd32_LoginServer = [[ZhenD3Login_Server alloc] init];
    }
    return _zd32_LoginServer;
}


- (void)zd32_setupViews {
    
    self.title = MUUQYLocalizedString(@"MUUQYKey_Login_Text");
        
    self.zd33_viewBg = [[UIView alloc] initWithFrame:CGRectMake(35, 60, self.blmg_width-70, 200)];
    [self addSubview:self.zd33_viewBg];
    
    self.zd31_gstLogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_gstLogBtn.frame = CGRectMake(0, 30, self.zd33_viewBg.blmg_width, 49);
    self.zd31_gstLogBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LargeFont];
    self.zd31_gstLogBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.zd31_gstLogBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_QuickLogin_Text") forState:UIControlStateNormal];
    [self.zd31_gstLogBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageOneClick"] forState:UIControlStateNormal];
    [self.zd31_gstLogBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    self.zd31_gstLogBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_yellowColor];
    
    [self.zd31_gstLogBtn setBackgroundImage:[YLAF_Helper_Utils imageName:@"zdimageb1"] forState:0];
    
    
//    [self.zd31_gstLogBtn setBackgroundImage:[YLAF_Helper_Utils imageName:@"zdimageOneClick"] forState:0];
    self.zd31_gstLogBtn.layer.cornerRadius = 6;
    self.zd31_gstLogBtn.clipsToBounds = true;
    [self.zd31_gstLogBtn addTarget:self action:@selector(zd32_HandleCilckedQuicklogBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_viewBg addSubview:self.zd31_gstLogBtn];
    
    self.zd31_cusRegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_cusRegBtn.frame = CGRectMake(0, self.zd31_gstLogBtn.blmg_bottom + 25, self.zd33_viewBg.blmg_width, 49);
    self.zd31_cusRegBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LargeFont];
    self.zd31_cusRegBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.zd31_cusRegBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_EmailFastLogin") forState:UIControlStateNormal];
    [self.zd31_cusRegBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageacc1"] forState:UIControlStateNormal];
    [self.zd31_cusRegBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    self.zd31_cusRegBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    [self.zd31_cusRegBtn setBackgroundImage:[YLAF_Helper_Utils imageName:@"zdimageb2"] forState:0];
    self.zd31_cusRegBtn.layer.cornerRadius = 6;
    self.zd31_cusRegBtn.clipsToBounds = true;
    [self.zd31_cusRegBtn addTarget:self action:@selector(zd32_HandleClickedRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_viewBg addSubview:self.zd31_cusRegBtn];
    
    
    self.zd33_fblogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd33_fblogBtn.frame = CGRectMake(0, self.zd31_cusRegBtn.blmg_bottom + 25, self.zd33_viewBg.blmg_width, 49);
    self.zd33_fblogBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LargeFont];
    self.zd33_fblogBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.zd33_fblogBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_Facebook_Text") forState:UIControlStateNormal];
    [self.zd33_fblogBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageFB"] forState:UIControlStateNormal];
    [self.zd33_fblogBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    self.zd33_fblogBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_faceColor];
    [self.zd33_fblogBtn setBackgroundImage:[YLAF_Helper_Utils imageName:@"zdimageb3"] forState:0];
    self.zd33_fblogBtn.layer.cornerRadius = 6;
    self.zd33_fblogBtn.clipsToBounds = true;
    [self.zd33_fblogBtn addTarget:self action:@selector(zd32_HandleClickedFaceBooklogBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_viewBg addSubview:self.zd33_fblogBtn];
    
    
    
    
    self.zd31_verifyProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.zd33_fblogBtn.frame)+15+45, 35, 35);
    self.zd31_verifyProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    
    [self.zd31_verifyProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageunPick"] forState:UIControlStateNormal];
    [self.zd31_verifyProtoclBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagepick"] forState:UIControlStateSelected];
    self.zd31_verifyProtoclBtn.selected = true;
    [self.zd31_verifyProtoclBtn addTarget:self action:@selector(onClickRegisterCheckProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd31_verifyProtoclBtn];
    
    
    
    
    
    self.khxl_protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.khxl_protocolBtn.frame = CGRectMake(self.zd31_verifyProtoclBtn.blmg_right+5,self.zd31_verifyProtoclBtn.blmg_top + 5,  self.zd33_viewBg.blmg_width, 25);
    self.khxl_protocolBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_SmallFont];
    self.khxl_protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.khxl_protocolBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -11.5, 0, 0);
    [self.khxl_protocolBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_RegisterProtocol_Text") forState:UIControlStateNormal];
    [self.khxl_protocolBtn setTitleColor:[YLAF_Theme_Utils khxl_color_GrayColor] forState:UIControlStateNormal];
    [self.khxl_protocolBtn addTarget:self action:@selector(onClickRegisterProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.khxl_protocolBtn];
    
    
    
    
    if (@available(iOS 13.0, *)) {
        if (MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagApple) {
            if (MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagFB) {
                
            } else {
                self.zd33_fblogBtn.hidden = YES;
                self.zd31_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.zd31_cusRegBtn.frame)+15+45, 35, 35);
                self.khxl_protocolBtn.frame = CGRectMake(self.zd31_verifyProtoclBtn.blmg_right+5,self.zd31_verifyProtoclBtn.blmg_top + 5,  self.zd33_viewBg.blmg_width, 25);
            }
        } else {
            if (MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagFB) {
            } else {
                self.zd33_fblogBtn.hidden = YES;
                self.zd31_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.zd31_cusRegBtn.frame)+15+45, 35, 35);
                self.khxl_protocolBtn.frame = CGRectMake(self.zd31_verifyProtoclBtn.blmg_right+5,self.zd31_verifyProtoclBtn.blmg_top + 5,  self.zd33_viewBg.blmg_width, 25);
            }
        }
    } else {
        if (MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagFB) {
        } else {
            self.zd33_fblogBtn.hidden = YES;
            self.zd31_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.zd31_cusRegBtn.frame)+15+45, 35, 35);
            self.khxl_protocolBtn.frame = CGRectMake(self.zd31_verifyProtoclBtn.blmg_right+5,self.zd31_verifyProtoclBtn.blmg_top + 5,  self.zd33_viewBg.blmg_width, 25);
        }
    }
    
   
}
- (void)onClickRegisterCheckProtoclBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
//    [self zd32_u_UpdateButtonStates];
}

- (void)onClickRegisterProtoclBtn:(id)sender {
//    self.zd31_verifyProtoclBtn.selected = YES;
//    [self zd32_u_UpdateButtonStates];
    
    [MYMGSDKGlobalInfo zd32_PresendWithUrlString:MYMGSDKGlobalInfo.reg_agree];
}

- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd33_CloseChooseLoginView:loginSucess:)]) {
        [self.delegate zd33_CloseChooseLoginView:self loginSucess:NO];
    }
}

- (void)zd32_HandleCilckedQuicklogBtn:(id)sender {
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd32_LoginServer lhxy_QuickLogin:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_CloseChooseLoginView:loginSucess:)]) {
                [weakSelf.delegate zd33_CloseChooseLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd32_HandleClickedFaceBooklogBtn:(id)sender {
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 13.0, *)) {
        [MBProgressHUD zd32_ShowLoadingHUD];
    }
    [self.zd32_LoginServer lhxy_FacebookLogin:^{
        if (@available(iOS 13.0, *)) {
        } else {
            [MBProgressHUD zd32_ShowLoadingHUD];
        }
    } responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_CloseChooseLoginView:loginSucess:)]) {
                [weakSelf.delegate zd33_CloseChooseLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
             [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd32_HandleClickedRegisterBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd33_PresentAccountLoginAndRegisterView:)]) {
        [self.delegate zd33_PresentAccountLoginAndRegisterView:self];
    }
}


@end
