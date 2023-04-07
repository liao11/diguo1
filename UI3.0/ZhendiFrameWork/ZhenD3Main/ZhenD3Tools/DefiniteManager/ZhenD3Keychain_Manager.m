
#import "ZhenD3Keychain_Manager.h"
#import <Security/Security.h>

@implementation ZhenD3Keychain_Manager

+ (NSMutableDictionary *)zd32_u_getKeychainQuery:(NSString *)service andAccount:(NSString *)account {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            account, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (BOOL)zd32_keychainSaveObject:(id)objectData forService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return NO;
    }
    NSMutableDictionary *keychainQuery = [self zd32_u_getKeychainQuery:service andAccount:account];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:objectData] forKey:(id)kSecValueData];
    OSStatus saveState = SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    return (saveState == errSecSuccess);
}

+ (id)zd32_keychainObjectForService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return nil;
    }
    NSMutableDictionary *keychainQuery = [self zd32_u_getKeychainQuery:service andAccount:account];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    id ret = nil;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == errSecSuccess) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (BOOL)zd32_keyChainUpdateObject:(id)objectData forService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return NO;
    }
    NSMutableDictionary *keychainQuery = [self zd32_u_getKeychainQuery:service andAccount:account];
    
    NSMutableDictionary *updataMutableDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [updataMutableDictionary setObject:[NSKeyedArchiver archivedDataWithRootObject:objectData] forKey:(id)kSecValueData];
    OSStatus updataStatus = SecItemUpdate((CFDictionaryRef)keychainQuery, (CFDictionaryRef)updataMutableDictionary);
    
    return (updataStatus == errSecSuccess);
}

+ (BOOL)zd32_keychainRemoveObjectForService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return NO;
    }
    NSMutableDictionary *keychainQuery = [self zd32_u_getKeychainQuery:service andAccount:account];
    OSStatus deleteState = SecItemDelete((CFDictionaryRef)keychainQuery);
    return (deleteState == errSecSuccess);
}

+ (BOOL)zd32_keychainSaveObject:(id)objectData forKey:(NSString *)key {
    return [self zd32_keychainSaveObject:objectData forService:key andAccount:key];
}

+ (id)zd32_keychainObjectForKey:(NSString *)key {
    return [self zd32_keychainObjectForService:key andAccount:key];
}

+ (BOOL)zd32_keyChainUpdateObject:(id)objectData forKey:(NSString *)key {
    return [self zd32_keyChainUpdateObject:objectData forService:key andAccount:key];
}

+ (BOOL)zd32_keychainRemoveObjectForKey:(NSString *)key {
    return [self zd32_keychainRemoveObjectForService:key andAccount:key];
}

@end
