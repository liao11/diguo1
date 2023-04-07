
#import "ZhenD3InAppPurchase_Manager.h"
#import "ZhenD3InAppPurchase_Server.h"
#import "YLAF_Macro_Define.h"
#import "ZhenD3Keychain_Manager.h"
#import "YLAF_Helper_Utils.h"
#import "MBProgressHUD+GrossExtension.h"
#import "NSString+GrossExtension.h"
#import <StoreKit/StoreKit.h>
#import <Adjust/Adjust.h>
#import <Firebase/Firebase.h>

NSString * const MYMLAppPurchaseCreateOrdersDataKey = @"com.muugame.serialization.create.order.data";
NSString * const MYMLInAppPurchaseVerfysOrdersDataKey = @"com.muugame.serialization.verify.order.data";

@interface ZhenD3InAppPurchase_Manager () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) ZhenD3InAppPurchase_Server *zd31_purchaseServer;
@property (nonatomic, strong) ZhenD3PurchaseProduceOrder_Entity *zd31_purchaseOrder;
@property (nonatomic, assign) BOOL zd31_is_geting_products;
@property (readwrite, nonatomic, strong) NSLock *lock;
@property (readwrite, nonatomic, strong) NSLock *verlock;
@end

@implementation ZhenD3InAppPurchase_Manager

+ (instancetype)zd31_SharedManager {
    static ZhenD3InAppPurchase_Manager *purchaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        purchaseManager = [[ZhenD3InAppPurchase_Manager alloc] init];
    });
    return purchaseManager;
}

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        self.zd31_is_geting_products = NO;
        self.lock = [[NSLock alloc] init];
        self.lock.name = [NSString stringWithFormat:@"%@",@"com.muugame.sdk.create.order.lock"];
        self.verlock = [[NSLock alloc] init];
        self.verlock.name = [NSString stringWithFormat:@"%@",@"com.muugame.sdk.verify.order.lock"];
    }
    return self;
}

- (ZhenD3InAppPurchase_Server *)zd31_purchaseServer {
    if (!_zd31_purchaseServer) {
        _zd31_purchaseServer = [[ZhenD3InAppPurchase_Server alloc] init];
    }
    return _zd31_purchaseServer;
}

- (void)zd31_getPurchaseProduces:(BOOL)isPurchase {
    if([SKPaymentQueue canMakePayments]) {
        if (MYMGSDKGlobalInfo.productIdentifiers && MYMGSDKGlobalInfo.productIdentifiers.count > 0) {
            if (self.zd31_is_geting_products == NO) {
                self.zd31_is_geting_products = YES;
                SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:MYMGSDKGlobalInfo.productIdentifiers];
                request.delegate = self;
                [request start];
            }
        } else {
            YLAF_RunInMainQueue(^{
                ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
                zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
                zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayNoGoods;
                zd31_result.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_NoProduceCanPurchase_Alert_Text");
                
                [MBProgressHUD zd32_showError_Toast:zd31_result.zd32_responeMsg];
                
                if (isPurchase) {
                    [self zd31_u_EndOfPurchase];
                    
                    if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_startPurchaseProduceOrderFinished:)]) {
                        [YLMXGSDKAPI.delegate zd3_startPurchaseProduceOrderFinished:zd31_result];
                    }
                } else {
                    if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_getPurchaseProducesFinished:)]) {
                        [YLMXGSDKAPI.delegate zd3_getPurchaseProducesFinished:zd31_result];
                    }
                }
            });
        }
    } else {
        YLAF_RunInMainQueue(^{
            ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
            zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
            zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayCannotMakePayments;
            zd31_result.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_CannotMakePurchase_Alert_Text");
            
            [MBProgressHUD zd32_showError_Toast:zd31_result.zd32_responeMsg];
            
            if (isPurchase) {
                [self zd31_u_EndOfPurchase];
                
                if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_startPurchaseProduceOrderFinished:)]) {
                    [YLMXGSDKAPI.delegate zd3_startPurchaseProduceOrderFinished:zd31_result];
                }
            } else {
                if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_getPurchaseProducesFinished:)]) {
                    [YLMXGSDKAPI.delegate zd3_getPurchaseProducesFinished:zd31_result];
                }
            }
        });
    }
}

- (void)zd31_startPurchaseProduceOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder {
    [self zd31_recheckCachePurchaseOrderReceipts];
    
    if (self.zd31_purchaseOrder && self.zd31_purchaseOrder.appleProductId && self.zd31_purchaseOrder.appleProductId.length > 0) {
        return;
    }
    
    YLAF_RunInMainQueue(^{
        [MBProgressHUD zd32_ShowLoadingHUD];
    });
    
    purchaseOrder.purchaseUserId = MYMGSDKGlobalInfo.userInfo.userID;
    self.zd31_purchaseOrder = purchaseOrder;
    
    if (MYMGSDKGlobalInfo.productIdentifiers && [MYMGSDKGlobalInfo.productIdentifiers containsObject:purchaseOrder.appleProductId] == NO) {
        NSMutableSet *new_set = [[NSMutableSet alloc] initWithSet:MYMGSDKGlobalInfo.productIdentifiers];
        [new_set addObject:purchaseOrder.appleProductId];
        MYMGSDKGlobalInfo.productIdentifiers = new_set;
        
        [self zd31_getPurchaseProduces:YES];
    } else {
        if (MYMGSDKGlobalInfo.purchaseProduces) {
            [self zd31_u_GetProductAndStartPurchaseForCPOrder:purchaseOrder];
        } else {
            [self zd31_getPurchaseProduces:YES];
        }
    }
}

- (void)zd31_recheckCachePurchaseOrderReceipts {
    NSArray *dictList = [self zd31_u_getOrderReceiptsFromKeychain];
    if (dictList && dictList.count > 0) {
        
        for (NSDictionary *dict in dictList) {
            NSString *json = dict[[NSString stringWithFormat:@"%@",@"purchaseOrderJson"]];
            NSString *receipt = dict[[NSString stringWithFormat:@"%@",@"receipt"]];

            if (json && json.length > 0) {
                ZhenD3PurchaseProduceOrder_Entity *purchaseOrder = [[ZhenD3PurchaseProduceOrder_Entity alloc] initWithJsonString:json];
                purchaseOrder.flag = 200;
                
                if (purchaseOrder && [purchaseOrder.purchaseUserId isEqualToString:MYMGSDKGlobalInfo.userInfo.userID]) {
                    [self.zd31_purchaseServer zd31_checkAppleReceipt:receipt withPurshaseOrder:purchaseOrder msg:@"" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
                        if (result.zd32_responseCode != YLAF_ResponseCodeNetworkError && result.zd32_responseCode != YLAF_ResponseCodeTokenFailureError && result.zd32_responseCode != YLAF_ResponseCodeTokenError && result.zd32_responseCode != YLAF_ResponseCodeReLoginError && result.zd32_responseCode != YLAF_ResponseCodeServerError) {
                            [self zd31_u_removeOrderReceiptFromKeychain:purchaseOrder];
                        }
                    }];
                }
            }
        }
    }
    
    for (SKPaymentTransaction *transaction in [[SKPaymentQueue defaultQueue] transactions]) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                [self zd31_u_verifyReceiptWithTransaction:transaction flag:100];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateRestored: {
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
            default:
                break;
        }
    }
}

- (void)zd31_restorePurchaseProduces {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


- (void)zd31_u_EndOfPurchase {
    self.zd31_purchaseOrder = nil;
    
    YLAF_RunInMainQueue(^{
        [MBProgressHUD zd32_DismissLoadingHUD];
    });
}

- (void)zd31_u_GetProductAndStartPurchaseForCPOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder {
    SKProduct *purchaseOrder_product = nil;
    for (SKProduct *product in MYMGSDKGlobalInfo.purchaseProduces) {
        if ([purchaseOrder.appleProductId isEqualToString:product.productIdentifier]) {
            purchaseOrder.currencyType = [product.priceLocale objectForKey:NSLocaleCurrencyCode];
            purchaseOrder.producePrice = product.price;

            purchaseOrder_product = product;
            break;
        }
    }
    
    if (purchaseOrder_product != nil) {
        [self zd31_u_createPurchaseOrder:purchaseOrder withProduct:purchaseOrder_product];
    } else {
        YLAF_RunInMainQueue(^{
            [self zd31_u_EndOfPurchase];
            
            NSString *msg = [NSString stringWithFormat:@"%@%@%@",MUUQYLocalizedString(@"MUUQYKey_ProductInvalidOrNotExist_Pre_Text"), purchaseOrder.appleProductId, MUUQYLocalizedString(@"MUUQYKey_ProductInvalidOrNotExist_Suf_Text")];
            [MBProgressHUD zd32_showError_Toast:msg];
            
            ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
            zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
            zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayInvalidIProduceId;
            zd31_result.zd32_responeMsg = msg;
            
            if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_startPurchaseProduceOrderFinished:)]) {
                [YLMXGSDKAPI.delegate zd3_startPurchaseProduceOrderFinished:zd31_result];
            }
        });
    }
}

- (void)zd31_u_createPurchaseOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder withProduct:(SKProduct *)product {
    [self.zd31_purchaseServer zd31_createAndGetChOrderNo:purchaseOrder responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            purchaseOrder.chOrderNO = result.zd32_responeResult[[NSString stringWithFormat:@"%@",@"sdk_orderno"]];
            [self zd31_u_hikeApplePurchaseOrder:purchaseOrder withProduct:product];
        } else {
            YLAF_RunInMainQueue(^{
                [self zd31_u_EndOfPurchase];
                
                [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
            });
        }
    }];
}

- (void)zd31_u_hikeApplePurchaseOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder withProduct:(SKProduct *)product {
    if (!purchaseOrder.chOrderNO || [purchaseOrder.chOrderNO isKindOfClass:[NSString class]] == NO || purchaseOrder.chOrderNO.length <= 0) {
        YLAF_RunInMainQueue(^{
            [self zd31_u_EndOfPurchase];
            
            ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
            zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
            zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayFailureError;
            zd31_result.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_GetChOrderNoFail_Alert_Text");
            
            [MBProgressHUD zd32_showError_Toast:zd31_result.zd32_responeMsg];
            
            if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_startPurchaseProduceOrderFinished:)]) {
                [YLMXGSDKAPI.delegate zd3_startPurchaseProduceOrderFinished:zd31_result];
            }
        });
    } else {
        if (product == nil) {
            [self zd31_u_EndOfPurchase];
            
            return;
        }
        
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
        payment.applicationUsername = purchaseOrder.chOrderNO;
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
        [self zd31_u_saveStartOrder:purchaseOrder];
        
        YLAF_RunInMainQueue(^{
            ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
            zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
            zd31_result.zd32_responseCode = YLAF_ResponseCodeSuccess;
            zd31_result.zd32_responeResult = @{[NSString stringWithFormat:@"%@",@"purchaseOrder"]: [purchaseOrder zd32_jsonString]};
            
            if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_startPurchaseProduceOrderFinished:)]) {
                [YLMXGSDKAPI.delegate zd3_startPurchaseProduceOrderFinished:zd31_result];
            }
        });
    }
}

- (void)zd31_u_verifyReceiptWithTransaction:(SKPaymentTransaction *)transaction flag:(NSInteger)flag {
    MYMGLog(@"内购:验单 productid=%@, transaction.payment.applicationUsername=%@, flag：%ld", transaction.payment.productIdentifier, transaction.payment.applicationUsername, (long)flag);
    
    NSString *base64_receipt = nil;
    NSData *receiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    if(receiptData){
        base64_receipt = [receiptData base64EncodedStringWithOptions:0];
    }
    
    ZhenD3PurchaseProduceOrder_Entity *tradingPurchaseOrder = nil;
    if (flag == 0) {
        if (self.zd31_purchaseOrder && [self.zd31_purchaseOrder.appleProductId isEqualToString:transaction.payment.productIdentifier]) {
            tradingPurchaseOrder = self.zd31_purchaseOrder;
        }
    }
    
    NSString *msg = nil;
    if (!tradingPurchaseOrder) {
        NSString *order_json = [self zd31_u_getStartOrdersForProductid:transaction.payment.productIdentifier];
        tradingPurchaseOrder = [[ZhenD3PurchaseProduceOrder_Entity alloc] initWithJsonString:order_json];
        if (order_json == nil || order_json.length <= 0) {
            tradingPurchaseOrder.appleProductId = transaction.payment.productIdentifier;
            msg = [NSString stringWithFormat:@"%@",@"验单从本地获取发起支付的购买订单为空的。"];
            YLAF_RunInMainQueue(^{
                [MBProgressHUD zd32_showError_Toast:msg];
            });
        }
    }
    tradingPurchaseOrder.appleOrderNO = transaction.transactionIdentifier;
    
    [self zd31_u_saveToKeychainOrder:tradingPurchaseOrder wtihReceipt:base64_receipt];
    [self zd31_u_removeStartOrder:tradingPurchaseOrder];
    
    
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    tradingPurchaseOrder.flag = flag;
    [self.zd31_purchaseServer zd31_checkAppleReceipt:base64_receipt withPurshaseOrder:tradingPurchaseOrder msg:msg responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (flag == 0 && self.zd31_purchaseOrder) {
            [self zd31_u_EndOfPurchase];
            
            if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
                YLAF_RunInMainQueue(^{
                    [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
                });
            }
        }
        
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            double purchase_price = [tradingPurchaseOrder.producePrice doubleValue];
            if (purchase_price > 0) {
                NSString *currency = tradingPurchaseOrder.currencyType?:[NSString stringWithFormat:@"%@",@"VND"];
                
                ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenPurchase];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:tradingPurchaseOrder.chOrderNO?:@""];
                [event setRevenue:purchase_price currency:currency];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值金额"] parameters:@{kFIRParameterPrice : @(purchase_price), kFIRParameterCurrency : currency, [NSString stringWithFormat:@"%@",@"order_id"]: tradingPurchaseOrder.chOrderNO?:@""}];
                
                [self zd31_u_SendAdjustARPUEvent:purchase_price currency:currency orderId:tradingPurchaseOrder.chOrderNO?:@""];
            }
        }
        
        if (result.zd32_responseCode != YLAF_ResponseCodeNetworkError && result.zd32_responseCode != YLAF_ResponseCodeTokenFailureError && result.zd32_responseCode != YLAF_ResponseCodeTokenError && result.zd32_responseCode != YLAF_ResponseCodeReLoginError && result.zd32_responseCode != YLAF_ResponseCodeServerError) {
            
            [self zd31_u_removeOrderReceiptFromKeychain:tradingPurchaseOrder];
        }
    }];
}

- (void)zd31_u_SendAdjustARPUEvent:(double)price currency:(NSString *)currency orderId:(NSString *)orderId {
    NSArray *arpu_level = @[@(2199000),@(1199000),@(709000),@(219000),@(109000)];
    if (currency) {
        if ([currency isEqualToString:@"USD"]) {
            arpu_level = @[@(99.99),@(49.99),@(29.99),@(9.99),@(4.99)];
        } else if ([currency isEqualToString:@"CNY"]) {
            arpu_level = @[@(648),@(348),@(208),@(68),@(30)];
        } else if ([currency isEqualToString:@"THB"]) {
            arpu_level = @[@(3000),@(1700),@(929),@(299),@(149)];
        }
    }
    
    if (price >= [arpu_level[0] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenPurchaseARPU100];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_99_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[1] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenPurchaseARPU50];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_49_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[2] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenPurchaseARPU30];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_29_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[3] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenPurchaseARPU10];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_9_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[4] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenPurchaseARPU5];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_4_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    ADJEvent *event = [ADJEvent eventWithEventToken:MYMGSDKGlobalInfo.adjustConfig.zd3_eventTokenPurchaseARPU1];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:MYMGSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
    [Adjust trackEvent:event];
    
    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_0_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
}


- (void)zd31_u_saveStartOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder {
    [self.lock lock];
    if (purchaseOrder) {
        ZhenD3PurchaseProduceOrder_Entity *starPurchaseOrder = purchaseOrder;
        NSString *order_jsonString = [starPurchaseOrder zd32_jsonString];
        if (!order_jsonString || order_jsonString.length <= 0) {
            YLAF_RunInMainQueue(^{
                [MBProgressHUD zd32_showError_Toast:[NSString stringWithFormat:@"%@",@"保存发起订单，订单对象转json失败。"]];
            });
        } else {
            NSString *key = starPurchaseOrder.appleProductId?:@"";
            NSDictionary *savedDict = [ZhenD3Keychain_Manager zd32_keychainObjectForService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
            NSMutableDictionary *newDict = savedDict?[savedDict mutableCopy]:[[NSMutableDictionary alloc] init];
            [newDict setObject:order_jsonString forKey:key];
            
            [ZhenD3Keychain_Manager zd32_keychainSaveObject:newDict forService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
        }
    }
    [self.lock unlock];
}

- (void)zd31_u_removeStartOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder {
    [self.lock lock];
    if (purchaseOrder) {
        ZhenD3PurchaseProduceOrder_Entity *starPurchaseOrder = purchaseOrder;
        NSString *key = starPurchaseOrder.appleProductId?:@"";
        NSDictionary *savedDict = [ZhenD3Keychain_Manager zd32_keychainObjectForService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
        if (savedDict && savedDict.count > 0) {
            NSMutableDictionary *newDict = [savedDict mutableCopy];
            [newDict removeObjectForKey:key];
            
            [ZhenD3Keychain_Manager zd32_keychainSaveObject:newDict forService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
        }
    }
    [self.lock unlock];
}

- (NSString *)zd31_u_getStartOrdersForProductid:(NSString *)productid {
    [self.lock lock];
    NSString *key = productid;
    NSDictionary *savedDict = [ZhenD3Keychain_Manager zd32_keychainObjectForService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
    NSString *order_jsonString = [savedDict objectForKey:key];
    [self.lock unlock];
    return order_jsonString;
}

- (void)zd31_u_saveToKeychainOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder wtihReceipt:(NSString *)receiptStr {
    [self.verlock lock];
    NSString *key = purchaseOrder.chOrderNO;
    NSString *order_jsonString = [purchaseOrder zd32_jsonString];
    NSString *purchaseUserId = purchaseOrder.purchaseUserId;
    if (!order_jsonString || order_jsonString.length <= 0) {
        YLAF_RunInMainQueue(^{
            [MBProgressHUD zd32_showError_Toast:[NSString stringWithFormat:@"%@",@"保存验证订单，订单对象转json失败。"]];
        });
    } else {
        if (key && key.length > 0) {
            NSDictionary *savedDict = [ZhenD3Keychain_Manager zd32_keychainObjectForService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
            
            NSMutableDictionary *newDict = savedDict?[savedDict mutableCopy]:[[NSMutableDictionary alloc] init];
            [newDict setObject:@{[NSString stringWithFormat:@"%@",@"purchaseOrderJson"]:order_jsonString, [NSString stringWithFormat:@"%@",@"receipt"]:receiptStr?:@""} forKey:key];
            
            [ZhenD3Keychain_Manager zd32_keychainSaveObject:newDict forService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
        } else {
            YLAF_RunInMainQueue(^{
                [MBProgressHUD zd32_showError_Toast:[NSString stringWithFormat:@"%@",@"保存验证订单，SDK订单号为空。"]];
            });
        }
    }
    [self.verlock unlock];
}

- (void)zd31_u_removeOrderReceiptFromKeychain:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder {
    [self.verlock lock];
    NSString *key = purchaseOrder.chOrderNO;
    NSString *purchaseUserId = purchaseOrder.purchaseUserId;
    if (key && key.length > 0) {
        NSDictionary *savedDict = [ZhenD3Keychain_Manager zd32_keychainObjectForService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
        if (savedDict && savedDict.count > 0) {
            NSMutableDictionary *newDict = [savedDict mutableCopy];
            [newDict removeObjectForKey:key];
            
            [ZhenD3Keychain_Manager zd32_keychainSaveObject:newDict forService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
        }
    }
    [self.verlock unlock];
}

- (NSArray *)zd31_u_getOrderReceiptsFromKeychain {
    [self.verlock lock];
    NSDictionary *savedDict = [ZhenD3Keychain_Manager zd32_keychainObjectForService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:MYMGSDKGlobalInfo.userInfo.userID];
    [self.verlock unlock];
    return savedDict.allValues;
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *myProduct = response.products;
    
    MYMGLog(@"内购:向苹果服务器请求产品结果 invalidProductIdentifiers:%@ 产品付费数量: %d",response.invalidProductIdentifiers, (int)myProduct.count);
    NSMutableArray *productsPrices = [[NSMutableArray alloc] initWithCapacity:myProduct.count];
    for(SKProduct *product in myProduct){
        MYMGLog(@"\n\n Product id: %@ \n 描述信息: %@ \n 产品标题: %@\n 产品描述信息: %@\n 价格: %@\n 货币类型: %@\n",
                   product.productIdentifier, product.description,
                   product.localizedTitle, product.localizedDescription,
                   product.price, [product.priceLocale objectForKey:NSLocaleCurrencyCode]);
        
        [productsPrices addObject:@{[NSString stringWithFormat:@"%@",@"productPrice"] : (product.price?:@""),
                                   [NSString stringWithFormat:@"%@",@"currencyType"] : ([product.priceLocale objectForKey:NSLocaleCurrencyCode]?:@""),
                                   [NSString stringWithFormat:@"%@",@"applePayProductId"] : (product.productIdentifier?:@"")}];
    }
    
    MYMGSDKGlobalInfo.purchaseProduces = myProduct;
    
    self.zd31_is_geting_products = NO;
    
    if (self.zd31_purchaseOrder) {
        [self zd31_u_GetProductAndStartPurchaseForCPOrder:self.zd31_purchaseOrder];
    } else {
        YLAF_RunInMainQueue(^{
            ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
            zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
            if (myProduct.count <= 0) {
                zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayNoGoods;
            } else {
                zd31_result.zd32_responseCode = YLAF_ResponseCodeSuccess;
                zd31_result.zd32_responeResult = @{[NSString stringWithFormat:@"%@",@"productsPrices"] : productsPrices};
            }
            
            if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_getPurchaseProducesFinished:)]) {
                [YLMXGSDKAPI.delegate zd3_getPurchaseProducesFinished:zd31_result];
            }
        });
    }
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    self.zd31_is_geting_products = NO;
    
    YLAF_RunInMainQueue(^{
        if (self.zd31_purchaseOrder) {
            [self zd31_u_EndOfPurchase];
            
            [MBProgressHUD zd32_showError_Toast:error.localizedDescription];
        }
        
        ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
        zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
        zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayRequestFailure;
        zd31_result.zd32_responeMsg = error.localizedDescription;
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_getPurchaseProducesFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_getPurchaseProducesFinished:zd31_result];
        }
    });
}

- (void)requestDidFinish:(SKRequest *)request {
    self.zd31_is_geting_products = NO;
}


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for(SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                [self zd31_u_verifyReceiptWithTransaction:transaction flag:0];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                YLAF_RunInMainQueue(^{
                    [self zd31_u_EndOfPurchase];
                    
                    ZhenD3ResponseObject_Entity *zd31_result = [[ZhenD3ResponseObject_Entity alloc] init];
                    zd31_result.zd32_responseType = YLAF_ResponseTypeApplePay;
                    
                    if (transaction.error.code == SKErrorPaymentCancelled) {
                        zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayCancel;
                        zd31_result.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_AuthorizeCanceled_Alert_Text");
                    } else {
                        zd31_result.zd32_responseCode = YLAF_ResponseCodeApplePayFailureError;
                        zd31_result.zd32_responeMsg = transaction.error.localizedDescription;
                    }
                    
                    [MBProgressHUD zd32_showError_Toast:zd31_result.zd32_responeMsg];
                    
                    if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_startPurchaseProduceOrderFinished:)]) {
                        [YLMXGSDKAPI.delegate zd3_startPurchaseProduceOrderFinished:zd31_result];
                    }
                });
            }
                break;
            case SKPaymentTransactionStateRestored: {
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                [self zd31_u_EndOfPurchase];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
            default:
                break;
        }
    }
}

@end
