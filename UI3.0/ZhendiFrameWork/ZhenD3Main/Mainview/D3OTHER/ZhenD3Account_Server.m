
#import "ZhenD3Account_Server.h"
#import "NSString+GrossExtension.h"
#import "UIDevice+GrossExtension.h"
#import "ZhenD3OpenAPI.h"
#import "ZhenD3LocalData_Server.h"
#import <Adjust/Adjust.h>
#import <Firebase/Firebase.h>

@implementation ZhenD3Account_Server

- (void)zd31_RegisterAccountWithUserName:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode regType:(NSString *)regType responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:regType?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRegType]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpNormalRegPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeRegister;
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.userName = userName;
            if ([regType isEqualToString:@"2"]) {
                MYMGSDKGlobalInfo.userInfo.password = zd31_result.zd32_responeResult[@"passwd"];
            }else{
                MYMGSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString];
            }
            
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

- (void)zd31_findAccount:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpFindAccountsPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_SendFindAccountVerufy2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpVerifyEmailPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_SendRegisterVerify2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpSendRegVerifyCodePath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_ResetPwdWithBindEmail:(NSString *)email verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:[[newPassword hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyNewPwd]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpModifyPasswordPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_SendBindEmailVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpBindVerifyCodePath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_BindEmail:(NSString *)email withVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpBindEmailPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.isBind = YES;
            MYMGSDKGlobalInfo.userInfo.isBindEmail = YES;
            MYMGSDKGlobalInfo.userInfo.userName = email;
            if (MYMGSDKGlobalInfo.userInfo.accountType == YLAF_AccountTypeGuest) {
                MYMGSDKGlobalInfo.userInfo.accountType = YLAF_AccountTypeMuu;
            }
            [ZhenD3LocalData_Server zd32_saveLoginedUserInfo:MYMGSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
    }];
}

- (void)zd31_UpdateAndCommitGameRoleLevel:(NSUInteger)level responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.chServerID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyServiceID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.chRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRoleID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleId]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleName]];
    [params setObject:@(level).stringValue forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleLevel]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpCommitRoleLevelPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_commitGameRoleLevelFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_commitGameRoleLevelFinished:zd31_result];
        }
    }];
}

- (void)zd31_GetUserInfo:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpGetUserInfoPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_SendUpgradeVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpSendUpgradeVerifyCodePath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_UpgradeAccount:(NSString *)email withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyEamil]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAccountUpgradePath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.isBind = YES;
            MYMGSDKGlobalInfo.userInfo.isBindEmail = YES;
            MYMGSDKGlobalInfo.userInfo.userName = email;
            MYMGSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString]?:@"";
            if (MYMGSDKGlobalInfo.userInfo.accountType == YLAF_AccountTypeGuest) {
                MYMGSDKGlobalInfo.userInfo.accountType = YLAF_AccountTypeMuu;
            }
            [ZhenD3LocalData_Server zd32_saveLoginedUserInfo:MYMGSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
    }];
}

- (void)zd31_ModifyPassword:(NSString *)password newPassword:(NSString *)newPassword reNewPassword:(NSString *)reNewPassword responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPassword]];
    [params setObject:[[newPassword hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyNewPwd]];
    [params setObject:[[reNewPassword hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyReNewPwd]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpModifyPwdPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.password = [[newPassword hash_md5] uppercaseString];
            [ZhenD3LocalData_Server zd32_saveLoginedUserInfo:MYMGSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
    }];
}

- (void)zd31_GetAllPresent:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpGetAllPresentInfoPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_GetPresent:(NSInteger)presentId responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(presentId).stringValue forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPresentId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpGetPresentInfoPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_GetMyPresents:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpMyPresentInfoPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_GetCustomerService:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpServiceInfoPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//充值记录
- (void)zd31_GetOrderListRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpChongDataPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}
//最新资讯
- (void)zd31_GetNewsListRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpNewsInfoPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机注册发送验证码
- (void)zd31_SendBindTelCodeRequestWithzd32_telNum:(NSString *)zd32_telNum zd3_telDist:(NSString *)zd3_telDist zd31_ut:(NSString *)zd31_ut responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:zd3_telDist?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelDist]];
    [params setObject:zd32_telNum?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:zd31_ut?:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelUt]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpRegMobileCode];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//登录后发送验证码
- (void)zd31_SendUpgradeTelCodeRequestWithzd32_telNum:(NSString *)zd32_telNum zd3_telDist:(NSString *)zd3_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:zd3_telDist?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelDist]];
    [params setObject:zd32_telNum?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpObtainTelCode];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//完成新手任务
- (void)zd31_sendFinishNewTaskRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:YLMXGSDKAPI.gameInfo.gameID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    [params setObject:YLMXGSDKAPI.gameInfo.cpRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleId]];
    [params setObject:[UIDevice blmg_getDeviceNo]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceNO]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpFinishNewTask];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//获取优惠券列表
- (void)khxl_obtainCouponLsitWithzd3_lt:(NSInteger)zd3_lt responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    //lt 1-所有可使用的 2 未领取的 3 已领取的
    [params setObject:@(zd3_lt).stringValue forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyListType]];
    [params setObject:YLMXGSDKAPI.gameInfo.gameID forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpObtainCouponList];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//保存优惠券
- (void)zd3_saveCouponLsitWithblmg_couponId:(NSInteger)blmg_couponId responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:YLMXGSDKAPI.gameInfo.gameID forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    [params setObject:@(blmg_couponId).stringValue forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCouponId]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpSaveUserCoupon];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//获取任务列表
- (void)lhxy_getTaskLsitRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:YLMXGSDKAPI.gameInfo.gameID forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpTaskList];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//币明细
- (void)zd3_getKionDetailRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:YLMXGSDKAPI.gameInfo.gameID forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpCoinDetail];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机注册
- (void)zd31_RegisterAccountWithTel:(NSString *)tel password:(NSString *)password verifyCode:(NSString *)verifyCode zd3_telDist:(NSString *)zd3_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:tel?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:zd3_telDist?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelDist]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpTelRegister];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeRegister;
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.userName = tel;
            MYMGSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString];
            MYMGSDKGlobalInfo.userInfo.isReg = YES;
            [MYMGSDKGlobalInfo blmg_parserTelInfoFromResponseResult:zd31_result.zd32_responeResult];
            
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
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_loginFinished:zd31_result];
        }
    }];
}


//签到
- (void)lhxy_userSignRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpUserSign];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//获取角色
- (void)lhxy_getUserRoleRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpObtainUserRole];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//交换礼品？
- (void)lhxy_exchangePresentWithGameId:(NSString *)zd31_gameId zd32_roleId:(NSString *)zd32_roleId Request:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:YLMXGSDKAPI.gameInfo.gameID forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:zd32_roleId?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleId]];
    [params setObject:zd31_gameId?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpServiceID]];
    
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpChangePresent];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机绑定
- (void)zd31_bindMobileCodeRequestWithzd32_telNum:(NSString *)zd32_telNum zd3_telDist:(NSString *)zd3_telDist verifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:zd3_telDist?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelDist]];
    [params setObject:zd32_telNum?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpRegBindTel];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.isBind = YES;
            MYMGSDKGlobalInfo.userInfo.isBindMobile = YES;
//            MYMGSDKGlobalInfo.userInfo.userName = zd32_telNum;
            if (MYMGSDKGlobalInfo.userInfo.accountType == YLAF_AccountTypeGuest) {
                MYMGSDKGlobalInfo.userInfo.accountType = YLAF_AccountTypeMuu;
            }
            [ZhenD3LocalData_Server zd32_saveLoginedUserInfo:MYMGSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
    }];
}

//修改手机密码
- (void)zd31_ResetPwdWithBindTel:(NSString *)tel verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword zd31_ut:(NSString *)zd31_ut zd3_telDist:(NSString *)zd3_telDist  responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:tel?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:[[newPassword hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyNewPwd]];
    [params setObject:zd31_ut?:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelUt]];
    [params setObject:zd3_telDist?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelDist]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpResetTelPwd];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//游客登录升级（手机号）
- (void)zd31_UpgradeAccountWithTel:(NSString *)tel withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode zd3_telDist:(NSString *)zd3_telDist responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:tel?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTel]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAccountCode]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:zd3_telDist?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTelDist]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAccTelUpgrade];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.isBind = YES;
            MYMGSDKGlobalInfo.userInfo.isBindMobile = YES;
            MYMGSDKGlobalInfo.userInfo.userName = tel;
            MYMGSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString]?:@"";
            if (MYMGSDKGlobalInfo.userInfo.accountType == YLAF_AccountTypeGuest) {
                MYMGSDKGlobalInfo.userInfo.accountType = YLAF_AccountTypeTel;
            }
            [ZhenD3LocalData_Server zd32_saveLoginedUserInfo:MYMGSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
    }];
}

- (void)zd31_getGoodTypeRequest:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpGetGood];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd31_getGoodListWithblmg_goodType:(NSString *)blmg_goodType responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:blmg_goodType?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGoodType]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpGoodList];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)zd32_delAccResponseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    [params setObject:YLMXGSDKAPI.gameInfo.gameID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpDelAcc];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

@end
