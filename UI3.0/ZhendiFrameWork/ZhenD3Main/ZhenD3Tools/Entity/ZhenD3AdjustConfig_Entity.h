
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YLAF_Environment) {
    YLAF_EnvironmentSandbox,
    YLAF_EnvironmentProduction,
};
@interface ZhenD3AdjustConfig_Entity : NSObject

@property (nonatomic, copy) NSString *adjustAppToken;
@property (nonatomic, assign) YLAF_Environment environment;

@property (nonatomic, copy) NSString *zd3_eventTokenLogin;
@property (nonatomic, copy) NSString *zd3_eventTokenRegister;
@property (nonatomic, copy) NSString *zd3_eventTokenAccRegister;
@property (nonatomic, copy) NSString *zd3_eventTokenFBRegister;
@property (nonatomic, copy) NSString *zd3_eventTokenCreateRoles;
@property (nonatomic, copy) NSString *zd3_eventTokenCompleteNoviceTask;
@property (nonatomic, copy) NSString *zd3_eventTokenPurchase;
@property (nonatomic, copy) NSString *zd3_eventTokenPurchaseARPU1;
@property (nonatomic, copy) NSString *zd3_eventTokenPurchaseARPU5;
@property (nonatomic, copy) NSString *zd3_eventTokenPurchaseARPU10;
@property (nonatomic, copy) NSString *zd3_eventTokenPurchaseARPU30;
@property (nonatomic, copy) NSString *zd3_eventTokenPurchaseARPU50;
@property (nonatomic, copy) NSString *zd3_eventTokenPurchaseARPU100;


@property (nonatomic, copy) NSString *zd3_eventTokenbegincdnTask;


@property (nonatomic, copy) NSString *zd3_eventTokenfinishcdnTask;

@property (nonatomic, copy) NSString *zd3_eventTokenbeginNoviceTask;
@end

NS_ASSUME_NONNULL_END
