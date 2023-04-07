
#import "ZhenD3SDKGlobalInfo_Entity.h"
#import "ZhenD3LocalData_Server.h"
#import "ZhenD3InAppPurchase_Manager.h"
#import "ZhenD3UrlGlobalConfig_Entity.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3OpenAPI.h"
#import "YLAF_Helper_Utils.h"
#import "GrossAlertCrlV.h"
#import "YLAF_W_ViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <Firebase/Firebase.h>

@interface ZhenD3SDKGlobalInfo_Entity () <MFMailComposeViewControllerDelegate>

@end

@implementation ZhenD3SDKGlobalInfo_Entity

+ (instancetype)SharedInstance {
    static ZhenD3SDKGlobalInfo_Entity* shareGlobalInfo = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareGlobalInfo = [[self alloc] init];
    });
    return shareGlobalInfo;
}

- (instancetype)init {
    if (self = [super init]) {
        self.gameInfo = [[ZhenD3GameInfo_Entity alloc] init];
        self.userInfo = [[ZhenD3UserInfo_Entity alloc] init];
    }
    return self;
}

- (BOOL)sdkIsLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKIsLoginState"]];
}

- (BOOL)lastWayLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKLastLoginTel"]];
}

- (YLAF_ResponseType)sdkLoginType {
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKLoginType"]];
}





- (void)setSdkIsLogin:(BOOL)sdkIsLogin {
    [[NSUserDefaults standardUserDefaults] setBool:sdkIsLogin forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKIsLoginState"]];
}

- (void)setLastWayLogin:(BOOL)lastWayLogin{
    [[NSUserDefaults standardUserDefaults] setBool:lastWayLogin forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKLastLoginTel"]];
}


- (void)setSdkConnectServer:(YLAF_SDKServer)sdkConnectServer {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    YLAF_SDKServer sdkServer = [userDefault integerForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Sdk_Connect_Server"]];
    if (sdkServer != sdkConnectServer) {
        [userDefault setInteger:sdkConnectServer forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Sdk_Connect_Server"]];
        [userDefault synchronize];
        
        
        [MYMGUrlConfig zd32_updateCofigData];
        
        [ZhenD3LocalData_Server zd32_removeAllLoginedUserHistory];
        
        self.sdkIsLogin = NO;
    }
}

- (void)zd32_parserUserInfoFromResponseResult:(NSDictionary *)result {
    MYMGSDKGlobalInfo.sdkIsLogin = YES;
    
    self.userInfo.userID = [result objectForKey:[NSString stringWithFormat:@"%@",@"userid"]];
    self.userInfo.token = [result objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
    self.userInfo.autoToken = [result objectForKey:[NSString stringWithFormat:@"%@",@"auto_token"]];
    self.userInfo.isBind = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBind"]] boolValue];
    self.userInfo.isBindMobile = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBindMobile"]] boolValue];
    YLMXGSDKAPI.blmg_tiePresent = [[result objectForKey:[NSString stringWithFormat:@"%@%@",@"isBindG",@"ift"]] boolValue];
    if ([[result objectForKey:[NSString stringWithFormat:@"%@",@"email"]] validateEmail]) {
        self.userInfo.isBindEmail = true;
    }else{
        self.userInfo.isBindEmail = false;
    }
    self.userInfo.accountType = [[result objectForKey:[NSString stringWithFormat:@"%@",@"account_type"]] integerValue];
    self.lightState = [[result objectForKey:[NSString stringWithFormat:@"%@",@"light"]] integerValue];
    
    
    if (self.userInfo.userID) {
        [FIRAnalytics setUserID:self.userInfo.userID];
    }
    [ZhenD3LocalData_Server zd32_saveLoginedUserInfo:self.userInfo];
    
    NSArray *products = [result objectForKey:[NSString stringWithFormat:@"%@",@"product"]];
    
    if (products && products.count > 0) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:products.count];
        for (int i = 0; i < products.count; i++) {
            [arr addObject:[NSString stringWithFormat:@"%@", products[i]]];
        }
        self.productIdentifiers = [NSSet setWithArray:arr];
    } else {
        self.productIdentifiers = [[NSSet alloc] init];
    }
    
    self.customorSeviceMail = [result objectForKey:[NSString stringWithFormat:@"%@",@"kf_email"]]?:@"";
    
    [[ZhenD3InAppPurchase_Manager zd31_SharedManager] zd31_recheckCachePurchaseOrderReceipts];
}

- (void)blmg_parserTelInfoFromResponseResult:(NSDictionary *)result {
    MYMGSDKGlobalInfo.sdkIsLogin = YES;
    
    self.userInfo.userID = [result objectForKey:[NSString stringWithFormat:@"%@",@"userid"]];
    self.userInfo.token = [result objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
    self.userInfo.autoToken = [result objectForKey:[NSString stringWithFormat:@"%@",@"auto_token"]];
    self.userInfo.isBind = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBind"]] boolValue];
    self.userInfo.isBindMobile = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBindMobile"]] boolValue];
    YLMXGSDKAPI.blmg_tiePresent = [[result objectForKey:[NSString stringWithFormat:@"%@%@",@"isBindG",@"ift"]] boolValue];
    
    self.userInfo.accountType = [[result objectForKey:[NSString stringWithFormat:@"%@",@"account_type"]] integerValue];
    self.lightState = [[result objectForKey:[NSString stringWithFormat:@"%@",@"light"]] integerValue];
    
    if ([[result objectForKey:[NSString stringWithFormat:@"%@",@"email"]] validateEmail]) {
        self.userInfo.isBindEmail = true;
    }else{
        self.userInfo.isBindEmail = false;
    }
    
    if (self.userInfo.userID) {
        [FIRAnalytics setUserID:self.userInfo.userID];
    }
    [ZhenD3TelDataServer zd32_saveLoginedUserInfo:self.userInfo];
    
    NSArray *products = [result objectForKey:[NSString stringWithFormat:@"%@",@"product"]];
    
    if (products && products.count > 0) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:products.count];
        for (int i = 0; i < products.count; i++) {
            [arr addObject:[NSString stringWithFormat:@"%@", products[i]]];
        }
        self.productIdentifiers = [NSSet setWithArray:arr];
    } else {
        self.productIdentifiers = [[NSSet alloc] init];
    }
    
    self.customorSeviceMail = [result objectForKey:[NSString stringWithFormat:@"%@",@"kf_email"]]?:@"";
    
    [[ZhenD3InAppPurchase_Manager zd31_SharedManager] zd31_recheckCachePurchaseOrderReceipts];
}

- (void)clearUselessInfo {
    NSString *gameID = self.gameInfo.gameID;
    NSString *gameKey = self.gameInfo.gameKey;
    self.gameInfo = [[ZhenD3GameInfo_Entity alloc] init];
    self.userInfo = [[ZhenD3UserInfo_Entity alloc] init];
    self.gameInfo.gameID = gameID;
    self.gameInfo.gameKey = gameKey;
}

- (UIViewController *)zd32_CurrentVC {
    if (YLMXGSDKAPI.context) {
        return YLMXGSDKAPI.context;
    }
    
    return [ZhenD3SDKGlobalInfo_Entity zd32_u_getCurrentVC];
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


- (void)zd32_PresendWithUrlString:(NSString *)URLString {
    if (!URLString || [URLString isEmpty]) {
        
        return;
    }
    
    [ZhenD3OpenAPI zd3_setShortCutHidden:YES];
    YLAF_W_ViewController *vc = [[YLAF_W_ViewController alloc] init];
    vc.alhm_uString = URLString;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[self zd32_CurrentVC] presentViewController:nav animated:YES completion:nil];
}


- (void)zd32_SendEmail:(NSString *)email {
    if (![MFMailComposeViewController canSendMail]) {
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_TipsTitle_Text") message:MUUQYLocalizedString(@"MUUQYKey_ConfigEmailAccount_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex != 0) {
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"mailto://"]];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text")]];
        return;
    }
    
    [ZhenD3OpenAPI zd3_setShortCutHidden:YES];
    MFMailComposeViewController *mailSender = [[MFMailComposeViewController alloc] init];
    mailSender.mailComposeDelegate = self;
    [mailSender setSubject:MUUQYLocalizedString(@"MUUQYKey_Feedback_Text")];
    [mailSender setToRecipients:[NSArray arrayWithObject:email?:@""]];
    
    
    
    
    
    
    [YLMXGSDKAPI.context presentViewController:mailSender animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [ZhenD3OpenAPI zd3_setShortCutHidden:NO];
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            msg = [NSString stringWithFormat:@"%@",@"用户取消编辑邮件"];
        }
            break;
        case MFMailComposeResultSaved:
        {
            msg = [NSString stringWithFormat:@"%@",@"用户成功保存邮件"];
        }
            break;
        case MFMailComposeResultSent:
        {
            
            msg = [NSString stringWithFormat:@"%@",@"用户点击发送，将邮件放到队列中，还没发送"];
        }
            break;
        case MFMailComposeResultFailed:
        {
            msg = [NSString stringWithFormat:@"%@",@"用户试图保存或者发送邮件失败"];
        }
            break;
    }
    
}
@end
