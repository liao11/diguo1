
#import "ZhenD3AESKeyConfig_Entity.h"
#import <objc/runtime.h>
#import "NSDictionary+GrossExtension.h"

@implementation ZhenD3AESKeyConfig_Entity

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (dict && dict.count > 0) {
            unsigned int count;
            objc_property_t *prList = class_copyPropertyList([self class], &count);
            for (int i = 0; i < count; i++) {
                const char *name = property_getName(prList[i]);
                NSString *strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
                id dictValue = [dict zd32_safeObjectForKey:strName];
                if (dictValue) {
                    [self setValue:dictValue forKey:strName];
                }
            }
            free(prList);
        }
    }
    return self;
}

@end
