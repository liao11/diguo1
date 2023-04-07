//
//  YLAF_leftShowVCViewController.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_leftShowVCViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_leftShowCell.h"
#import "YLAF_Helper_Utils.h"
#import "UIView+GrossExtension.h"
#import "YLAF_RelayoutBtn.h"
#import "ZhenD3SDKMainView_Controller.h"
#import "ZhenD3RemoteData_Server.h"
#import "NSString+GrossExtension.h"
#import "YLAF_Shortcut_View.h"
#import "ZhenD3Account_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "UIImageView+WebCache.h"
#import "YLAF_W_ViewController.h"
#import "UIButton+Badge.h"
@interface YLAF_leftShowVCViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *zd32_table;
@property (nonatomic, strong) UIView *khxl_tableHeader;
@property (nonatomic, strong) UIView *khxl_headV;
@property (nonatomic, strong) UIImageView *zd31_userIcon;
@property (nonatomic, strong) UILabel *zd31_userName;
@property (nonatomic, strong) UIButton *blmg_signBtn;
@property (nonatomic, strong) YLAF_RelayoutBtn *zd31_vipBtn;
@property (nonatomic, strong) NSArray *zd33_bgNames;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) NSDictionary *zd33_dict;
@property (nonatomic, strong) NSString *blmg_userExp;
@property (nonatomic, strong) NSString *zd32_meetData;
@end

@implementation YLAF_leftShowVCViewController

- (BOOL)shouldAutorotate{
    return false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zd33_bgNames = nil;
    NSArray *zd33_bgName7 = @[@"zdimagenews",MUUQYLocalizedString(@"MUUQYKey_lastNew"),@"0"];
    NSArray *zd33_bgName8 = @[@"zdimagerecord",MUUQYLocalizedString(@"MUUQYKey_chongCord"),@"1"];
    NSArray *zd33_bgName9 = @[@"zdimagetask",MUUQYLocalizedString(@"MUUQYKey_taskCenter"),@"2"];
    NSArray *zd33_bgName10 = @[@"zdimageShip",MUUQYLocalizedString(@"MUUQYKey_countShip"),@"3"];
    NSArray *zd33_bgName11 = @[@"zdimageperson",MUUQYLocalizedString(@"MUUQYKey_userAcc"),@"4"];
    self.zd33_bgNames = @[zd33_bgName7, zd33_bgName8, zd33_bgName9,zd33_bgName10,zd33_bgName11];
    
    self.view.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
    
    [self.view addSubview:self.zd32_table];
    
    self.zd32_table.tableHeaderView = self.khxl_tableHeader;
    [self.khxl_tableHeader addSubview:self.khxl_headV];
    [self.khxl_headV addSubview:self.zd31_userIcon];
    [self.khxl_headV addSubview:self.zd31_userName];
    [self.khxl_headV addSubview:self.blmg_signBtn];
    [self.khxl_headV addSubview:self.zd31_vipBtn];
    //客服,@"zdimagecustomerSer"
    NSArray *zd33_btnIconArr = @[@"zdimagechong",@"zdimagedisc",@"zdimagepresent",@"zdimageout"];
    NSArray *zd33_btnNameArr = @[MUUQYLocalizedString(@"MUUQYKey_QuickCheckPurchase_Text"),
                                 MUUQYLocalizedString(@"MUUQYKey_OffCount"),
                                 MUUQYLocalizedString(@"MUUQYKey_PresentName_Text"),
                                 MUUQYLocalizedString(@"MUUQYKey_Logout_Text")];
    for (NSInteger i = 0; i<zd33_btnIconArr.count; i++) {
        YLAF_RelayoutBtn *btn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
        btn.layoutType = RelayoutTypeUpDown;
        btn.margin = 5;
        btn.frame = CGRectMake(23 + 55 * i ,self.zd31_userIcon.blmg_bottom + 20, 40, 55);
        [btn setImage:[YLAF_Helper_Utils imageName:zd33_btnIconArr[i]] forState:UIControlStateNormal];
        [btn setTitle:zd33_btnNameArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LeastFont];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(zd32_btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.khxl_headV addSubview:btn];
    }
    
    [self zd31_GetUserInfo];
    
}

- (void)zd31_GetUserInfo {
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_GetUserInfo:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        [weakSelf zd33_reloadUserInterface:result.zd32_responeResult];
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd33_reloadUserInterface:(NSDictionary *)zd32_dict{
    self.zd33_dict = zd32_dict;
    NSString *zd31_account = @"";
    NSString *zd33_level = @"0";
    if (zd32_dict && zd32_dict.count > 0) {
        zd33_level = self.zd33_dict[@"user_level"];
    }
    zd31_account = [NSString stringWithFormat:@"M%@",MYMGSDKGlobalInfo.userInfo.userID];
    self.zd31_userName.text = zd31_account;
    self.blmg_userExp = zd32_dict[@"user_exp"];
    self.zd32_meetData = zd32_dict[@"add_time"];
    [self.zd31_userIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.zd33_dict[@"bind_email"]]] placeholderImage:[YLAF_Helper_Utils imageName:@"zdimagedefaultIcon"]];
    [_zd31_vipBtn setTitle:[NSString stringWithFormat:@" LV %@",zd33_level] forState:UIControlStateNormal];
    BOOL zd32_sign = [self.zd33_dict[@"is_sign"] boolValue];
    if (zd32_sign) {
        self.blmg_signBtn.enabled = false;
    }else{
        self.blmg_signBtn.enabled = true;
    }
    
    if ([[self.zd33_dict[@"is_get_coupon"] stringValue] isEqualToString:@"1"]) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:101];
        btn.badgeValue = @"";
    }
    
    if ([[self.zd33_dict[@"is_get_gift"] stringValue] isEqualToString:@"1"]) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:102];
        btn.badgeValue = @"";
    }
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    btn.badgeValue = @"Ưu đãi";
}

- (void)zd32_btnClick:(UIButton *)btn
{
    if (btn.tag == 100) {
        [self dismissViewControllerAnimated:true completion:^{
            NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : MYMGSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[MYMGSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [MYMGSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
            BOOL zd31_GvCheck = MYMGSDKGlobalInfo.zd31_GvCheck;
            NSString *url = [ZhenD3RemoteData_Server zd32_BuildFinalUrl:zd31_GvCheck?MYMGUrlConfig.zd32_httpsdomain.zd32_returnupsBaseUrl:MYMGUrlConfig.zd32_httpsdomain.zd32_backupsBaseUrl WithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAutoLoginPath andParams:params];

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            
        }];
    }else if (btn.tag == 101) {
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller zd32_showCouponV];
        }];
    }else if (btn.tag == 102) {
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller zd33_showPresentV];
        }];
    }else if (btn.tag == 103) {
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller zd32_showConfirmV];
        }];
    }
}

- (void)zd31_signClick{
    [self zd31_SignAction];
}

- (void)zd31_SignAction{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer lhxy_userSignRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.blmg_signBtn.enabled = false;
        }else if(result.zd32_responseCode == YLAF_ResponseCodeApplePayCancel){
            weakSelf.blmg_signBtn.enabled = false;
            [MBProgressHUD zd32_showSuccess_Toast:result.zd32_responeMsg];
        }else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd31_memberClick
{
    [self dismissViewControllerAnimated:true completion:^{
        NSString *url = [NSString stringWithFormat:@"%@%@",MYMGUrlConfig.zd32_httpsdomain.zd32_baseUrl, MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpMemberLk];
        YLAF_W_ViewController *vc = [[YLAF_W_ViewController alloc] initWithblmg_meetData:self.zd32_meetData zd31_exp:self.blmg_userExp];
        vc.alhm_uString = url;
        [[self zd32_CurrentVC] presentViewController:vc animated:YES completion:nil];
    }];
}

- (UIViewController *)zd32_CurrentVC {
    if (YLMXGSDKAPI.context) {
        return YLMXGSDKAPI.context;
    }
    
    return [YLAF_leftShowVCViewController zd32_u_getCurrentVC];
}


+ (UIViewController *)zd32_u_getCurrentVC
{
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    }
    return [self topViewControllerWithRootViewController:[[UIApplication sharedApplication].windows lastObject].rootViewController];

}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    }
    else {
        return rootViewController;
    }
}

#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.zd33_bgNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier= @"YLAF_leftShowCellId";
    YLAF_leftShowCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[YLAF_leftShowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *zd33_curArr = self.zd33_bgNames[indexPath.row];
    cell.zd31_showIcon.image = [YLAF_Helper_Utils imageName:zd33_curArr[0]];
    cell.zd31_showName.text = zd33_curArr[1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row)
    {
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller zd32_showRencentV];
        }];
    }
    else if (1 == indexPath.row) {
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller zd32_showChongV];
        }];
    }else if (2 == indexPath.row) {
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller blmg_showTaskV];
        }];
    }else if (3 == indexPath.row){
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller zd31_showMyShopV];
        }];
    }else if (4 == indexPath.row){
        [self dismissViewControllerAnimated:true completion:^{
            [ZhenD3SDKMainView_Controller blmg_showMyAccV];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma  mark lazy load

- (UITableView *)zd32_table{
    if (!_zd32_table) {
        _zd32_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCWSCREENWIDTH * 0.75, kCWSCREENHEIGHT) style:UITableViewStyleGrouped];
        _zd32_table.delegate = self;
        _zd32_table.dataSource = self;
        _zd32_table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _zd32_table.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
        UIView *view = [UIView new];
        _zd32_table.tableFooterView = view;
    }
    return _zd32_table;
}

- (UIView *)khxl_tableHeader{
    if (!_khxl_tableHeader) {
        _khxl_tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCWSCREENWIDTH * 0.75 , 200)];
    }
    return _khxl_tableHeader;
}

- (UIView *)khxl_headV{
    if (!_khxl_headV) {
        _khxl_headV = [[UIView alloc] initWithFrame:CGRectMake(15, 15, kCWSCREENWIDTH * 0.75 - 30, 170)];
        _khxl_headV.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
        _khxl_headV.layer.cornerRadius = 6;
    }
    return _khxl_headV;
}

- (UIImageView *)zd31_userIcon{
    if (!_zd31_userIcon) {
        _zd31_userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(23, 20, 60, 60)];
        _zd31_userIcon.image =  [YLAF_Helper_Utils imageName:@"zdimagedefaultIcon"];
    }
    return _zd31_userIcon;
}

- (UILabel *)zd31_userName{
    if (!_zd31_userName) {
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LargeFont];
        _zd31_userName = [[UILabel alloc] initWithFrame:CGRectMake(self.zd31_userIcon.blmg_right + 20, 30, 75, 15)];
        _zd31_userName.font = contFont;
        _zd31_userName.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        _zd31_userName.text = @"";
        _zd31_userName.adjustsFontSizeToFitWidth = true;
    }
    return _zd31_userName;
}

- (UIButton *)blmg_signBtn{
    if (!_blmg_signBtn) {
        _blmg_signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _blmg_signBtn.frame = CGRectMake(self.zd31_userName.blmg_right + 15, 25, 60, 25);
        _blmg_signBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_blmg_signBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_signUp") forState:UIControlStateNormal];
        [_blmg_signBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightColor] forState:UIControlStateNormal];
        _blmg_signBtn.layer.cornerRadius = 6.0f;
        _blmg_signBtn.clipsToBounds = true;
        _blmg_signBtn.layer.borderColor = [YLAF_Theme_Utils khxl_color_LightColor].CGColor;
        _blmg_signBtn.layer.borderWidth = 1.0f;
        [_blmg_signBtn setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
        [_blmg_signBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_hasSign") forState:UIControlStateDisabled];
        [_blmg_signBtn addTarget:self action:@selector(zd31_signClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blmg_signBtn;
}

- (YLAF_RelayoutBtn *)zd31_vipBtn{
    if (!_zd31_vipBtn) {
        _zd31_vipBtn = [YLAF_RelayoutBtn buttonWithType:UIButtonTypeCustom];
        _zd31_vipBtn.layoutType = RelayoutTypeNone;
        _zd31_vipBtn.margin = 0;
        _zd31_vipBtn.frame = CGRectMake(self.zd31_userIcon.blmg_right, self.zd31_userName.blmg_bottom + 10, 100, 20);
        [_zd31_vipBtn setTitle:@" LV" forState:UIControlStateNormal];
        [_zd31_vipBtn setTitleColor:[YLAF_Theme_Utils khxl_goldColor] forState:UIControlStateNormal];
        [_zd31_vipBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagemember"] forState:UIControlStateNormal];
        [_zd31_vipBtn addTarget:self action:@selector(zd31_memberClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zd31_vipBtn;
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

@end
