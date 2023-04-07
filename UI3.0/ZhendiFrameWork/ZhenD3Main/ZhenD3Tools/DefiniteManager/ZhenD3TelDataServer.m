//
//  ZhenD3TelDataServer.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenD3TelDataServer.h"
#import "ZhenD3Keychain_Manager.h"
#import "ZhenD3UserInfo_Entity.h"
#import "NSString+GrossExtension.h"
#import "YLAF_Macro_Define.h"

@implementation ZhenD3TelDataServer

+ (NSString *)zd32_u_KeychainServiceKeyOfLoginedAccounts {
    return [NSString stringWithFormat:@"muugame.sdk2.telAccounts.%@", NSStringFromClass([ZhenD3UserInfo_Entity class])];
}

+ (void)zd32_saveLoginedUserInfo:(ZhenD3UserInfo_Entity *)userInfo {
    
    if (userInfo.userID && ![userInfo.userID isEmpty]) {
        NSString *zd32_KeychainServiceKey = [self zd32_u_KeychainServiceKeyOfLoginedAccounts];
        NSArray *savedUsers = [ZhenD3Keychain_Manager zd32_keychainObjectForKey:zd32_KeychainServiceKey];
        
        if (![savedUsers isKindOfClass:[NSArray class]]) {
            [self zd32_removeAllLoginedUserHistory];
            savedUsers = nil;
        }
        
        NSMutableArray *newList;
        if (savedUsers && savedUsers.count > 0) {
            newList = [savedUsers mutableCopy];
            for (ZhenD3UserInfo_Entity *user in savedUsers) {
                if ([user.userID isEqualToString:userInfo.userID]) {
                    userInfo.loginCount = user.loginCount;
                    [newList removeObject:user];
                    break;
                }
            }
        } else {
            newList = [[NSMutableArray alloc] init];
        }
        
        userInfo.loginCount += 1;
        [newList addObject:userInfo];
        
        [ZhenD3Keychain_Manager zd32_keychainSaveObject:newList forKey:zd32_KeychainServiceKey];
    }
}

+ (NSArray *)zd32_loadAllSavedLoginedUser {
    return [ZhenD3Keychain_Manager zd32_keychainObjectForKey:[self zd32_u_KeychainServiceKeyOfLoginedAccounts]];
}

+ (BOOL)zd32_removeAllLoginedUserHistory {
    return [ZhenD3Keychain_Manager zd32_keychainRemoveObjectForKey:[self zd32_u_KeychainServiceKeyOfLoginedAccounts]];
}

+ (void)zd32_removeLoginedUserInfoFormHistory:(ZhenD3UserInfo_Entity *)userInfo {
    if (userInfo.userID && ![userInfo.userID isEmpty]) {
        NSString *zd32_KeychainServiceKey = [self zd32_u_KeychainServiceKeyOfLoginedAccounts];
        NSArray *savedUsers = [ZhenD3Keychain_Manager zd32_keychainObjectForKey:zd32_KeychainServiceKey];
        if (savedUsers && savedUsers.count > 0) {
            NSMutableArray *newList = [savedUsers mutableCopy];
            
            for (ZhenD3UserInfo_Entity *user in savedUsers) {
                if ([user.userID isEqualToString:userInfo.userID]) {
                    [newList removeObject:user];
                }
            }
            
            [ZhenD3Keychain_Manager zd32_keychainSaveObject:newList forKey:zd32_KeychainServiceKey];
        }
    }
}

@end
