
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (MYMGExtension)

- (NSString *)zd32_jsonString;
+ (NSArray *)zd32_arrayWithJsonString:(NSString *)json;

@end

NS_ASSUME_NONNULL_END
