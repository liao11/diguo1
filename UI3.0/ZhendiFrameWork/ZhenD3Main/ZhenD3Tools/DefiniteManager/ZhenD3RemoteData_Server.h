
#import <Foundation/Foundation.h>
#import "ZhenD3OpenAPI.h"
#import "ZhenD3SDKGlobalInfo_Entity.h"
#import "ZhenD3ResponseObject_Entity.h"
#import "YLAF_Macro_Define.h"
#import "YLAF_Helper_Utils.h"
#import "ZhenD3UrlGlobalConfig_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3RemoteData_Server : NSObject

+ (NSString *)zd32_BuildFinalUrl:(NSString *)url WithPath:(NSString *)path andParams:(NSDictionary *)params;

- (NSString *)zd32_BuildFinalUrlWithPath:(NSString *)urlPath;

- (NSString *)zd32_ParseParamKey:(NSString *)key;

- (void)zd32_SetDeviceInfosIntoParams:(NSMutableDictionary *)params;

- (void)zd32_PostRequestURL:(NSString *)URL parameters:(NSMutableDictionary *)parameters responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd32_RefreshToken:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;

- (void)zd32_RequestPath:(NSString *)path parameters:(NSDictionary *)parameters responseBlock:(void(^)(ZhenD3ResponseObject_Entity *result))responseBlock;
@end

NS_ASSUME_NONNULL_END
