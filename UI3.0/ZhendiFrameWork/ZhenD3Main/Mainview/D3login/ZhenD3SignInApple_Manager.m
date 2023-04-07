
#import "ZhenD3SignInApple_Manager.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "ZhenD3Keychain_Manager.h"
#import "YLAF_Macro_Define.h"
#import "ZhenD3Login_Server.h"
NSString *const cKeychainServiceForAppleCurrentUserIdentifier = @"www.xmmy.com.AppleCurrentUserIdentifier";

@interface ZhenD3SignInApple_Manager () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, weak) id<YLAH_SignInApple_ManagerDelegate> delegate;
@end

@implementation ZhenD3SignInApple_Manager

+ (instancetype)zd31_SharedManager {
    static ZhenD3SignInApple_Manager *signInAppleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signInAppleManager = [[ZhenD3SignInApple_Manager alloc] init];
    });
    return signInAppleManager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self zd31_observeAppleSignInState];
    }
    return self;
}

- (void)zd31_observeAppleSignInState {
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(zd31_handleSignInWithAppleStateChanged:)
                                                     name:ASAuthorizationAppleIDProviderCredentialRevokedNotification
                                                   object:nil];
    }
}

- (void)zd31_handleSignInWithAppleStateChanged:(NSNotification *)notification {
    
    MYMGLog(@"苹果登录状态监听:name = %@, userinfo = %@", notification.name, notification.userInfo);
}

- (NSString *)zd31_currentAppleUserIdentifier {
    return [ZhenD3Keychain_Manager zd32_keychainObjectForKey:cKeychainServiceForAppleCurrentUserIdentifier];
}

- (void)zd31_CheckCredentialState {
    if (@available(iOS 13.0, *)) {
        NSString *userIdentifier = [[ZhenD3SignInApple_Manager zd31_SharedManager] zd31_currentAppleUserIdentifier];
        MYMGLog(@"苹果登录 userIdentifier=%@", userIdentifier);
        if (userIdentifier) {
            ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
            [appleIDProvider getCredentialStateForUserID:userIdentifier
                                              completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error)
            {
                switch (credentialState) {
                    case ASAuthorizationAppleIDProviderCredentialAuthorized:
                        MYMGLog(@"苹果登录----授权状态有效");
                        break;
                    case ASAuthorizationAppleIDProviderCredentialRevoked:
                        MYMGLog(@"苹果登录----上次使用苹果账号登录的凭据已被移除，需解除绑定并重新引导用户使用苹果登录");
                        break;
                    case ASAuthorizationAppleIDProviderCredentialNotFound:
                        MYMGLog(@"苹果登录----未登录授权，直接弹出登录页面，引导用户登录");
                        break;
                    case ASAuthorizationAppleIDProviderCredentialTransferred:
                        MYMGLog(@"苹果登录----ASAuthorizationAppleIDProviderCredentialTransferred凭证已转移");
                        break;
                }
            }];
        }
    }
}

- (void)zd31_HandleAuthorizationAppleIDButtonPress:(id <YLAH_SignInApple_ManagerDelegate>)delegate {
    if (@available(iOS 13.0, *)) {
        _delegate = delegate;
        
        ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *request = [provider createRequest];
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        
        authorizationController.delegate = self;
        authorizationController.presentationContextProvider = self;
        [authorizationController performRequests];
    }
}

- (void)zd31_PerfomExistingAccountSetupFlows:(id <YLAH_SignInApple_ManagerDelegate>)delegate {
    if (@available(iOS 13.0, *)) {
        _delegate = delegate;
        
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        
        ASAuthorizationPasswordProvider *passwordProvider = [[ASAuthorizationPasswordProvider alloc] init];
        ASAuthorizationPasswordRequest *passwordRequest = [passwordProvider createRequest];
        
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest, passwordRequest]];
        authorizationController.delegate = self;
        authorizationController.presentationContextProvider = self;
        [authorizationController performRequests];
    }
}


- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return [UIApplication sharedApplication].windows.lastObject;
}


- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        ASAuthorizationAppleIDCredential * credential = authorization.credential;
        NSString * userID = credential.user;
        
        
        NSPersonNameComponents *fullName = credential.fullName;
        NSString * email = credential.email;
        
        
        
        NSString * authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        
        NSString * identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        MYMGLog(@"\n苹果登录授权完成\n userID: %@\n fullName: %@\n email: %@\n authorizationCode: %@\n identityToken: %@\n realUserStatus: %@\n ", userID, fullName, email , authorizationCode, identityToken, @(realUserStatus));

        [ZhenD3Keychain_Manager zd32_keychainSaveObject:userID forKey:cKeychainServiceForAppleCurrentUserIdentifier];
        
        [[ZhenD3Login_Server new] lhxy_VerifySignInWithApple:userID email:email authorizationCode:authorizationCode identityToken:identityToken responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(zd31_DidSigninWithApple:)]) {
                [self->_delegate zd31_DidSigninWithApple:result];
            }
        }];
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        
        
        
        ASPasswordCredential *passwordCredential = authorization.credential;
        
        NSString *user = passwordCredential.user;
        
        NSString *password = passwordCredential.password;
            
        MYMGLog(@"\n用户登录使用现有的密码凭证\n user: %@\n password: %@\n authorization.credential: %@\n", user, password, authorization.credential);
        
        [[ZhenD3Login_Server new] lhxy_VerifySignInWithApple:user email:@"" authorizationCode:@"" identityToken:@"" responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(zd31_DidSigninWithApple:)]) {
                [self->_delegate zd31_DidSigninWithApple:result];
            }
        }];
    } else {
        MYMGLog(@"授权信息均不符");
        ZhenD3ResponseObject_Entity *response = [[ZhenD3ResponseObject_Entity alloc] init];
        response.zd32_responseType = YLAF_ResponseTypeAppleLogin;
        response.zd32_responeMsg = MUUQYLocalizedString(@"MUUQYKey_AuthorizeUnknownError_Alert_Text");
        response.zd32_responseCode = YLAF_ResponseCodeVerifyError;
        YLAF_RunInMainQueue(^{
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(zd31_DidSigninWithApple:)]) {
                [self->_delegate zd31_DidSigninWithApple:response];
            }
            
            if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
                [YLMXGSDKAPI.delegate zd3_loginFinished:response];
            }
        });
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = MUUQYLocalizedString(@"MUUQYKey_AuthorizeCanceled_Alert_Text");
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = MUUQYLocalizedString(@"MUUQYKey_AuthorizeFailed_Alert_Text");
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = MUUQYLocalizedString(@"MUUQYKey_AuthorizInvalidResponse_Alert_Text");
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = MUUQYLocalizedString(@"MUUQYKey_AuthorizeNotHandled_Alert_Text");
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = MUUQYLocalizedString(@"MUUQYKey_AuthorizeUnknownError_Alert_Text");
            break;
        default:
            break;
    }
    MYMGLog(@"苹果登录授权失败 controller=%@ \n error：%@ \n errorMsg = %@", controller, error, errorMsg);
    ZhenD3ResponseObject_Entity *response = [[ZhenD3ResponseObject_Entity alloc] init];
    response.zd32_responseType = YLAF_ResponseTypeAppleLogin;
    response.zd32_responeMsg = errorMsg;
    response.zd32_responseCode = YLAF_ResponseCodeVerifyError;
    YLAF_RunInMainQueue(^{
        if (self->_delegate && [self->_delegate respondsToSelector:@selector(zd31_DidSigninWithApple:)]) {
            [self->_delegate zd31_DidSigninWithApple:response];
        }
        
        if (YLMXGSDKAPI.delegate && [YLMXGSDKAPI.delegate respondsToSelector:@selector(zd3_loginFinished:)]) {
            [YLMXGSDKAPI.delegate zd3_loginFinished:response];
        }
    });
}

@end
