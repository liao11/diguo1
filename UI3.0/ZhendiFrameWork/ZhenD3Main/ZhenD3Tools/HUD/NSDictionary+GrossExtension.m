
#import "NSDictionary+GrossExtension.h"

#define zd32_isValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])
#define zd32_isValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])

@implementation NSDictionary (MYMGExtension)

- (NSString *)zd32_jsonString
{
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSDictionary *)zd32_dictWithJsonString:(NSString *)json
{
    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:nil];
    return info;
}

@end

@implementation NSDictionary (MYMGSafe)

- (id)zd32_safeObjectForKey:(id)key {
    if (!zd32_isValidKey(key)) {
        return nil;
    }
    id obj = [self objectForKey:key];
    if(!zd32_isValidValue(obj))
        return nil;
    return obj;
}

- (int)zd32_intValueForKey:(id)key {
    id obj = [self zd32_safeObjectForKey:key];
    return [obj intValue];
}

- (double)zd32_doubleValueForKey:(id)key {
    id obj = [self zd32_safeObjectForKey:key];
    return [obj doubleValue];
}

- (NSString *)zd32_stringValueForKey:(id)key {
    id obj = [self zd32_safeObjectForKey:key];
    if ([obj respondsToSelector:@selector(stringValue)]) {
        return [obj stringValue];
    }
    
    return nil;
}

@end

@implementation NSMutableDictionary(MYMGSafe)

- (void)zd32_safeSetObject:(id)anObject forKey:(id)aKey {
    if (!zd32_isValidKey(aKey)) {
        return;
    }
    if ([aKey isKindOfClass:[NSString class]]) {
        [self setValue:anObject forKey:aKey];
    }
    else {
        if (anObject != nil) {
            [self setObject:anObject forKey:aKey];
        }
        else {
            [self removeObjectForKey:aKey];
        }
    }
}

- (void)zd32_setIntValue:(int)value forKey:(id)aKey {
    [self zd32_safeSetObject:[[NSNumber numberWithInt:value] stringValue] forKey:aKey];
}

- (void)zd32_setDoubleValue:(double)value forKey:(id)aKey {
    [self zd32_safeSetObject:[[NSNumber numberWithDouble:value] stringValue] forKey:aKey];
}

- (void)zd32_setStringValueForKey:(NSString *)string forKey:(id)aKey {
    [self zd32_safeSetObject:string forKey:aKey];
}

@end
