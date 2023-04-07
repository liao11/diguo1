
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (MYMGExtension)

- (NSString *)zd32_jsonString;
+ (NSDictionary *)zd32_dictWithJsonString:(NSString *)json;

@end

@interface NSDictionary(MYMGSafe)

- (id)zd32_safeObjectForKey:(id)key;
- (int)zd32_intValueForKey:(id)key;
- (double)zd32_doubleValueForKey:(id)key;
- (NSString *)zd32_stringValueForKey:(id)key;

@end

@interface NSMutableDictionary(MYMGSafe)

- (void)zd32_safeSetObject:(id)anObject forKey:(id)aKey;
- (void)zd32_setIntValue:(int)value forKey:(id)aKey;
- (void)zd32_setDoubleValue:(double)value forKey:(id)aKey;
- (void)zd32_setStringValueForKey:(NSString *)string forKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
