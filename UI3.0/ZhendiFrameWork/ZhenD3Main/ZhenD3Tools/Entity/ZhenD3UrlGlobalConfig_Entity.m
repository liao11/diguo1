
#import "ZhenD3UrlGlobalConfig_Entity.h"
#import "YLAF_Helper_Utils.h"

@interface ZhenD3UrlGlobalConfig_Entity ()

@property (nonatomic, strong, readwrite) ZhenD3UrlDomainConfig_Entity *zd32_httpsdomain;
@property (nonatomic, strong, readwrite) ZhenD3UrlParamsKeyConfig_Entity *zd32_paramsconfig;
@property (nonatomic, strong, readwrite) ZhenD3UrlRCPConfig_Entity *zd32_rcppathconfig;
@property (nonatomic, strong, readwrite) ZhenD3AESKeyConfig_Entity *zd32_datacodeconfig;
@end

@implementation ZhenD3UrlGlobalConfig_Entity

+ (instancetype)SharedInstance {
    static ZhenD3UrlGlobalConfig_Entity* shareGlobalConfig = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareGlobalConfig = [[self alloc] init];
    });
    return shareGlobalConfig;
}

- (instancetype)init {
    if (self = [super init]) {
        [self zd32_updateCofigData];
    }
    return self;
}

- (void)zd32_updateCofigData {
//    NSDictionary *dict = [YLAF_Helper_Utils zd32_urlConifgsFromPlist];
    NSDictionary *dict = [YLAF_Helper_Utils zd32_getWordParam];
    self.zd32_httpsdomain = [[ZhenD3UrlDomainConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"zd32_domain_name"]]];
    self.zd32_paramsconfig = [[ZhenD3UrlParamsKeyConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"zd32_pathparams_key"]]];
    self.zd32_rcppathconfig = [[ZhenD3UrlRCPConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"zd32_url_path"]]];
    self.zd32_datacodeconfig = [[ZhenD3AESKeyConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"zd32_aes_key"]]];
}

@end
