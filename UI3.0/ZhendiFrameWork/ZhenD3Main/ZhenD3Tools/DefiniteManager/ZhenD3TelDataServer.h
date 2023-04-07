//
//  ZhenD3TelDataServer.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZhenD3UserInfo_Entity;

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3TelDataServer : NSObject

+ (void)zd32_saveLoginedUserInfo:(ZhenD3UserInfo_Entity *)userInfo;

+ (NSArray *)zd32_loadAllSavedLoginedUser;

+ (BOOL)zd32_removeAllLoginedUserHistory;

+ (void)zd32_removeLoginedUserInfoFormHistory:(ZhenD3UserInfo_Entity *)userInfo;

@end

NS_ASSUME_NONNULL_END
