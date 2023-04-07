
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3UserInfo_Entity;

@interface ZhenD3LocalData_Server : NSObject

+ (void)zd32_saveLoginedUserInfo:(ZhenD3UserInfo_Entity *)userInfo;

+ (NSArray *)zd32_loadAllSavedLoginedUser;

+ (BOOL)zd32_removeAllLoginedUserHistory;

+ (void)zd32_removeLoginedUserInfoFormHistory:(ZhenD3UserInfo_Entity *)userInfo;

@end

NS_ASSUME_NONNULL_END
