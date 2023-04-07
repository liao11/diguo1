
#import "ZhenD3Login_Server.h"
#import "ZhenD3LocalData_Server.h"
#import "NSString+GrossExtension.h"
#import "UIDevice+GrossExtension.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Adjust/Adjust.h>
#import "YLAF_Macro_Define.h"
#import "YLAF_Helper_Utils.h"
#import <Firebase/Firebase.h>

static NSUInteger deviceActiveFailureCount = 0;
static NSUInteger sdkInitFailureCount = 0;

@implementation ZhenD3Login_Server

- (void)lhxy_InitSDK:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRA]];
    [params setObject:[UIDevice zd32_getCurrentDeviceNetworkingStates]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceNetwork]];
    [params setObject:[UIDevice zd32_getCurrentDeviceNetworkingStates]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceModelProvider]];
    [params setObject:[UIDevice gainAppVersion]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAppVersion]];

    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpInitialPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeNetworkError && sdkInitFailureCount < 6) {
            sdkInitFailureCount += 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self lhxy_InitSDK:responseBlock];
            });
        } else {
            MYMGLog(@"SDK初始化失败的次数 = %ld", (long)sdkInitFailureCount);
            sdkInitFailureCount = 0;
            zd31_result.zd32_responseType = YLAF_ResponseTypeSDKInital;
            
            if (responseBlock) {
                responseBlock(zd31_result);
            }
            
            if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_initialSDKFinished:)]) {
                [YLMXGSDKAPI.delegate zd3_initialSDKFinished:zd31_result];
            }
        }
    }];
}

- (void)lhxy_DeviceActivate:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[UIDevice gainAppVersion]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAppVersion]];
    
    [self zd32_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpDeviceActivePath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeNetworkError && deviceActiveFailureCount < 6) {
            deviceActiveFailureCount += 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self lhxy_DeviceActivate:responseBlock];
            });
        } else {
            MYMGLog(@"SDK设备激活失败的次数 = %ld", (long)deviceActiveFailureCount);
            deviceActiveFailureCount = 0;
            if (responseBlock) {
                responseBlock(result);
            }
        }
    }];
}

- (void)lhxy_DeviceActivate:(NSString *)username md5Password:(NSString *)password responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:password?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPassword]];
    [params setObject:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPlaform]];
    [self zd32_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpNormalLoginPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeNormalLogin;
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.userName = username;
            MYMGSDKGlobalInfo.userInfo.password = password;
            
            [MYMGSDKGlobalInfo zd32_parserUserInfoFromResponseResult:zd31_result.zd32_responeResult];
            
            if ([zd31_result.zd32_responeResult[@"isReg"] boolValue]) {
                MYMGSDKGlobalInfo.userInfo.isReg = YES;
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"平台账户注册"]];
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                ADJEvent *event2 = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenLogin];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号注册成功后的登录"]];
                [Adjust trackEvent:event2];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"平台账号注册"] }];
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"平台账号登录"] }];
            }else{
                MYMGSDKGlobalInfo.userInfo.isReg = NO;
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenLogin];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号登录"]];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"账号登录"] }];
            }
            
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_loginFinished:zd31_result];
        }
    }];
}

- (void)lhxy_QuickLogin:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [self zd32_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpQuickLoginPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeGuestLogin;
        
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.userName = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
            MYMGSDKGlobalInfo.userInfo.password = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"passwd"]];
            MYMGSDKGlobalInfo.userInfo.isReg = [[zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"isReg"]] boolValue];
            [MYMGSDKGlobalInfo zd32_parserUserInfoFromResponseResult:zd31_result.zd32_responeResult];
            
            if (MYMGSDKGlobalInfo.userInfo.isReg) {
                
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"快速登录注册"]];
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"快速登录注册"] }];
            }
            
            ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenLogin];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"快速登录"]];
            [Adjust trackEvent:event];
            
            [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"快速登录"] }];
            
        } else {
            MYMGSDKGlobalInfo.userInfo.isReg = NO;
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_loginFinished:zd31_result];
        }
    }];
}

- (void)lhxy_Logout:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    MYMGSDKGlobalInfo.lastWayLogin = false;
    MYMGSDKGlobalInfo.sdkIsLogin = NO;
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpUserLogoutPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeLoginOut;
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_logoutFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_logoutFinished:zd31_result];
        }
    }];
}
- (void)lhxy_Delte:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    NSString * userID=MYMGSDKGlobalInfo.userInfo.userID?:@"";
    [params setObject:MYMGSDKGlobalInfo.userInfo.userName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    MYMGSDKGlobalInfo.lastWayLogin = false;
    MYMGSDKGlobalInfo.sdkIsLogin = NO;
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpDelAcc];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeDelete;
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            
            
            ZhenD3UserInfo_Entity *user = [[ZhenD3UserInfo_Entity alloc]init];
            user.userID=userID;
            [ZhenD3LocalData_Server zd32_removeLoginedUserInfoFormHistory:user];
        }
        if (responseBlock) {
            
          
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_deleteFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_deleteFinished:zd31_result];
        }
    }];
}
- (void)lhxy_EnterGame:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpServerID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpServiceID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpServerName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpServiceName]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleId]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleName]];
    [params setObject:@(MYMGSDKGlobalInfo.gameInfo.cpRoleLevel).stringValue forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleLevel]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpEnjoyGamePath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeEnterGame;
        
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.gameInfo.chRoleID = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"role_id"]];
            MYMGSDKGlobalInfo.gameInfo.sessionID = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"session_id"]];;
            MYMGSDKGlobalInfo.gameInfo.chServerID = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"server_id"]];
            
            if ([[zd31_result.zd32_responeResult objectForKey:@"isFirstRole"] boolValue]) {
                
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenCreateRoles];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:@"创建角色" parameters:@{
                    [NSString stringWithFormat:@"%@",@"创建角色Id"]: MYMGSDKGlobalInfo.gameInfo.chRoleID?:@"",
                    [NSString stringWithFormat:@"%@",@"session_id"]: MYMGSDKGlobalInfo.gameInfo.sessionID?:@"",
                    [NSString stringWithFormat:@"%@",@"server_id"]: MYMGSDKGlobalInfo.gameInfo.chServerID?:@""
                }];
            }
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_enterGameFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_enterGameFinished:zd31_result];
        }
    }];
}

- (void)lhxy_FacebookLogin:(void(^)(void))showHubBlock responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
    [fbLoginManager logOut];
    [fbLoginManager logInWithPermissions:@[@"public_profile",@"email"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        MYMGLog(@"facebook账号登录 result.grantedPermissions = %@, error = %@",result.grantedPermissions, error);
        
        ZhenD3ResponseObject_Entity *responseObj = [[ZhenD3ResponseObject_Entity alloc] init];
        responseObj.zd32_responseType = YLAF_ResponseTypeFacebookLogin;
        if (error) {
            responseObj.zd32_responseCode = YLAF_ResponseCodeFacebookLoginFailure;
            responseObj.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_FBLoginError_Alert_Text");
            
            YLAF_RunInMainQueue(^{
                if (responseBlock) {
                    responseBlock(responseObj);
                }
                
                if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
                    [YLMXGSDKAPI.delegate zd3_loginFinished:responseObj];
                }
            });
        } else if (result.isCancelled) {
            responseObj.zd32_responseCode = YLAF_ResponseCodeFacebookLoginCancel;
            responseObj.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_FBLoginCancel_Alert_Text");
            
            YLAF_RunInMainQueue(^{
                if (responseBlock) {
                    responseBlock(responseObj);
                }
                
                if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
                    [YLMXGSDKAPI.delegate zd3_loginFinished:responseObj];
                }
            });
        } else {
            YLAF_RunInMainQueue(^{
                if (showHubBlock) {
                    showHubBlock();
                }
            });
            [self zd32_u_LoginWithFbToken:result.token responseBlock:responseBlock];
        }
    }];
}

- (void)lhxy_VerifySignInWithApple:(NSString *)userId email:(NSString *)email authorizationCode:(NSString *)authorizationCode identityToken:(NSString *)identityToken responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"3" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyThirdPlatform]];
    [params setObject:userId?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyThirdAccount]];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    [params setObject:authorizationCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAppleAuthorizationCode]];
    [params setObject:identityToken?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAppleIdentityToken]];
    [params setObject:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPlaform]];
    
    [self zd32_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpVerifySignInWithAppleId];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeAppleLogin;
        
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.userName = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
            MYMGSDKGlobalInfo.userInfo.password = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"passwd"]];
            MYMGSDKGlobalInfo.userInfo.isReg = [[zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"isReg"]] boolValue];
            [MYMGSDKGlobalInfo zd32_parserUserInfoFromResponseResult:zd31_result.zd32_responeResult];
            
            if (MYMGSDKGlobalInfo.userInfo.isReg) {
                
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"苹果注册"]];
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"苹果账号注册"] }];
            }
            
            ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenLogin];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"苹果登录"]];
            [Adjust trackEvent:event];
            
            [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"苹果登录"] }];
        } else {
            MYMGSDKGlobalInfo.userInfo.isReg = NO;
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_loginFinished:zd31_result];
        }
    }];
}


- (void)zd32_u_LoginWithFbToken:(FBSDKAccessToken *)fbToken responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:fbToken.userID parameters:@{} HTTPMethod:FBSDKHTTPMethodGET];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id fb_result, NSError *error) {
        if (error) {
            ZhenD3ResponseObject_Entity *responseObj = [[ZhenD3ResponseObject_Entity alloc] init];
            responseObj.zd32_responseType = YLAF_ResponseTypeFacebookLogin;
            responseObj.zd32_responeMsg = error.domain;
            responseObj.zd32_responeResult = error.userInfo;
            responseObj.zd32_responseCode = YLAF_ResponseCodeFacebookLoginFailure;
              
            YLAF_RunInMainQueue(^{
                if (responseBlock) {
                    responseBlock(responseObj);
                }
                
                if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
                    [YLMXGSDKAPI.delegate zd3_loginFinished:responseObj];
                }
            });
        } else {
            [self zd32_u_LoginWithThirdPlatform:@"1" account:fbToken.userID token:fbToken.tokenString responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
                zd31_result.zd32_responseType = YLAF_ResponseTypeFacebookLogin;
                                    
                if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
                    MYMGSDKGlobalInfo.userInfo.isReg = [[zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"isReg"]] boolValue];
                    MYMGSDKGlobalInfo.userInfo.userName = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
                    MYMGSDKGlobalInfo.userInfo.password = [zd31_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"passwd"]];
                    MYMGSDKGlobalInfo.userInfo.fbUserName = [fb_result objectForKey:[NSString stringWithFormat:@"%@",@"name"]];
                    [MYMGSDKGlobalInfo zd32_parserUserInfoFromResponseResult:zd31_result.zd32_responeResult];
                    
                    if (MYMGSDKGlobalInfo.userInfo.isReg) {
                        
                        ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenRegister];
                        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"Facebook注册"]];
                        [Adjust trackEvent:event];
                        
                        ADJEvent *event1 = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenFBRegister];
                        [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                        [Adjust trackEvent:event1];
                        
                        [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"FB账号注册"] }];
                    }
                    
                    ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenLogin];
                    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"FB登录"]];
                    [Adjust trackEvent:event];
                    
                    [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"FB账号登录"] }];
                } else {
                    MYMGSDKGlobalInfo.userInfo.isReg = NO;
                }
                    
                if (responseBlock) {
                    responseBlock(zd31_result);
                }
                
                if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
                    [YLMXGSDKAPI.delegate zd3_loginFinished:zd31_result];
                }
            }];
        }
    }];
}

- (void)zd32_u_LoginWithThirdPlatform:(NSString *)platform account:(NSString *)account token:(NSString *)token responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:platform?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyThirdPlatform]];
    [params setObject:account?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyThirdAccount]];
    [params setObject:token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAppleIdentityToken]];
    [params setObject:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPlaform]];
    
    [self zd32_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpThirdLoginPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机登录
- (void)lhxy_telLogin:(NSString *)username md5Password:(NSString *)password zd32_telDist:(NSString *)zd32_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:password?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPassword]];
    [params setObject:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPlaform]];
    
    [params setObject:zd32_telDist?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelDist]];
    
    [self zd32_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpTelLogin];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeTelLogin;
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.userName = username;
            MYMGSDKGlobalInfo.userInfo.password = password;
            
            MYMGSDKGlobalInfo.lastWayLogin = YES;
            [MYMGSDKGlobalInfo blmg_parserTelInfoFromResponseResult:zd31_result.zd32_responeResult];
            
            if ([zd31_result.zd32_responeResult[@"isReg"] boolValue]) {
                MYMGSDKGlobalInfo.userInfo.isReg = YES;
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"平台账户注册"]];
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                ADJEvent *event2 = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenLogin];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号注册成功后的登录"]];
                [Adjust trackEvent:event2];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"平台账号注册"] }];
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"平台账号登录"] }];
            }else{
                MYMGSDKGlobalInfo.userInfo.isReg = NO;
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenLogin];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号登录"]];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"账号登录"] }];
            }
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_loginFinished:zd31_result];
        }
    }];
}

- (void)lhxy_tiePresentWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId Request:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:YLMXGSDKAPI.gameInfo.gameID forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:zd32_roleId?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleId]];
    [params setObject:zd31_gameId?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpServiceID]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpTiePresent];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

@end
