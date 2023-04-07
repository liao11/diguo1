
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenD3Keychain_Manager : NSObject
+ (BOOL)zd32_keychainSaveObject:(id)value forService:(NSString *)service andAccount:(NSString *)account;

+ (id)zd32_keychainObjectForService:(NSString *)service andAccount:(NSString *)account;

+ (BOOL)zd32_keyChainUpdateObject:(id)data forService:(NSString *)service andAccount:(NSString *)account;

+ (BOOL)zd32_keychainRemoveObjectForService:(NSString *)service andAccount:(NSString *)account;

+ (BOOL)zd32_keychainSaveObject:(id)objectData forKey:(NSString *)key;

+ (id)zd32_keychainObjectForKey:(NSString *)key;

+ (BOOL)zd32_keychainRemoveObjectForKey:(NSString *)key;

+ (BOOL)zd32_keyChainUpdateObject:(id)objectData forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
