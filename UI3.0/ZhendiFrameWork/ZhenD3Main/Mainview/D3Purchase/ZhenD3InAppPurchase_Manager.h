
#import <Foundation/Foundation.h>
#import "ZhenD3PurchaseProduceOrder_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3InAppPurchase_Manager : NSObject

+ (instancetype)zd31_SharedManager;

- (void)zd31_getPurchaseProduces:(BOOL)isPurchase;

- (void)zd31_startPurchaseProduceOrder:(ZhenD3PurchaseProduceOrder_Entity *)purchaseOrder;

- (void)zd31_restorePurchaseProduces;

- (void)zd31_recheckCachePurchaseOrderReceipts;
@end

NS_ASSUME_NONNULL_END
