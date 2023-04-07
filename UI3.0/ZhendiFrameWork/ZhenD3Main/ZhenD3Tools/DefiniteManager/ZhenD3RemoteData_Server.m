
#import "ZhenD3RemoteData_Server.h"
#import <AFNetworking/AFNetworking.h>
#import <GTMBase64/GTMBase64.h>
#import <Adjust/Adjust.h>
#import "NSString+GrossExtension.h"
#import "NSData+GrossExtension.h"
#import "UIDevice+GrossExtension.h"

@interface ZhenD3RemoteData_Server ()

@property (nonatomic, strong) AFHTTPSessionManager *zd32_manager;
@end

@implementation ZhenD3RemoteData_Server

- (instancetype)init {
    if (self = [super init]) {
        _zd32_manager = [AFHTTPSessionManager manager];
        _zd32_manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _zd32_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _zd32_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _zd32_manager.requestSerializer.timeoutInterval = 30.0;
        _zd32_manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:[NSString stringWithFormat:@"%@",@"text/html"],[NSString stringWithFormat:@"%@",@"text/plain"],[NSString stringWithFormat:@"%@",@"application/json"],[NSString stringWithFormat:@"%@",@"application/xml"],@"application/xhtml+xml",[NSString stringWithFormat:@"%@",@"text/xml"],[NSString stringWithFormat:@"%@",@"*/*"], nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:YES];
        _zd32_manager.securityPolicy = securityPolicy;
        
        
        
    }
    return self;
}


- (AFSecurityPolicy*)customSecurityPolicy
{
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"hgcang"] ofType:[NSString stringWithFormat:@"%@",@"cer"]];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    
    
    securityPolicy.allowInvalidCertificates = YES;
    
    
    
    
    
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
    
    return securityPolicy;
}

- (NSMutableDictionary *)zd32_u_packPublicParameters {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyTimeStamp]];
    [params setObject:YLMXGSDKAPI.zd3_SDKVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySDKVersion]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.gameID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameId]];
    [params setObject:@"2" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPlatform]];
    [params setObject:[UIDevice obtainChannel]?:[NSString stringWithFormat:@"%@",@"10"] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyChannel]];
    [params setObject:[UIDevice obtainSubChannel]?:[NSString stringWithFormat:@"%@",@"01"] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySubChannel]];
    
    [params setObject:[UIDevice blmg_getDeviceNo]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceNO]];
    
    //1 idfa  2 idfv
    NSString *zd32_iGet = @"1";
    NSString *blmg_iNor = [UIDevice gainIDFA]?:@"";
    if ([blmg_iNor hasPrefix:@"00000000"]) {
        blmg_iNor = [[UIDevice currentDevice].identifierForVendor UUIDString]?:@"";
        zd32_iGet = @"2";
    }else{
        blmg_iNor = [UIDevice gainIDFA];
        zd32_iGet = @"1";
    }
    
    [params setObject:blmg_iNor?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceIDFA]];
    
    [params setObject:zd32_iGet?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyIsIdfa]];
    
    return params;
}

- (NSString *)zd32_u_md5SignForParams:(NSMutableDictionary *)params withAppKey:(NSString *)appKey {
    NSMutableString * sign = [NSMutableString string];
    
    if (params && params.count > 0) {
        NSArray *allkeys = [params allKeys];
              
        NSArray *sortKeys = [allkeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (int i = 0; i < allkeys.count; i++) {
            NSString * temp = [NSString stringWithFormat:@"%@=%@&",sortKeys[i],[params objectForKey:sortKeys[i]]];
            [sign appendString:temp];
        }
        [sign deleteCharactersInRange:NSMakeRange(sign.length-1, 1)];
    }
      
    if (appKey) {
        [sign appendString:appKey];
    }
       
    return [[sign hash_md5] uppercaseString];
}

- (NSMutableDictionary *)zd32_u_encryptParams:(NSMutableDictionary *)parameters {
//    parameters = @{}
    NSString *md5Sign = [self zd32_u_md5SignForParams:parameters withAppKey:MYMGSDKGlobalInfo.gameInfo.gameKey];
    
    [parameters setValue:md5Sign?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySign]];
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    data = [data AES128EncryptWithKey:MYMGUrlConfig.zd32_datacodeconfig.zd32_AES128Key iv:MYMGUrlConfig.zd32_datacodeconfig.zd32_AES128iv];
    
    data = [GTMBase64 encodeData:data];
    
    NSString *encryptParamsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * encryptParams = [[NSMutableDictionary alloc] init];
    [encryptParams setObject:encryptParamsStr?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyData]];
    
    return encryptParams;
}

- (NSDictionary *)zd32_u_decryptResponseObject:(NSData *)responseObject {
    if (responseObject) {
        NSData *responseData = responseObject;
        
        responseData = [GTMBase64 decodeData:responseData];
        
        responseData = [responseData AES128DecryptWithKey:MYMGUrlConfig.zd32_datacodeconfig.zd32_AES128Key iv:MYMGUrlConfig.zd32_datacodeconfig.zd32_AES128iv];;
        
        NSDictionary *dataDict = nil;
        if (responseData) {
            dataDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        }
        
        return dataDict;
    }
    
    return nil;
}

- (void)zd32_u_refreshNewTokenWithOriginUrl:(NSString *)originUrl parameters:(NSMutableDictionary *)parameters responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    [parameters removeObjectForKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySign];
    MYMGLog(@"刷新新Token前的待签名参数 parameters=%@",parameters);
    
    [self zd32_RefreshToken:^(ZhenD3ResponseObject_Entity * _Nonnull zd32_result) {
        if (zd32_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            NSString * token = [zd32_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
            MYMGLog(@"刷新新Token后新token newtoken=%@",token);
            
            [parameters setObject:token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
            [self zd32_PostRequestURL:originUrl parameters:parameters responseBlock:responseBlock];
        } else {
            if (responseBlock) {
                responseBlock(zd32_result);
            }
        }
    }];
}


+ (NSString *)zd32_BuildFinalUrl:(NSString *)url WithPath:(NSString *)path andParams:(NSDictionary *)params {
    NSMutableString * finalUrl = [[NSMutableString alloc] initWithFormat:@"%@%@",url, path];
    
    if (params && params.count > 0) {
        NSRange range = [finalUrl rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"?"]];
        if (range.location == NSNotFound) {
            [finalUrl appendString:@"?"];
        } else {
            [finalUrl appendString:@"&"];
        }
        
        NSArray *keys = params.allKeys;
        for (int i=0; i<keys.count; i++) {
            NSString *key = keys[i];
            NSString *value = [params objectForKey:key];
            
            NSString *s = [NSString stringWithFormat:@"%@=%@", [key urlEncoding], [value urlEncoding]];
            [finalUrl appendString:s];
            
            if (i < keys.count-1) {
                [finalUrl appendString:@"&"];
            }
        }
    }
       
    return finalUrl;
}

- (NSString *)zd32_BuildFinalUrlWithPath:(NSString *)urlPath {
    return [NSString stringWithFormat:@"%@%@",MYMGUrlConfig.zd32_httpsdomain.zd32_baseUrl, urlPath];
}

- (NSString *)zd32_ParseParamKey:(NSString *)key {
    return key;
}

- (void)zd32_SetDeviceInfosIntoParams:(NSMutableDictionary *)params {
    [params setObject:[UIDevice zd32_getCurrentDeviceNetworkingStates]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceNetwork]];
    [params setObject:[UIDevice zd32_getCurrentDeviceModelProvider]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceModelProvider]];
    [params setObject:[UIDevice zd32_getCurrentDeviceModel]?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyDeviceType]];
    [params setObject:[UIDevice currentDevice].systemVersion forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeySystemVersion]];
    [params setObject:Adjust.adid?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAdjustDeviceID]];
    [params setObject:@"1" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPlaform]];
}

- (void)zd32_PostRequestURL:(NSString *)URL parameters:(NSMutableDictionary *)parameters responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *publicParams = [self zd32_u_packPublicParameters];
    
    if (parameters && parameters.count > 0) {
        [publicParams addEntriesFromDictionary:parameters];
    }

    NSMutableDictionary *finalParams = [self zd32_u_encryptParams:publicParams];
    
    [_zd32_manager POST:URL parameters:finalParams headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [self zd32_u_decryptResponseObject:responseObject];
        
        if ([URL hasSuffix:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAppleOrderVerifyPath]) {
            NSMutableDictionary *temp = [publicParams mutableCopy];
            NSString *rp = temp[[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyProof]];
            if (rp && rp.length > 101) {
                [temp setObject:[rp substringToIndex:100] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyProof]];
            }
            MYMGLog(@"请求url = %@,\n params = %@,\n respone =%@", URL, temp, responseObject);
        } else {
            MYMGLog(@"请求url = %@,\n params = %@,\n respone =%@", URL, publicParams, responseObject);
        }
        
        ZhenD3ResponseObject_Entity *response = [[ZhenD3ResponseObject_Entity alloc] init];
        response.zd32_responeMsg = [responseObject objectForKey:[NSString stringWithFormat:@"%@",@"msg"]];
        response.zd32_responseCode = [[responseObject objectForKey:[NSString stringWithFormat:@"%@",@"code"]] integerValue];
        response.zd32_responeResult = [responseObject objectForKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyData];
        
        if (!responseObject) {
            response.zd32_responseCode = YLAF_ResponseCodeServerError;
            response.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_Https_ServerError_Alert_Text");;
        }
        
        if (response.zd32_responseCode == YLAF_ResponseCodeTokenError || response.zd32_responseCode == YLAF_ResponseCodeTokenFailureError) {
            [self zd32_u_refreshNewTokenWithOriginUrl:URL parameters:publicParams responseBlock:responseBlock];
        } else {
            if (responseBlock) {
                responseBlock(response);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYMGLog(@"请求url = %@, params = %@, error =%@", URL, publicParams, error);
        
        ZhenD3ResponseObject_Entity *failureResponse = [[ZhenD3ResponseObject_Entity alloc] init];
        failureResponse.zd32_responeMsg = [NSString stringWithFormat:@"%@(%ld)",MUUQYLocalizedString(@"MUUQYKey_Https_NetworkError_Alert_Text"),(long)error.code];
        failureResponse.zd32_responseCode = YLAF_ResponseCodeNetworkError;
        failureResponse.zd32_responeResult = nil;
        if (responseBlock) {
            responseBlock(failureResponse);
        }
    }];
}

- (void)zd32_RefreshToken:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.autoToken?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRefreshToken]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpRefreshTokenPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd32_result) {
        if (zd32_result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            MYMGSDKGlobalInfo.userInfo.token = [zd32_result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
        }
        
        if (responseBlock) {
            responseBlock(zd32_result);
        }
    }];
}

- (void)zd32_RequestPath:(NSString *)path parameters:(NSDictionary *)parameters  responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    if (parameters && parameters.count > 0) {
        [params addEntriesFromDictionary:parameters];
    }
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:path];
    [self zd32_PostRequestURL:url parameters:params responseBlock:responseBlock];
}
@end
