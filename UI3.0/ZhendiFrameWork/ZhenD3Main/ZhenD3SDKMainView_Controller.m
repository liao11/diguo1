
#import "ZhenD3SDKMainView_Controller.h"

#import "ZhenD3AutoLogin_View.h"
#import "ZhenD3AccountLogin_View.h"
#import "ZhenD3Register_View.h"
#import "ZhenD3ResetPwd_View.h"
#import "ZhenD3BindEmail_View.h"
#import "YLAF_Shortcut_View.h"
#import "ZhenD3Account_View.h"
#import "ZhenD3PersonalCenter_View.h"
#import "ZhenD3AccountUpgrade_View.h"
#import "ZhenD3ModifyPwd_View.h"
#import "ZhenD3PresentPackage_View.h"
#import "ZhenD3CustomerService_View.h"
#import "ZhenD3GuestAccountPrompt_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenD3OneClickLoginV.h"
#import "ZhenD3LocalData_Server.h"
#import "ZhenD3TelDataServer.h"
#import "ZhenD3OpenAPI.h"
#import "ZhenD3SDKGlobalInfo_Entity.h"
#import "UIView+GrossExtension.h"
#import "YLAF_Theme_Utils.h"
#import "ZhenD3ChooseLoginView.h"
#import "ZhenD3Login_View.h"
#import "YLAF_RecentNewsV.h"
#import "YLAF_ChongRecordV.h"
#import "ZhenD3TaskCenterV.h"
#import "YLAF_CouponV.h"
#import "ZhenD3OutConfirmV.h"
#import "YLAF_MyAccV.h"
#import "ZhenD3BindTelView.h"
#import "YLAF_IntegralShopV.h"
#import "YLAF_RecentNews2V.h"
@interface ZhenD3SDKMainView_Controller () <YLAH_AutoLogin_ViewDelegate, YLAH_AccountLogin_ViewDelegate, YLAH_RegisterViewDelegate, YLAH_ResetPwd_ViewDelegate, YLAH_ModifyPwd_ViewDelegate, YLAH_BindEmail_ViewDelegate, YLAH_Account_ViewDelegate, YLAH_CustomerService_ViewDelegate, YLAH_PersonalCenter_ViewDelegate, YLAH_AccountUpgrade_ViewDelegate, YLAH_GuestAccountPrompt_ViewDelegate, YLAH_PresentPackage_ViewDelegate,YLAH_Login_ViewDelegate,YLAF_RecentNewsVDelegate,YLAF_ChongRecordVDelegate,YLAH_TaskCenterVDelegate,YLAF_CouponVDelegate,YLAH_OutConfirmVDelegate,YLAF_MyAccVDelegate,YLAH_BindTelViewDelegate,YLAF_IntegralShopVDelegate,YLAH_ChooseLoginViewDelegate,YLAH_OneClickLoginVDelegate,YLAF_RecentNews2VDelegate>

@property (nonatomic, strong) ZhenD3Login_View *zd33_LoginView;
@property (nonatomic, strong) ZhenD3AutoLogin_View *zd31_AutoLoginView;
@property (nonatomic, strong) ZhenD3AccountLogin_View *zd32_AccountLoginView;
@property (nonatomic, strong) ZhenD3Register_View *khxl_RegisterView;
@property (nonatomic, strong) ZhenD3ResetPwd_View *zd3_ResetPwdView;
@property (nonatomic, strong) ZhenD3BindEmail_View *zd33_BindEmailView;
@property (nonatomic, strong) ZhenD3PersonalCenter_View *blmg_PersonalCenterView;
@property (nonatomic, strong) ZhenD3AccountUpgrade_View *zd31_AccountUpgradeView;
@property (nonatomic, strong) ZhenD3ModifyPwd_View *khxl_ModifyPasswordView;
@property (nonatomic, strong) ZhenD3PresentPackage_View *zd33_presentPackageView;
@property (nonatomic, strong) ZhenD3GuestAccountPrompt_View *zd3_GuestAccountPromptView;
@property (nonatomic, strong) ZhenD3Account_View *blmg_AccountView;
@property (nonatomic, strong) ZhenD3CustomerService_View *zd32_CustomerServiceView;
@property (nonatomic, strong) YLAF_RecentNewsV *lhxy_rencentV;
@property (nonatomic, strong) YLAF_RecentNews2V *lhxy_rencent2V;

@property (nonatomic, strong) YLAF_ChongRecordV *zd33_chongV;
@property (nonatomic, strong) ZhenD3TaskCenterV *blmg_taskV;
@property (nonatomic, strong) YLAF_CouponV *lhxy_couponV;
@property (nonatomic, strong) ZhenD3OutConfirmV *khxl_confirmV;
@property (nonatomic, strong) YLAF_MyAccV *blmg_accV;
@property (nonatomic, strong) YLAF_IntegralShopV *zd31_shopV;
@property (nonatomic, strong) ZhenD3BindTelView *zd33_tieTelV;
@property (nonatomic, strong) ZhenD3ChooseLoginView *blmg_chooseLoginV;
@property (nonatomic, strong) ZhenD3OneClickLoginV *zd32_oneClickV;
@end

@implementation ZhenD3SDKMainView_Controller

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = [UIScreen mainScreen].bounds;
    _zd33_LoginView.center = self.center;
    _zd31_AutoLoginView.center = self.center;
    _zd32_AccountLoginView.center = self.center;
    _khxl_RegisterView.center = self.center;
    _zd3_ResetPwdView.center = self.center;
    _zd33_BindEmailView.center = self.center;
    _blmg_PersonalCenterView.center = self.center;
    _zd31_AccountUpgradeView.center = self.center;
    _khxl_ModifyPasswordView.center = self.center;
    _zd33_presentPackageView.center = self.center;
    _zd3_GuestAccountPromptView.center = self.center;
    _blmg_AccountView.center = self.center;
    _zd32_CustomerServiceView.center = self.center;
    _zd33_chongV.center = self.center;
    _blmg_taskV.center = self.center;
    _lhxy_rencentV.center = self.center;
    _lhxy_couponV.center = self.center;
    _khxl_confirmV.center = self.center;
    _blmg_accV.center = self.center;
    _zd31_shopV.center = self.center;
    _zd33_tieTelV.center = self.center;
    _blmg_chooseLoginV.center = self.center;
    _zd32_oneClickV.center = self.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_zd32_AccountLoginView zd31_HiddenHistoryTable];
    [self endEditing:YES];
}


- (ZhenD3Login_View *)zd33_LoginView {
    if (!_zd33_LoginView) {
        _zd33_LoginView = [[ZhenD3Login_View alloc] init];
        _zd33_LoginView.delegate = self;
    }
    return _zd33_LoginView;
}

- (ZhenD3ChooseLoginView *)blmg_chooseLoginV{
    if (!_blmg_chooseLoginV) {
        _blmg_chooseLoginV = [[ZhenD3ChooseLoginView alloc] init];
        _blmg_chooseLoginV.delegate = self;
    }
    return _blmg_chooseLoginV;
}

- (ZhenD3AutoLogin_View *)zd31_AutoLoginView {
    if (!_zd31_AutoLoginView) {
        _zd31_AutoLoginView = [[ZhenD3AutoLogin_View alloc] init];
        _zd31_AutoLoginView.delegate = self;
    }
    return _zd31_AutoLoginView;
}

- (ZhenD3AccountLogin_View *)zd32_AccountLoginView {
    if (!_zd32_AccountLoginView) {
        _zd32_AccountLoginView = [[ZhenD3AccountLogin_View alloc] init];
        _zd32_AccountLoginView.delegate = self;
    }
    return _zd32_AccountLoginView;
}

- (ZhenD3Register_View *)khxl_RegisterView {
    if (!_khxl_RegisterView) {
        _khxl_RegisterView = [[ZhenD3Register_View alloc] init];
        _khxl_RegisterView.delegate = self;
    }
    return _khxl_RegisterView;
}

- (ZhenD3OneClickLoginV *)zd32_oneClickV{
    if (!_zd32_oneClickV) {
        _zd32_oneClickV = [[ZhenD3OneClickLoginV alloc] init];
        _zd32_oneClickV.delegate = self;
    }
    return _zd32_oneClickV;
}

- (ZhenD3ResetPwd_View *)zd3_ResetPwdView {
    if (!_zd3_ResetPwdView) {
        _zd3_ResetPwdView = [[ZhenD3ResetPwd_View alloc] init];
        _zd3_ResetPwdView.delegate = self;
    }
    return _zd3_ResetPwdView;
}

- (ZhenD3BindEmail_View *)zd33_BindEmailView {
    if (!_zd33_BindEmailView) {
        _zd33_BindEmailView = [[ZhenD3BindEmail_View alloc] init];
        _zd33_BindEmailView.delegate = self;
    }
    return _zd33_BindEmailView;
}

- (ZhenD3BindTelView *)zd33_tieTelV{
    if (!_zd33_tieTelV) {
        _zd33_tieTelV = [[ZhenD3BindTelView alloc]init];
        _zd33_tieTelV.delegate = self;
    }
    return _zd33_tieTelV;
}

- (ZhenD3PersonalCenter_View *)blmg_PersonalCenterView {
    if (!_blmg_PersonalCenterView) {
        _blmg_PersonalCenterView = [[ZhenD3PersonalCenter_View alloc] init];
        _blmg_PersonalCenterView.delegate = self;
    }
    return _blmg_PersonalCenterView;
}

- (ZhenD3AccountUpgrade_View *)zd31_AccountUpgradeView {
    if (!_zd31_AccountUpgradeView) {
        _zd31_AccountUpgradeView = [[ZhenD3AccountUpgrade_View alloc] init];
        _zd31_AccountUpgradeView.delegate = self;
    }
    return _zd31_AccountUpgradeView;
}

- (ZhenD3ModifyPwd_View *)khxl_ModifyPasswordView {
    if (!_khxl_ModifyPasswordView) {
        _khxl_ModifyPasswordView = [[ZhenD3ModifyPwd_View alloc] init];
        _khxl_ModifyPasswordView.delegate = self;
    }
    return _khxl_ModifyPasswordView;
}

- (ZhenD3PresentPackage_View *)zd33_presentPackageView {
    if (!_zd33_presentPackageView) {
        _zd33_presentPackageView = [[ZhenD3PresentPackage_View alloc] init];
        _zd33_presentPackageView.delegate = self;
    }
    return _zd33_presentPackageView;
}

- (ZhenD3GuestAccountPrompt_View *)zd3_GuestAccountPromptView {
    if (!_zd3_GuestAccountPromptView) {
        _zd3_GuestAccountPromptView = [[ZhenD3GuestAccountPrompt_View alloc] init];
        _zd3_GuestAccountPromptView.delegate = self;
    }
    return _zd3_GuestAccountPromptView;
}

- (ZhenD3Account_View *)blmg_AccountView {
    if (!_blmg_AccountView) {
        _blmg_AccountView = [[ZhenD3Account_View alloc] init];
        _blmg_AccountView.delegate = self;
    }
    return _blmg_AccountView;
}

- (ZhenD3CustomerService_View *)zd32_CustomerServiceView {
    if (!_zd32_CustomerServiceView) {
        _zd32_CustomerServiceView = [[ZhenD3CustomerService_View alloc] init];
        _zd32_CustomerServiceView.delegate = self;
    }
    return _zd32_CustomerServiceView;
}


- (YLAF_RecentNewsV *)lhxy_rencentV {
    if (!_lhxy_rencentV) {
        _lhxy_rencentV = [[YLAF_RecentNewsV alloc] init];
        _lhxy_rencentV.delegate = self;
    }
    return _lhxy_rencentV;
}



- (YLAF_RecentNews2V *)lhxy_rencent2V {
    if (!_lhxy_rencent2V) {
        _lhxy_rencent2V = [[YLAF_RecentNews2V alloc] init];
        _lhxy_rencent2V.delegate = self;
    }
    return _lhxy_rencent2V;
}

- (YLAF_ChongRecordV *)zd33_chongV {
    if (!_zd33_chongV) {
        _zd33_chongV = [[YLAF_ChongRecordV alloc] init];
        _zd33_chongV.delegate = self;
    }
    return _zd33_chongV;
}

- (ZhenD3TaskCenterV *)blmg_taskV {
    if (!_blmg_taskV) {
        _blmg_taskV = [[ZhenD3TaskCenterV alloc] init];
        _blmg_taskV.delegate = self;
    }
    return _blmg_taskV;
}

- (YLAF_CouponV *)lhxy_couponV {
    if (!_lhxy_couponV) {
        _lhxy_couponV = [[YLAF_CouponV alloc] init];
        _lhxy_couponV.delegate = self;
    }
    return _lhxy_couponV;
}

- (YLAF_MyAccV *)blmg_accV{
    if (!_blmg_accV) {
        _blmg_accV = [[YLAF_MyAccV alloc] init];
        _blmg_accV.delegate = self;
    }
    return _blmg_accV;
}

- (YLAF_IntegralShopV *)zd31_shopV{
    if (!_zd31_shopV) {
        _zd31_shopV = [[YLAF_IntegralShopV alloc] init];
        _zd31_shopV.delegate = self;
    }
    return _zd31_shopV;
}

- (ZhenD3OutConfirmV *)khxl_confirmV
{
    if (!_khxl_confirmV) {
        _khxl_confirmV = [[ZhenD3OutConfirmV alloc]init];
        _khxl_confirmV.delegate = self;
    }
    return _khxl_confirmV;
}

- (void)zd33_CloseLoginView:(ZhenD3Login_View *)loginView loginSucess:(BOOL)success {
    if (success) {
        [self zd32_u_HandleLoginSuccessedAtView:loginView];
    } else {
        MYMGSDKGlobalInfo.isShowedLoginView = NO;
        [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    }
}

- (void)zd33_RegisterAtLoginView:(ZhenD3Login_View *)loginView {
    [self zd32_u_PushView:self.khxl_RegisterView fromView:loginView animated:YES];
}

- (void)zd33_PushAccountLoginView:(ZhenD3Login_View *)loginView {
    [self zd32_u_PushView:self.zd32_AccountLoginView fromView:loginView animated:YES];
}

- (void)zd33_PresentAccountLoginAndRegisterView:(ZhenD3ChooseLoginView *)loginView{
    [self zd32_u_PushView:self.zd32_oneClickV fromView:loginView animated:YES];
}

- (void)zd31_HandlePopToLastV:(ZhenD3OneClickLoginV *)registerView{
    [self zd32_u_PushView:self.blmg_chooseLoginV fromView:registerView animated:YES];
}

- (void)zd33_PresentFromOneClickToLogin:(ZhenD3OneClickLoginV *)registerView{
    [self zd32_u_PushView:self.zd33_LoginView fromView:registerView animated:YES];
}

- (void)zd31_HandleDidOneClickEmailSuccess:(ZhenD3OneClickLoginV *)registerView{
    MYMGSDKGlobalInfo.isShowedLoginView = NO;
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    [YLAF_Shortcut_View zd32_ShowShort];
}

- (void)zd33_FastAutLoginView:(ZhenD3AutoLogin_View *)autoLoginView loginSucess:(BOOL)success {
    if (success) {
        [self zd32_u_HandleLoginSuccessedAtView:autoLoginView];
    } else {
        [self zd32_u_PushView:self.zd32_AccountLoginView fromView:autoLoginView animated:YES];
    }
}


- (void)zd33_CloseAccountLoginView:(ZhenD3Login_View *)accountLoginView loginSucess:(BOOL)success {
    if (success) {
        [self zd32_u_HandleLoginSuccessedAtView:accountLoginView];
    } else {
        [self zd32_u_PushView:self.zd32_oneClickV fromView:accountLoginView animated:YES];
    }
}

- (void)zd33_CloseChooseLoginView:(ZhenD3ChooseLoginView *)loginView loginSucess:(BOOL)success{
    if (success) {
        [self zd32_u_HandleLoginSuccessedAtView:loginView];
    }else{
        [self zd32_u_PushView:self.blmg_chooseLoginV fromView:loginView animated:YES];
    }
}

- (void)zd33_ForgetPwdAtLoginView:(ZhenD3Login_View *)accountLoginView {
    self.zd3_ResetPwdView.isFromLogin = true;
    [self zd32_u_PushView:self.zd3_ResetPwdView fromView:accountLoginView animated:YES];
}


- (void)zd31_HandlePopRegisterView:(ZhenD3Register_View *)registerView {
    [self zd32_u_PushView:self.zd33_LoginView fromView:registerView animated:YES];
}

- (void)zd31_HandleDidRegistSuccess:(ZhenD3Register_View *)registerView {
    MYMGSDKGlobalInfo.isShowedLoginView = NO;
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    [YLAF_Shortcut_View zd32_ShowShort];
}


- (void)zd31_onClickCloseResetPwdView_Delegate:(ZhenD3ResetPwd_View *)resetPwdView isFromLogin:(BOOL)isFromLogin{
    if (isFromLogin) {
        [self zd32_u_PushView:self.zd33_LoginView fromView:resetPwdView animated:YES];
    }else{
        [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    }
}

- (void)zd31_resetPwdSuccess_Delegate:(ZhenD3ResetPwd_View *)resetPwdView {
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)zd31_HandleCloseModifyPwdView_Delegate:(ZhenD3ModifyPwd_View *)modifyPwdView {
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)zd31_handleClosedBindEmailView_Delegate:(ZhenD3BindEmail_View *)bindEmailView {
    if (bindEmailView.zd31_HandleBeforeClosedView) {
        [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    } else {
        if (bindEmailView.zd31_fromFlags == 1) {
            [self zd32_u_PushView:self.blmg_PersonalCenterView fromView:bindEmailView animated:YES];
        } else {
            [self zd32_u_PushView:self.blmg_AccountView fromView:bindEmailView animated:YES];
        }
    }
    
}

- (void)zd31_handleBindEmailSuccess_Delegate:(ZhenD3BindEmail_View *)bindEmailView {
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleClosedBindTelView_Delegate:(ZhenD3BindTelView *)bindTelView{
    if (bindTelView.zd31_HandleBeforeClosedView) {
        [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    } else {
        if (bindTelView.zd31_fromFlags == 1) {
            [self zd32_u_PushView:self.blmg_PersonalCenterView fromView:bindTelView animated:YES];
        } else {
            [self zd32_u_PushView:self.blmg_AccountView fromView:bindTelView animated:YES];
        }
    }
}

- (void)zd31_handleBindTelSuccess_Delegate:(ZhenD3BindTelView *)bindTelView{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)zd31_handleCloseAccount_Delegate:(ZhenD3Account_View *)accountView {
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleAccount_Delegate:(ZhenD3Account_View *)accountView onClickBtn:(NSInteger)tag {
    switch (tag) {
        case 0:
            [self zd32_u_PushView:self.blmg_PersonalCenterView fromView:accountView animated:YES];
            break;
        case 1:
            self.zd31_AccountUpgradeView.zd31_HandleBeforeClosedView = nil;
            [self zd32_u_PushView:self.zd31_AccountUpgradeView fromView:accountView animated:YES];
            break;
        case 2:
            self.zd33_BindEmailView.zd31_HandleBeforeClosedView = nil;
            self.zd33_BindEmailView.zd31_fromFlags = 0;
            [self zd32_u_PushView:self.zd33_BindEmailView fromView:accountView animated:YES];
            break;
        case 3:
            [self zd32_u_PushView:self.khxl_ModifyPasswordView fromView:accountView animated:YES];
            break;
        case 4:
            [self zd32_u_PushView:self.zd33_presentPackageView fromView:accountView animated:YES];
            break;
        case 5:
            [ZhenD3OpenAPI logout:NO];
            [self zd32_u_PushView:self.zd33_LoginView fromView:nil animated:NO];
            break;
        default:
            break;
    }
}

- (void)zd31_handleClosePersonalCenter_Delegate:(ZhenD3PersonalCenter_View *)personalCenter {
//    [self zd32_u_PushView:self.blmg_AccountView fromView:personalCenter animated:YES];
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleBindEmailInPersonalCenter_Delegate:(ZhenD3PersonalCenter_View *)personalCenter {
    self.zd33_BindEmailView.zd31_HandleBeforeClosedView = nil;
    self.zd33_BindEmailView.zd31_fromFlags = 1;
    [self zd32_u_PushView:self.zd33_BindEmailView fromView:personalCenter animated:YES];
}


- (void)zd31_HandleDismissAccountUpgradeView_Delegate:(ZhenD3AccountUpgrade_View *)accountUpgradeView {
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    [YLAF_Shortcut_View zd32_ShowShort];
}

- (void)zd31_HandlePopAccountUpgradeView_Delegate:(ZhenD3AccountUpgrade_View *)accountUpgradeView {
    if (accountUpgradeView.zd31_HandleBeforeClosedView) {
        [self zd32_u_MainViewRemoveFromSuperviewAndClear];
    } else {
        [self zd32_u_PushView:self.blmg_AccountView fromView:accountUpgradeView animated:YES];
    }
}


- (void)zd31_HandleClosePresentPackageView_Delegate:(ZhenD3PresentPackage_View *)view {
//    [self zd32_u_PushView:self.blmg_AccountView fromView:view animated:YES];
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)zd31_HandleCloseCustomerServiceView_Delegate:(ZhenD3CustomerService_View *)accountView {
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)zd31_HandleClosePromptView:(ZhenD3GuestAccountPrompt_View *)promptView {
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_HandleUpgrateFromPromptView:(ZhenD3GuestAccountPrompt_View *)promptView upgrateCompletion:(void(^)(void))completion {
    self.zd31_AccountUpgradeView.zd31_HandleBeforeClosedView = completion;
    [self zd32_u_PushView:self.zd31_AccountUpgradeView fromView:promptView animated:YES];
}

- (void)zd31_handleCloseRecentNewsV:(YLAF_RecentNewsV *)recentNewsV{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)zd31_handleCloseRecentNews2V:(YLAF_RecentNews2V *)recentNewsV{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)zd31_handleCloseChongRecordV:(YLAF_ChongRecordV *)memberV{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleCloseTaskV:(ZhenD3TaskCenterV *)zd32_taskV{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleCloseChongCouponV:(YLAF_CouponV *)zd33_couponV{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleCloseOutConfirmV:(ZhenD3OutConfirmV *)confirmV{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleCloseChongMyAccV:(YLAF_MyAccV *)accV{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)zd31_handleCloseIntegralShopV:(YLAF_IntegralShopV *)zd32_V{
    [self zd32_u_MainViewRemoveFromSuperviewAndClear];
}

+ (void)zd31_showLoginView {
    if (MYMGSDKGlobalInfo.isShowedLoginView) return;
    MYMGSDKGlobalInfo.isShowedLoginView = YES;
    
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    
    ZhenD3UserInfo_Entity *lastLoginUser;
    if (MYMGSDKGlobalInfo.lastWayLogin == YES) {
        lastLoginUser = [ZhenD3TelDataServer zd32_loadAllSavedLoginedUser].lastObject;
    }else{
        NSArray *historyAccounts = [ZhenD3LocalData_Server zd32_loadAllSavedLoginedUser];
        lastLoginUser = historyAccounts.lastObject;
    }
    if (lastLoginUser && MYMGSDKGlobalInfo.sdkIsLogin == YES) {
        [mainView zd32_u_PushView:mainView.zd31_AutoLoginView fromView:nil animated:NO];
        [mainView.zd31_AutoLoginView zd31_AutoLoginWithLastLoginUser:lastLoginUser];
    } else {
        [mainView zd32_u_PushView:mainView.blmg_chooseLoginV fromView:nil animated:NO];
    }
}

+ (void)zd31_showAccountView {
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.blmg_AccountView fromView:nil animated:NO];
}

+ (void)zd31_showCustomerServiceView {
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.zd32_CustomerServiceView fromView:nil animated:NO];
}

+ (void)zd32_showRencentV {
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.lhxy_rencentV fromView:nil animated:NO];
}

+ (void)zd32_showRencent2V {
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.lhxy_rencent2V fromView:nil animated:NO];
}

+ (void)zd32_showChongV {
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.zd33_chongV fromView:nil animated:NO];
}

+ (void)blmg_showTaskV {
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.blmg_taskV fromView:nil animated:NO];
}

+ (void)zd32_showCouponV{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.lhxy_couponV fromView:nil animated:NO];
}

+ (void)blmg_showMyAccV{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.blmg_accV fromView:nil animated:NO];
}

+ (void)zd31_showMyShopV{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.zd31_shopV fromView:nil animated:NO];
}

+ (void)zd32_showConfirmV{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.khxl_confirmV fromView:nil animated:NO];
}

+ (void)zd31_logoutAction{
    [ZhenD3OpenAPI logout:NO];
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.blmg_chooseLoginV fromView:nil animated:NO];
}

+ (void)zd33_showModifyPwdV{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.zd3_ResetPwdView.isFromLogin = false;
    [mainView zd32_u_PushView:mainView.zd3_ResetPwdView fromView:nil animated:NO];
}

+ (void)zd33_showPresentV{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.zd33_presentPackageView fromView:nil animated:NO];
}

+ (void)zd33_showUpgradVCompletion:(void(^)(void))completion{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.zd31_AccountUpgradeView.zd31_HandleBeforeClosedView = completion;
    [mainView zd32_u_PushView:mainView.zd31_AccountUpgradeView fromView:nil animated:NO];
    
}


+ (void)zd33_showTieMailCompletion:(void(^)(void))completion{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.zd33_BindEmailView.zd31_HandleBeforeClosedView = completion;
    [mainView zd32_u_PushView:mainView.zd33_BindEmailView fromView:nil animated:NO];
    
}

+ (void)zd33_showBindTelCompletion:(void(^)(void))completion{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.zd33_tieTelV.zd31_HandleBeforeClosedView = completion;
    [mainView zd32_u_PushView:mainView.zd33_tieTelV fromView:nil animated:NO];
    
}

+ (void)zd33_showBindTelVWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.zd33_tieTelV.blmg_needTiePresent = true;
    mainView.zd33_tieTelV.zd31_gameId = zd31_gameId;
    mainView.zd33_tieTelV.zd32_roleId = zd32_roleId;
    [mainView zd32_u_PushView:mainView.zd33_tieTelV fromView:nil animated:NO];
}

+ (void)zd32_showPersonInfoV{
    UIView *view = [self zd32_u_GetCurrentWindowView];
    ZhenD3SDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
            mainView = (ZhenD3SDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView zd32_u_PushView:mainView.blmg_PersonalCenterView fromView:nil animated:NO];
}

+ (UIView *)zd32_u_GetCurrentWindowView {
    
    return YLMXGSDKAPI.context.view;
}

- (void)zd32_u_MainViewRemoveFromSuperviewAndClear {
    [self removeFromSuperview];
}

- (void)zd32_u_HandleLoginSuccessedAtView:(UIView *)view {
    MYMGSDKGlobalInfo.isShowedLoginView = NO;
    if ((MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagBindemail) && MYMGSDKGlobalInfo.userInfo.accountType == YLAF_AccountTypeGuest && MYMGSDKGlobalInfo.userInfo.isReg == NO) {
        self.zd3_GuestAccountPromptView.zd31_HandleBeforeClosedView = ^{
            [YLAF_Shortcut_View zd32_ShowShort];
        };
        [self zd32_u_PushView:self.zd3_GuestAccountPromptView fromView:view animated:YES];
    } else {
        [self zd32_u_MainViewRemoveFromSuperviewAndClear];
        [YLAF_Shortcut_View zd32_ShowShort];
    }
    
    
    
    
    
    
}

- (void)zd32_u_PushView:(UIView *)view fromView:(UIView *)parentView animated:(BOOL)animated {
    if (parentView == nil) {
        [self blmg_removeAllSubviews];
    }
    
    if ([self.subviews containsObject:view] == NO) {
        [self addSubview:view];
    }
    
    [self.superview bringSubviewToFront:self];
    
    if (animated) {
        view.alpha = 0.5f;
        [UIView animateWithDuration:0.25 animations:^{
            parentView.alpha = 0.0;
            view.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        view.alpha = 1.0;
        view.hidden = NO;
        parentView.hidden = YES;
    }
}

@end
