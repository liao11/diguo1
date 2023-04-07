
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3AESKeyConfig_Entity : NSObject

@property (nonatomic, copy) NSString *zd32_AES128Key;
@property (nonatomic, copy) NSString *zd32_AES128iv;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
