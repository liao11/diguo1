
#import "ZhenD3OpenAPI.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Adjust/Adjust.h>

#import "ZhenD3SDKMainView_Controller.h"
#import "YLAF_Shortcut_View.h"

#import "ZhenD3Login_Server.h"
#import "ZhenD3Account_Server.h"
#import "ZhenD3SDKHeart_Server.h"
#import "ZhenD3InAppPurchase_Manager.h"
#import "ZhenD3SignInApple_Manager.h"
#import "ZhenD3LocalData_Server.h"

#import "NSString+GrossExtension.h"
#import "MBProgressHUD+GrossExtension.h"
#import "GrossAlertCrlV.h"
#import "YLAF_Helper_Utils.h"
#import "ZhendiFrameWork.h"
#import <Firebase/Firebase.h>
#import "UIDevice+GrossExtension.h"
#import "YLAF_RecentNews2V.h"
#import "ZhenD3Account_Server.h"
@implementation ZhenD3OpenAPI
{
    NSString * _zd3_SDKVersion;
}


- (void)setZd3_localizedLanguage:(YLAF_Language)zd3_localizedLanguage {
    NSLog(@"setzd3_localizedLanguage");
    [[NSUserDefaults standardUserDefaults] setInteger:zd3_localizedLanguage forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Localized_Language"]];
    [YLAF_Shortcut_View zd32_ResetLocalizedString];
}

- (YLAF_Language)zd3_localizedLanguage {
    NSLog(@"zd3_localizedLanguage");
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Localized_Language"]];
}

- (ZhenD3UserInfo_Entity *)userInfo {
    if (MYMGSDKGlobalInfo.userInfo.userID && MYMGSDKGlobalInfo.userInfo.userID.length >0) {
        return MYMGSDKGlobalInfo.userInfo;
    }
    return nil;
}

- (ZhenD3GameInfo_Entity *)gameInfo {
    if (MYMGSDKGlobalInfo.gameInfo.gameID && MYMGSDKGlobalInfo.gameInfo.gameID.length >0) {
        return MYMGSDKGlobalInfo.gameInfo;
    }
    return nil;
}

- (NSString *)zd3_SDKVersion {
    if (!_zd3_SDKVersion) {
        _zd3_SDKVersion = [NSString stringWithFormat:@"330%08ld", (long)ZhendiFrameWorkVersionNumber];
    }
    return _zd3_SDKVersion;
}


+ (instancetype)SharedInstance {
    static ZhenD3OpenAPI* shareApi = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareApi = [[self alloc] init];
    });
    return shareApi;
}

+ (void)zd3_openDevLog:(BOOL)isOpen {
    NSLog(@"zd3_openDevLog");
    MYMGSDKGlobalInfo.iszd3_openDevLog = isOpen;
}

+ (void)zd3_launchSDKWithConfig:(ZhenD3SDKConfig_Entity *)config application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MYMGSDKGlobalInfo.isEnterGame = NO;
    MYMGSDKGlobalInfo.gameInfo.gameID = config.gameID;
    MYMGSDKGlobalInfo.gameInfo.gameKey = config.gameKey;
    MYMGSDKGlobalInfo.adjustConfig = config.adjustConfig;
    MYMGSDKGlobalInfo.sdkConnectServer = config.sdkConnectServer;
    
    [MYMGUrlConfig zd32_updateCofigData];
    
    NSString *environment = ADJEnvironmentSandbox;
    if (YLAF_EnvironmentProduction == config.adjustConfig.environment) {
        environment = ADJEnvironmentProduction;
    }
    
    
    
    ADJLogLevel logLevel = (MYMGSDKGlobalInfo.iszd3_openDevLog ? ADJLogLevelVerbose : ADJLogLevelSuppress);
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:config.adjustConfig.adjustAppToken environment:environment];
    [adjustConfig setLogLevel:logLevel];
    [Adjust appDidLaunch:adjustConfig];
    

    [FIRApp configure];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [FBSDKSettings setAppID:config.facebookAppID];
    FBSDKLoginManager *fbManager = [[FBSDKLoginManager alloc] init];
    [fbManager logOut];
    [[ZhenD3Login_Server new] lhxy_DeviceActivate:^(ZhenD3ResponseObject_Entity * _Nonnull result) {}];

    [[ZhenD3SignInApple_Manager zd31_SharedManager] zd31_CheckCredentialState];
    
    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"App启动"] parameters:nil];
    
    if (@available(iOS 10.0, *)) {
      
      
      [UNUserNotificationCenter currentNotificationCenter].delegate = [self SharedInstance];
      UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
          UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
      [[UNUserNotificationCenter currentNotificationCenter]
          requestAuthorizationWithOptions:authOptions
          completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
          }];
    } else {
      
      UIUserNotificationType allNotificationTypes =
      (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
      UIUserNotificationSettings *settings =
      [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
      [application registerUserNotificationSettings:settings];
    }

    [application registerForRemoteNotifications];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [FBSDKAppEvents activateApp];
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    [FBSDKAppEvents activateApp];
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options];
}

+ (void)zd3_initialSDK {
    [MBProgressHUD zd32_ShowLoadingHUD];
    [[ZhenD3Login_Server new] lhxy_InitSDK:^(ZhenD3ResponseObject_Entity *result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responeResult && [result.zd32_responeResult isKindOfClass:[NSDictionary class]]) {
            
            
            MYMGSDKGlobalInfo.zd32_sdkFlag = [result.zd32_responeResult[[NSString stringWithFormat:@"%@",@"v_ctrl"]] integerValue];
            
            MYMGSDKGlobalInfo.login_agree = result.zd32_responeResult[[NSString stringWithFormat:@"%@",@"login_agree"]];
            MYMGSDKGlobalInfo.reg_agree = result.zd32_responeResult[[NSString stringWithFormat:@"%@",@"reg_agree "]]?:MYMGSDKGlobalInfo.login_agree;
//            MYMGSDKGlobalInfo.hint = result.zd32_responeResult[[NSString stringWithFormat:@"%@",@"hint"]]?:@"";
            
            MYMGSDKGlobalInfo.notice = result.zd32_responeResult[[NSString stringWithFormat:@"%@",@"notice"]]?:@"";
            
            MYMGSDKGlobalInfo.zd31_GvCheck = [result.zd32_responeResult[@"gv_checked"] boolValue]?:MYMGSDKGlobalInfo.zd31_GvCheck;
            
            
            if (MYMGSDKGlobalInfo.notice.length>0) {
                NSLog(@"MYMGSDKGlobalInfo.notice  ===%@",MYMGSDKGlobalInfo.notice);
                [self zd32_showRencentV];
            }
           
            
            
            
            
            
        } else {
            MYMGSDKGlobalInfo.zd32_sdkFlag = YLAF_SDKFlagNone;
        }
    }];
}

+ (void)zd32_showRencentV {
    
    
    [ZhenD3SDKMainView_Controller zd32_showRencent2V];
//    UIView *view = [self zd32_u_GetCurrentWindowView];
//    ZhenD3SDKMainView_Controller *mainView = nil;
//    for (UIView *sub in view.subviews) {
//        if ([sub isKindOfClass:[ZhenD3SDKMainView_Controller class]]) {
//            mainView = (ZhenD3SDKMainView_Controller *)sub;
//            break;
//        }
//    }
//    if (mainView == nil) {
//        mainView = [[ZhenD3SDKMainView_Controller alloc] init];
//        [view addSubview:mainView];
//    }
//    
//    
//    [mainView zd32_u_PushView:mainView.lhxy_rencentV fromView:nil animated:NO];
//    YLAF_RecentNews2V *_lhxy_rencentV = [[YLAF_RecentNews2V alloc] init];
//
//    _lhxy_rencentV.delegate = self;
////    mainView
//
//
////    [mainView yl
//    [mainView zd32_u_PushView:_lhxy_rencentV fromView:nil animated:NO];
    
    
    
}



+ (UIView *)zd32_u_GetCurrentWindowView {
    
    return YLMXGSDKAPI.context.view;
}


+ (void)activateApp {
    [FBSDKAppEvents activateApp];
}

+ (void)zd3_completeNoviceTask {
    ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenCompleteNoviceTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:MYMGSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"完成新手任务"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: MYMGSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: MYMGSDKGlobalInfo.gameInfo.gameID?:@""}];
    
    [[ZhenD3Account_Server new] zd31_sendFinishNewTaskRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        
    }];
}


+ (void)zd3_begincdnTask{
    
    
    ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenbegincdnTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:MYMGSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"cdn加载"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: MYMGSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: MYMGSDKGlobalInfo.gameInfo.gameID?:@""}];
    
}
+ (void)zd3_finishcdnTask{
    ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenfinishcdnTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:MYMGSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"cdn加载结束"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: MYMGSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: MYMGSDKGlobalInfo.gameInfo.gameID?:@""}];
}
+ (void)zd3_beginNoviceTask{
    
    ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenbeginNoviceTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:MYMGSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"新手引导开始"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: MYMGSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: MYMGSDKGlobalInfo.gameInfo.gameID?:@""}];
    
    
}
//








+ (void)zd3_setShortCutHidden:(BOOL)hidden {
    YLAF_RunInMainQueue(^{
        if (MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagShortcut) {
            [YLAF_Shortcut_View zd32_SharedView].hidden = hidden;
        } else {
            [YLAF_Shortcut_View zd32_SharedView].hidden = YES;
        }
    });
}

+ (void)blmg_obtainPresentWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId{
    
    if (MYMGSDKGlobalInfo.userInfo.isBindMobile) {
        if (YLMXGSDKAPI.blmg_tiePresent) {
            
        }
        else
        {
            //走请求绑定礼包
            [MBProgressHUD zd32_ShowLoadingHUD];
            [[ZhenD3Login_Server new] lhxy_tiePresentWithGameId:zd31_gameId zd32_roleId:zd32_roleId Request:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
                
                [MBProgressHUD zd32_DismissLoadingHUD];
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
    }
    else
    {
        //走绑定手机号
        [ZhenD3SDKMainView_Controller zd33_showBindTelVWithGameId:zd31_gameId zd32_roleId:zd32_roleId];
    }
}

+ (void)zd3_firebaseEventWithName:(NSString *)name parameters:(nullable NSDictionary<NSString *, id> *)parameters {
    [FIRAnalytics logEventWithName:name parameters:parameters];
}

+ (void)zd3_adjustEventWithEventToken:(NSString *)eventToken parameters:(nullable NSDictionary<NSString *, id> *)parameters {
    
    
    
    
    
    __block ADJEvent *event = [ADJEvent eventWithEventToken:eventToken];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
    if (parameters && [parameters isKindOfClass:[NSDictionary class]] && parameters.count > 0) {
        [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [event addPartnerParameter:key value:obj];
        }];
    }
    [Adjust trackEvent:event];
}

+ (void)showLoginView {
    [ZhenD3SDKMainView_Controller zd31_showLoginView];
    [self getFCMRegistrationToken];
}

+ (void)logout:(BOOL)showAlertView {
    if (showAlertView) {
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_Logout_Text") message:MUUQYLocalizedString(@"MUUQYKey_Logout_Alert_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex != 0) {
                [self zd32_u_logoutRequest];
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text")]];
    } else {
        [self zd32_u_logoutRequest];
    }
}
+ (void)zd3_delete:(BOOL)showAlertView{
    if (showAlertView) {
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"MUUQYKey_deletet_Text ") message:MUUQYLocalizedString(@"MUUQYKey_Logout_Alert_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex != 0) {
                [self zd32_u_deleteRequest];
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"MUUQYKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text")]];
    } else {
        [self zd32_u_deleteRequest];
    }
}
+ (void)zd3_enterGameIntoServerId:(NSString *)serverId serverName:(NSString *)serverName withRoleId:(NSString *)roleId roleName:(NSString *)roleName andRoleLevel:(NSUInteger)roleLevel {
    if (MYMGSDKGlobalInfo.isEnterGame) return;
    MYMGSDKGlobalInfo.isEnterGame = YES;
    
    MYMGSDKGlobalInfo.gameInfo.cpServerID = serverId;
    MYMGSDKGlobalInfo.gameInfo.cpServerName = serverName;
    MYMGSDKGlobalInfo.gameInfo.cpRoleID = roleId;
    MYMGSDKGlobalInfo.gameInfo.cpRoleName = roleName;
    MYMGSDKGlobalInfo.gameInfo.cpRoleLevel = roleLevel;
    
    [MBProgressHUD zd32_ShowLoadingHUD];
    [[ZhenD3Login_Server new] lhxy_EnterGame:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            if (MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagHeart) {
                [MYMGSDKHeart zd32_startRefreshTokenTimer];
                [MYMGSDKHeart zd32_startSDKHeartBeat];
            }
        } else {
            MYMGSDKGlobalInfo.isEnterGame = NO;
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

+ (void)zd3_updateAndCommitGameRoleLevel:(NSUInteger)level {
    [[ZhenD3Account_Server new] zd31_UpdateAndCommitGameRoleLevel:level responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {}];
}

+ (BOOL)zd3_clearAllHistoryAccounts {
    return [ZhenD3LocalData_Server zd32_removeAllLoginedUserHistory];
}

+ (void)getFCMRegistrationToken {
    
    [[FIRMessaging messaging] tokenWithCompletion:^(NSString *token, NSError *error) {
      if (error != nil) {
        
      } else {
        
      }
    }];
}

+ (void)zd3_getPurchaseProduces {
    [[ZhenD3InAppPurchase_Manager zd31_SharedManager] zd31_getPurchaseProduces:NO];
}

+ (void)zd3_startPurchaseProduceOrder:(ZhenD3CPPurchaseOrder_Entity *)purchaseOrder {
    YLAF_RunInMainQueue(^{
        [[ZhenD3InAppPurchase_Manager zd31_SharedManager] zd31_startPurchaseProduceOrder:[ZhenD3PurchaseProduceOrder_Entity initWithCPPurchaseOrder:purchaseOrder]];
    });
}






+ (void)zd3_sdkRequestPath:(NSString *)path parameters:(NSDictionary *)parameters responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    [[ZhenD3RemoteData_Server new] zd32_RequestPath:path parameters:parameters responseBlock:responseBlock];
}


+ (void)zd32_u_logoutRequest {
    [MBProgressHUD zd32_ShowLoadingHUD];
    [[ZhenD3Login_Server new] lhxy_Logout:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showSuccess_Toast:result.zd32_responeMsg];
            
            [self zd32_u_clearUselessInfo];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

+ (void)zd32_u_deleteRequest {
    [MBProgressHUD zd32_ShowLoadingHUD];
    
//    [[ZhenD3Account_Server new] zd32_delAccResponseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
//        [MBProgressHUD zd32_DismissLoadingHUD];
//        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
////            [MBProgressHUD zd32_showSuccess_Toast:MUUQYLocalizedString(@"MUUQYKey_successAccDel")];
//            [ZhenD3SDKMainView_Controller zd31_logoutAction];
//
//        } else {
//            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
//        }
//    }];
//
    
    [[ZhenD3Login_Server new] lhxy_Delte:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showSuccess_Toast:result.zd32_responeMsg];
          
            [self zd32_u_clearUselessInfo];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}


+ (void)zd32_u_clearUselessInfo {
    MYMGSDKGlobalInfo.isEnterGame = NO;
    
    [YLAF_Shortcut_View zd32_DismissShort];
    [MYMGSDKGlobalInfo clearUselessInfo];
    [MYMGSDKHeart zd32_stopRefreshTokenTimer];
    [MYMGSDKHeart zd32_stopSDKHeartBeat];
}

- (void)zd3_HandleLogTapAction:(UITapGestureRecognizer *)recognizer {
    [ZhenD3OpenAPI zd3_openDevLog:YES];
    
    [MBProgressHUD zd32_showSuccess_Toast:[NSString stringWithFormat:@"%@",@"打开SDK日志"]];
}

@end
