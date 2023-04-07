
#import "ZhenD3RemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN
@class ZhenD3PurchaseProduceOrder_Entity;
@interface ZhenD3InAppPurchase_Server : ZhenD3RemoteData_Server

- (void)zd31_createAndGetChOrderNo:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrde responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd31_checkAppleReceipt:(NSString *)receiptString withPurshaseOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder msg:(NSString * _Nullable)msg responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

@end

NS_ASSUME_NONNULL_END
