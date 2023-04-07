
#import "ZhenD3InAppPurchase_Server.h"
#import "UIDevice+GrossExtension.h"
#import "ZhenD3PurchaseProduceOrder_Entity.h"

static NSUInteger verifyReceiptFailureCount = 0;

@implementation ZhenD3InAppPurchase_Server

- (void)zd31_createAndGetChOrderNo:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    if (!purchaseOrder.productName || purchaseOrder.productName.length <= 0) {
        purchaseOrder.productName = purchaseOrder.appleProductId;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUsername]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    [params setObject:MYMGSDKGlobalInfo.gameInfo.chServerID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyServiceID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.chRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRoleID]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleId]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleName]];
    [params setObject:@(MYMGSDKGlobalInfo.gameInfo.cpRoleLevel).stringValue forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpRoleLevel]];
    [params setObject:MYMGSDKGlobalInfo.gameInfo.cpServerID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpServiceID]];
    
    [params setObject:@"2" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPaType]];
    [params setObject:purchaseOrder.cpOrderNO?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCpOrderNum]];
    [params setObject:purchaseOrder.productName?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyProductName]];
    [params setObject:purchaseOrder.appleProductId?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPaProductID]];
    [params setObject:@(purchaseOrder.cpGameCurrency)?:@"0" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyGameMoney]];
    [params setObject:purchaseOrder.cpExtraInfo?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyPaExtra]];
    [params setObject:purchaseOrder.currencyType?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyCurrencyty]];
    [params setObject:purchaseOrder.producePrice?:@"0" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyRealPa]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpOrderInfoPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
        if (zd31_result.zd32_responseCode != YLAF_ResponseCodeSuccess && zd31_result.zd32_responseCode != YLAF_ResponseCodeNetworkError) {
            zd31_result.zd32_responseCode = YLAF_ResponseCodeGenerateOrderError;
        }
        
        if (responseBlock) {
            responseBlock(zd31_result);
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_startPurchaseProduceOrderFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_startPurchaseProduceOrderFinished:zd31_result];
        }
    }];
}

- (void)zd31_checkAppleReceipt:(NSString *)receiptString withPurshaseOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder msg:(NSString * _Nullable)msg responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock {
    
    MYMGLog(@"发起服务验证的购买订单 = %@, msg = %@, \n重试次数 = %ld \n", purchaseOrder, msg, (long)verifyReceiptFailureCount);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:MYMGSDKGlobalInfo.userInfo.userID?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyUId]];
    [params setObject:MYMGSDKGlobalInfo.userInfo.token?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyToken]];
    
    [params setObject:receiptString?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyProof]];
    [params setObject:purchaseOrder.chOrderNO?:[NSString stringWithFormat:@"%@",@"so"] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyOrderNum]];
    [params setObject:purchaseOrder.appleOrderNO?:@"" forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyAppleOrderNum]];
    [params setObject:[NSString stringWithFormat:@"flag:%@ msg:%@", @(purchaseOrder.flag), msg?:@""] forKey:[self zd32_ParseParamKey:MYMGUrlConfig.zd32_paramsconfig.zd32_ckeyFlags]];
    
    NSString *url = [self zd32_BuildFinalUrlWithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAppleOrderVerifyPath];
    [self zd32_PostRequestURL:url parameters:params responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull zd31_result) {
        if (zd31_result.zd32_responseCode == YLAF_ResponseCodeNetworkError && verifyReceiptFailureCount < 3) {
            verifyReceiptFailureCount += 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self zd31_checkAppleReceipt:receiptString withPurshaseOrder:purchaseOrder msg:msg responseBlock:responseBlock];
            });
        } else {
            verifyReceiptFailureCount = 0;
            zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
            zd31_result.zd32_responeResult = @{[NSString stringWithFormat:@"%@",@"purchaseOrderJson"]: [purchaseOrder zd32_jsonString]?:@""};
            
            if (!purchaseOrder.chOrderNO || purchaseOrder.chOrderNO.length <= 0) {
                zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayFailureError;
                zd31_result.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_ChOrderNoIsNull_Alert_Text");
            }
            
            if (responseBlock) {
                responseBlock(zd31_result);
            }
            
            if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_checkOrderAppleReceiptFinished:)]) {
                [YLMXGSDKAPI.delegate zd3_checkOrderAppleReceiptFinished:zd31_result];
            }
        }
    }];
}

@end
