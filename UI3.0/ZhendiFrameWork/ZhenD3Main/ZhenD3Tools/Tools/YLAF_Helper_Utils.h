
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MUUQYLocalizedString(key)  [YLAF_Helper_Utils zd32_getLocalFromDocAndKey:key]

NS_ASSUME_NONNULL_BEGIN

@interface YLAF_Helper_Utils : NSObject

+ (NSBundle *)zd32_resBundle:(Class)classtype;
    
+ (UIImage *)imageName:(NSString *)name;

+ (UIImage *)imageWithDataName:(NSString *)dataName;

+ (NSString *)zd32_getLocalFromDocAndKey:(NSString *)key;

+ (UIImage *)zd32_encodeImageView:(NSString *)filePath;

+ (NSString *)zd32_normalDecodeString:(NSString *)zd32_encodeString;

+ (NSString *)zd32_decodeString:(NSString*)zd32_encodeString zd32_key:(NSString*)zd32_key;

+ (NSDictionary *)zd32_getWordParam;


@end

NS_ASSUME_NONNULL_END
