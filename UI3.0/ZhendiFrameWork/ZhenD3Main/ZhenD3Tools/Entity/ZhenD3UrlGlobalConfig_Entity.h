
#import <Foundation/Foundation.h>
#import "ZhenD3UrlDomainConfig_Entity.h"
#import "ZhenD3UrlParamsKeyConfig_Entity.h"
#import "ZhenD3UrlRCPConfig_Entity.h"
#import "ZhenD3AESKeyConfig_Entity.h"

#define MYMGUrlConfig [ZhenD3UrlGlobalConfig_Entity SharedInstance]

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3UrlGlobalConfig_Entity : NSObject

@property (nonatomic, strong, readonly) ZhenD3UrlDomainConfig_Entity *zd32_httpsdomain;
@property (nonatomic, strong, readonly) ZhenD3UrlParamsKeyConfig_Entity *zd32_paramsconfig;
@property (nonatomic, strong, readonly) ZhenD3UrlRCPConfig_Entity *zd32_rcppathconfig;
@property (nonatomic, strong, readonly) ZhenD3AESKeyConfig_Entity *zd32_datacodeconfig;

+ (instancetype)SharedInstance;
- (void)zd32_updateCofigData;
@end

NS_ASSUME_NONNULL_END
