
#import <Foundation/Foundation.h>
#import "ZhenD3AdjustConfig_Entity.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YLAF_Language) {
    YLAF_LanguageVi,
    YLAF_LanguageTh,
    YLAF_LanguageCh,
};

typedef NS_ENUM(NSInteger, YLAF_SDKServer) {
    YLAF_SDKServerVi,
    YLAF_SDKServerTh,
};

@interface ZhenD3SDKConfig_Entity : NSObject

@property (nonatomic, copy) NSString *gameID;
@property (nonatomic, copy) NSString *gameKey;

@property (nonatomic, copy) NSString *facebookAppID;
@property (nonatomic, strong) ZhenD3AdjustConfig_Entity *adjustConfig;

@property (nonatomic, assign) YLAF_SDKServer sdkConnectServer;
@end

NS_ASSUME_NONNULL_END
