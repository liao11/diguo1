
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YLAF_ResponseCode) {
    
    YLAF_ResponseCodeUnknown = 110,              
    YLAF_ResponseCodeNetworkError = 111,         
    YLAF_ResponseCodeServerError = 112,          
    YLAF_ResponseCodeSuccess = 200,              
    YLAF_ResponseCodeParameterError = 201,       
    YLAF_ResponseCodeIllegalError = 202,         
    YLAF_ResponseCodeVerifyError = 203,          
    YLAF_ResponseCodeSystemError = 204,          
    YLAF_ResponseCodeTokenError = 205,           
    YLAF_ResponseCodeTokenFailureError = 206,    
    YLAF_ResponseCodeHandleError = 207,          
    YLAF_ResponseCodeReLoginError = 208,         
    
    
    YLAF_ResponseCodeAccountFormatError = 300,           
    YLAF_ResponseCodeAccountExisting = 301,              
    YLAF_ResponseCodeForbiddenPhoneForNor = 302,         
    YLAF_ResponseCodeAccountLimit = 303,                 
    YLAF_ResponseCodeQuickRegistrationError = 304,       
    YLAF_ResponseCodeCellPhoneNumberError = 305,         
    YLAF_ResponseCodeSendVerificationCodeError = 306,    
    YLAF_ResponseCodeAccountInexistenceError = 307,      
    YLAF_ResponseCodeAccountAbnormityError = 308,        
    YLAF_ResponseCodeVerificationCodeError = 309,        
    YLAF_ResponseCodeSendInitailPwdError = 310,          
    YLAF_ResponseCodeAccountLocked = 311,                
    YLAF_ResponseCodePwdError = 312,                     
    YLAF_ResponseCodeVerificationCodeFailure = 313,      
    YLAF_ResponseCodeVisitorsAccountRegisteredFTD = 314, 
    YLAF_ResponseCodeUnboundMainbox = 320,               
    
    
    YLAF_ResponseCodeGenerateOrderError = 400,       
    YLAF_ResponseCodeOrderInexistenceError = 401,    
    YLAF_ResponseCodeOrderMoneyError = 402,          
    
    
    YLAF_ResponseCodeBindedAccount = 500,            
    YLAF_ResponseCodeGainVerificationCode = 501,     
    YLAF_ResponseCodeBindedAccountFailure = 502,     
    YLAF_ResponseCodeAlterPwdfailure = 503,          
    
    
    YLAF_ResponseCodeApplePayFailureError = 600,             
    YLAF_ResponseCodeApplePayCancel = 601,                   
    YLAF_ResponseCodeApplePayNoGoods = 602,                  
    YLAF_ResponseCodeApplePayInvalidIProduceId = 603,        
    YLAF_ResponseCodeApplePayRestored = 604,                 
    YLAF_ResponseCodeApplePayCannotMakePayments = 605,       
    YLAF_ResponseCodeAppleTryAgainLater = 606,               
    YLAF_ResponseCodeApplePayRequestFailure = 607,           
    YLAF_ResponseCodeApplePayReceiptInvalid = 608,           
    YLAF_ResponseCodeGetPriceOfProductsFailure = 609,
    YLAF_ResponseCodeFacebookLoginFailure = 700,            
    YLAF_ResponseCodeFacebookLoginCancel = 701,             
};

typedef NS_ENUM(NSInteger, YLAF_ResponseType) {
    YLAF_ResponseTypeUnknown = 1200,
    YLAF_ResponseTypeSDKInital = 1201,
    YLAF_ResponseTypeRegister = 1202,
    YLAF_ResponseTypeLoginOut = 1203,
    YLAF_ResponseTypeEnterGame = 1204,
    YLAF_ResponseTypeApplePay = 1205,
    YLAF_ResponseTypeNormalLogin = 1206,
    YLAF_ResponseTypeFacebookLogin = 1207,
    YLAF_ResponseTypeGuestLogin = 1208,
    YLAF_ResponseTypeAppleLogin = 1209,
    YLAF_ResponseTypeTelLogin = 1210,
    YLAF_ResponseTypeDelete = 1211,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3ResponseObject_Entity : NSObject

@property (nonatomic, assign) YLAF_ResponseCode zd32_responseCode;
@property (nonatomic, assign) YLAF_ResponseType zd32_responseType;
@property (nonatomic, strong, nullable) NSDictionary *zd32_responeResult;
@property (nonatomic, copy, nullable) NSString *zd32_responeMsg;
@end

NS_ASSUME_NONNULL_END
