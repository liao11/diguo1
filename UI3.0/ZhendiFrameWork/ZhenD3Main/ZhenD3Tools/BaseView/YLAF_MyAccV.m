//
//  YLAF_MyAccV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/18.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_MyAccV.h"
#import "ZhenD3Account_Server.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_RelayoutBtn.h"
#import "ZhenD3SDKMainView_Controller.h"
#import "YLAF_Shortcut_View.h"
#import "GrossAlertCrlV.h"

@interface YLAF_MyAccV ()

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) UIView *zd33_bgV;

@end


@implementation YLAF_MyAccV

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:YES];
    
    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_userAcc")];
    
    [self addSubview:self.zd33_bgV];
        
    YLAF_RelayoutBtn *zd32_personInfoBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
    zd32_personInfoBtn.layoutType = RelayoutTypeUpDown;
    zd32_personInfoBtn.margin = 0;
    zd32_personInfoBtn.frame = CGRectMake(20 + (self.blmg_width - 20)/3 * (double)(0 % 3) ,20 + 70 * (0/3), (self.blmg_width - 40)/3 - 20, 60);
    [zd32_personInfoBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_userDt") forState:UIControlStateNormal];
    zd32_personInfoBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    zd32_personInfoBtn.tag = 100;
    [zd32_personInfoBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageUserInfo"] forState:UIControlStateNormal];
    [zd32_personInfoBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
    [zd32_personInfoBtn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:zd32_personInfoBtn];
    
    YLAF_RelayoutBtn *blmg_pwdBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
    blmg_pwdBtn.layoutType = RelayoutTypeUpDown;
    blmg_pwdBtn.margin = 0;
    blmg_pwdBtn.frame = CGRectMake(20 + (self.blmg_width - 20)/3 * (double)(1 % 3) ,20 + 70 * (1/3), (self.blmg_width - 40)/3 - 20, 60);
    [blmg_pwdBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_revisePsd") forState:UIControlStateNormal];
    blmg_pwdBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    blmg_pwdBtn.tag = 101;
    [blmg_pwdBtn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:blmg_pwdBtn];
    if ((MYMGSDKGlobalInfo.userInfo.accountType == 1 || MYMGSDKGlobalInfo.userInfo.accountType == 6)) {
        blmg_pwdBtn.enabled = true;
        [blmg_pwdBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagerevisePwd"] forState:UIControlStateNormal];
        [blmg_pwdBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
    }else{
        blmg_pwdBtn.enabled = false;
        [blmg_pwdBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagerevisePwd_disable"] forState:UIControlStateDisabled];
        [blmg_pwdBtn setTitleColor:[YLAF_Theme_Utils khxl_SmallGrayColor] forState:UIControlStateDisabled];
    }
    
    YLAF_RelayoutBtn *zd33_userBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
    zd33_userBtn.layoutType = RelayoutTypeUpDown;
    zd33_userBtn.margin = 0;
    zd33_userBtn.frame = CGRectMake(20 + (self.blmg_width - 20)/3 * (double)(2 % 3) ,20 + 70 * (2/3), (self.blmg_width - 40)/3 - 20, 60);
    [zd33_userBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_userUp") forState:UIControlStateNormal];
    zd33_userBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    zd33_userBtn.tag = 102;
    [zd33_userBtn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:zd33_userBtn];
    if ((MYMGSDKGlobalInfo.userInfo.accountType == 2)) {
        zd33_userBtn.enabled = true;
        [zd33_userBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageup"] forState:UIControlStateNormal];
        [zd33_userBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
    }else{
        zd33_userBtn.enabled = false;
        [zd33_userBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageup_disable"] forState:UIControlStateDisabled];
        [zd33_userBtn setTitleColor:[YLAF_Theme_Utils khxl_SmallGrayColor] forState:UIControlStateDisabled];
    }
    
    YLAF_RelayoutBtn *zd31_mailBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
    zd31_mailBtn.layoutType = RelayoutTypeUpDown;
    zd31_mailBtn.margin = 0;
    zd31_mailBtn.frame = CGRectMake(20 + (self.blmg_width - 20)/3 * (double)(3 % 3) ,20 + 70 * (3/3), (self.blmg_width - 40)/3 - 20, 60);
    [zd31_mailBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_tiMail") forState:UIControlStateNormal];
    zd31_mailBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    zd31_mailBtn.tag = 103;
    [zd31_mailBtn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:zd31_mailBtn];
    if (((MYMGSDKGlobalInfo.userInfo.accountType == 3) || ((MYMGSDKGlobalInfo.userInfo.accountType == 6) && !MYMGSDKGlobalInfo.userInfo.isBindEmail))) {
        zd31_mailBtn.enabled = true;
        [zd31_mailBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagemail"] forState:UIControlStateNormal];
        [zd31_mailBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
    }else{
        zd31_mailBtn.enabled = false;
        [zd31_mailBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagemail_disable"] forState:UIControlStateDisabled];
        [zd31_mailBtn setTitleColor:[YLAF_Theme_Utils khxl_SmallGrayColor] forState:UIControlStateDisabled];
    }
    
    YLAF_RelayoutBtn *zd3_telBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
    zd3_telBtn.layoutType = RelayoutTypeUpDown;
    zd3_telBtn.margin = 0;
    zd3_telBtn.frame = CGRectMake(20 + (self.blmg_width - 20)/3 * (double)(4 % 3) ,20 + 70 * (4/3), (self.blmg_width - 40)/3 - 20, 60);
    [zd3_telBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_tiTel") forState:UIControlStateNormal];
    zd3_telBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    zd3_telBtn.tag = 104;
    [zd3_telBtn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:zd3_telBtn];
    if (!MYMGSDKGlobalInfo.userInfo.isBindMobile) {
        zd3_telBtn.enabled = true;
        [zd3_telBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagetieTel"] forState:UIControlStateNormal];
        [zd3_telBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
    }else{
        zd3_telBtn.enabled = false;
        [zd3_telBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagetieTel_disable"] forState:UIControlStateDisabled];
        [zd3_telBtn setTitleColor:[YLAF_Theme_Utils khxl_SmallGrayColor] forState:UIControlStateDisabled];
    }
    
    YLAF_RelayoutBtn *khxl_cusBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
    khxl_cusBtn.layoutType = RelayoutTypeUpDown;
    khxl_cusBtn.margin = 0;
    khxl_cusBtn.frame = CGRectMake(20 + (self.blmg_width - 20)/3 * (double)(5 % 3) ,20 + 70 * (5/3), (self.blmg_width - 40)/3 - 20, 60);
    [khxl_cusBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_CustomerService_Text") forState:UIControlStateNormal];
    khxl_cusBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    khxl_cusBtn.tag = 105;
    [khxl_cusBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagecustomerSer"] forState:UIControlStateNormal];
    [khxl_cusBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
    [khxl_cusBtn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:khxl_cusBtn];
    
    YLAF_RelayoutBtn *blmg_destoryBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
    blmg_destoryBtn.layoutType = RelayoutTypeUpDown;
    blmg_destoryBtn.margin = 0;
    blmg_destoryBtn.frame = CGRectMake(20 + (self.blmg_width - 20)/3 * (double)(6 % 3) ,20 + 70 * (6/3), (self.blmg_width - 40)/3 - 20, 60);
    [blmg_destoryBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_AccDel") forState:UIControlStateNormal];
    blmg_destoryBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    blmg_destoryBtn.tag = 106;
    [blmg_destoryBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageAccDel"] forState:UIControlStateNormal];
    [blmg_destoryBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
    [blmg_destoryBtn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:blmg_destoryBtn];
    
}

- (void)zd32_btnClick:(UIButton *)btn
{
    WeakSelf;
    if (btn.tag == 100) {
        
        [ZhenD3SDKMainView_Controller zd32_showPersonInfoV];
        
    }else if (btn.tag == 101) {
        [ZhenD3SDKMainView_Controller zd33_showModifyPwdV];
    }else if (btn.tag == 102) {
        self.zd31_HandleBeforeClosedView = ^{
            [YLAF_Shortcut_View zd32_ShowShort];
        };
        [ZhenD3SDKMainView_Controller zd33_showUpgradVCompletion:weakSelf.zd31_HandleBeforeClosedView];
    }else if (btn.tag == 103) {
        self.zd31_HandleBeforeClosedView = ^{
            [YLAF_Shortcut_View zd32_ShowShort];
        };
        [ZhenD3SDKMainView_Controller zd33_showTieMailCompletion:weakSelf.zd31_HandleBeforeClosedView];
    }else if (btn.tag == 104) {
        self.zd31_HandleBeforeClosedView = ^{
            [YLAF_Shortcut_View zd32_ShowShort];
        };
        [ZhenD3SDKMainView_Controller zd33_showBindTelCompletion:weakSelf.zd31_HandleBeforeClosedView];
    }else if (btn.tag == 105) {
        [ZhenD3SDKMainView_Controller zd31_showCustomerServiceView];
    }else if (btn.tag == 106) {
        WeakSelf;
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_AccDel") message:MUUQYLocalizedString(@"MUUQYKey_isAccDel") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex == 1) {
                NSLog(@"-------确定--------");
                [MBProgressHUD zd32_ShowLoadingHUD];
                [weakSelf blmg_delAccAction];
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text")]];
    }
}

- (void)blmg_delAccAction{
    [self.zd31_AccountServer zd32_delAccResponseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
//            [MBProgressHUD zd32_showSuccess_Toast:MUUQYLocalizedString(@"MUUQYKey_successAccDel")];
            [ZhenD3SDKMainView_Controller zd31_logoutAction];
            
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd32_HandleClickedCloseBtn:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseChongMyAccV:)]) {
        [self.delegate zd31_handleCloseChongMyAccV:self];
    }
}

- (UIView *)zd33_bgV{
    if (!_zd33_bgV) {
        _zd33_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.blmg_width, self.blmg_height - 55 - 25)];
    }
    return _zd33_bgV;
}


- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}


@end
