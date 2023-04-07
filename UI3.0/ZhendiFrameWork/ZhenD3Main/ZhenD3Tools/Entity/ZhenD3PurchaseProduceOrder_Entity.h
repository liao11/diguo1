
#import "ZhenD3CPPurchaseOrder_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3PurchaseProduceOrder_Entity : ZhenD3CPPurchaseOrder_Entity

@property (nonatomic, copy) NSString *purchaseUserId;
@property (nonatomic, copy) NSString *chOrderNO;
@property (nonatomic, copy) NSString *appleOrderNO;
@property (nonatomic, copy) NSString *currencyType;
@property (nonatomic, copy) NSDecimalNumber *producePrice;
@property (nonatomic, assign) NSInteger flag;

+ (instancetype)initWithCPPurchaseOrder:(ZhenD3CPPurchaseOrder_Entity *)cpOrder;
- (instancetype)initWithJsonString:(NSString *)jsonString;
- (NSString *)zd32_jsonString;

@end

NS_ASSUME_NONNULL_END
