
#import "ZhenD3PurchaseProduceOrder_Entity.h"
#import <objc/runtime.h>
#import "NSDictionary+GrossExtension.h"

@implementation ZhenD3PurchaseProduceOrder_Entity

+ (instancetype)initWithCPPurchaseOrder:(ZhenD3CPPurchaseOrder_Entity *)cpOrder
{
    ZhenD3PurchaseProduceOrder_Entity *order = [[ZhenD3PurchaseProduceOrder_Entity alloc] init];
    order.cpOrderNO = cpOrder.cpOrderNO;
    order.cpExtraInfo = cpOrder.cpExtraInfo;
    order.appleProductId = cpOrder.appleProductId;
    order.productName = cpOrder.productName;
    order.cpGameCurrency = cpOrder.cpGameCurrency;
    
    return order;
}

- (instancetype)initWithJsonString:(NSString *)jsonString {
    if (self = [super init]) {
        if (jsonString) {
            NSDictionary *objDict = [NSDictionary zd32_dictWithJsonString:jsonString];
            unsigned int count = 0, spcount = 0;
            Ivar *ivarLists = class_copyIvarList([self class], &count);
            Ivar *spIvarList = class_copyIvarList([ZhenD3CPPurchaseOrder_Entity class], &spcount);
            
            for (int i = 0; i < count; i++) {
                const char* name = ivar_getName(ivarLists[i]);
                NSString* strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
                id value = [objDict zd32_safeObjectForKey:strName];
                if (value) {
                    [self setValue:value forKey:strName];
                }
            }
            
            for (int j=0;  j<spcount; j++) {
                const char* name = ivar_getName(spIvarList[j]);
                NSString* strName = [NSString stringWithUTF8String:name];
                id value = [objDict zd32_safeObjectForKey:strName];
                if (value) {
                    [self setValue:value forKey:strName];
                }
            }
            
            free(ivarLists);
            free(spIvarList);
        }
    }
    return self;
}
- (NSString *)zd32_jsonString {
    unsigned int count = 0, spcount = 0;
    Ivar *ivarLists = class_copyIvarList([self class], &count);
    Ivar *spIvarList = class_copyIvarList([ZhenD3CPPurchaseOrder_Entity class], &spcount);
    
    NSMutableDictionary *objDict = [[NSMutableDictionary alloc] initWithCapacity:count+spcount];
    
    for (int j=0;  j<spcount; j++) {
        const char* name = ivar_getName(spIvarList[j]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [objDict setObject:[self valueForKey:strName]?:@"" forKey:strName];
    }
    
    for (int i = 0; i < count; i++) {
        const char* name = ivar_getName(ivarLists[i]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [objDict setObject:[self valueForKey:strName]?:@"" forKey:strName];
    }
    free(ivarLists);
    free(spIvarList);
    
    return [objDict zd32_jsonString]?:@"";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Purchase 订单=%@ >",[self zd32_jsonString]];
}

@end
