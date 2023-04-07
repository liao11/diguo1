
#import <Foundation/Foundation.h>
#import "ZhenD3ResponseObject_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YLAH_SignInApple_ManagerDelegate <NSObject>

- (void)zd31_DidSigninWithApple:(ZhenD3ResponseObject_Entity *)response;
@end

@interface ZhenD3SignInApple_Manager : NSObject

+ (instancetype)zd31_SharedManager;

- (void)zd31_CheckCredentialState;

- (void)zd31_HandleAuthorizationAppleIDButtonPress:(id <YLAH_SignInApple_ManagerDelegate>)delegate;
- (void)zd31_PerfomExistingAccountSetupFlows:(id <YLAH_SignInApple_ManagerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
