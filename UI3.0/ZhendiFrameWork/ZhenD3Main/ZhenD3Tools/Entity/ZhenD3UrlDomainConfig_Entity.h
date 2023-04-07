
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3UrlDomainConfig_Entity : NSObject

@property (nonatomic, copy) NSString *zd32_baseUrl;
@property (nonatomic, copy) NSString *zd32_backupsBaseUrl;
@property (nonatomic, copy) NSString *zd32_returnupsBaseUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
