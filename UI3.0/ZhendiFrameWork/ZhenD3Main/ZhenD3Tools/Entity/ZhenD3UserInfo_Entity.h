
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, YLAF_AccountType) {
    YLAF_AccountTypeMuu = 1, //邮箱
    YLAF_AccountTypeGuest = 2,
    YLAF_AccountTypeFB = 3,
    YLAF_AccountTypeApple = 4,
    YLAF_AccountTypeTel = 6,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3UserInfo_Entity : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *autoToken;
@property (nonatomic, copy) NSString *expireTime;
@property (nonatomic, assign) BOOL isBindEmail;
@property (nonatomic, assign) BOOL isBindMobile;
@property (nonatomic, assign) BOOL isBind;
@property (nonatomic, assign) BOOL isReg;

@property (nonatomic, copy) NSString *fbUserName;

@property (nonatomic, assign) NSInteger loginCount;
@property (nonatomic, assign) YLAF_AccountType accountType;

@end

NS_ASSUME_NONNULL_END
