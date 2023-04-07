
#import "YLAF_Helper_Utils.h"
#import "ZhenD3SDKGlobalInfo_Entity.h"
#import "ZhenD3OpenAPI.h"
#import "GMGBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import "DES.h"
@implementation YLAF_Helper_Utils

+ (NSBundle *)zd32_resBundle:(Class)classtype {
    static NSBundle *framworkBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        framworkBundle = [NSBundle bundleForClass:classtype];
        if (framworkBundle) {
            NSString *resourceBundlePath = [framworkBundle pathForResource:[NSString stringWithFormat:@"%@",@"ZhenBundle"] ofType:[NSString stringWithFormat:@"%@",@"bundle"]];
            if (resourceBundlePath && [[NSFileManager defaultManager] fileExistsAtPath:resourceBundlePath]) {
                framworkBundle = [NSBundle bundleWithPath:resourceBundlePath];
            }
        }
    });
    return framworkBundle;
}
    
+ (UIImage*)imageName:(NSString*)name {
    
    
    if (name.length == 0) {
        return nil;
    }
    
    NSBundle *bundle = [self zd32_resBundle:[self class]];
    NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"%@.png.data",name] ofType:nil];
    NSData *dataImage = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    
    
    if (dataImage) {
        return [[UIImage imageWithData:dataImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return nil;
    
//    if (name.length == 0) {
//        return nil;
//    }
//    NSBundle *bundle = [self zd32_resBundle:[self class]];
//
//
//
//
//    NSString *path = [bundle pathForResource:name ofType:[NSString stringWithFormat:@"%@",@"png"]];
//
//
//
//    UIImage *imageData = [UIImage imageWithContentsOfFile:path];
//    if(!imageData){
//        imageData = [self zd32_encodeImageView:path];
//    }
//    return imageData;
    
    
}

+ (UIImage *)imageWithDataName:(NSString *)dataName
{
    if (dataName.length == 0) {
        return nil;
    }
    
    NSBundle *bundle = [self zd32_resBundle:[self class]];
    NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"%@.png.data",dataName] ofType:nil];
    NSData *dataImage = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (dataImage) {
        return [[UIImage imageWithData:dataImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return nil;
}

+ (UIImage *)zd32_encodeImageView:(NSString *)filePath {
    NSString *zd32_decodeKey = @"";
    NSData *dataEncoded = [NSData dataWithContentsOfFile:filePath];
    NSMutableString *dataString = [NSMutableString stringWithString:[[NSString alloc] initWithData:dataEncoded encoding:NSUTF8StringEncoding]];
    dataString = [NSMutableString stringWithString:[self zd32_decodeString:dataString zd32_key:zd32_decodeKey]]; 
    [dataString deleteCharactersInRange:NSMakeRange(zd32_decodeKey.length,  zd32_decodeKey.length)];
    NSData *dataDecode = [[NSData alloc] initWithBase64EncodedString:dataString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodeImage = [[UIImage imageWithData:dataDecode] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    return decodeImage;
}
+ (NSString *)zd32_normalDecodeString:(NSString *)zd32_encodeString {
    NSString *zd32_decodeKey = @"";
    NSString *zd32_string = [self zd32_decodeString:zd32_encodeString zd32_key:zd32_decodeKey];
    
    if ([zd32_string containsString:@"\\n"]) {
        zd32_string = [zd32_string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    }
    
    return zd32_string.length==0?zd32_encodeString:zd32_string;
}
+ (NSString*)zd32_decodeString:(NSString*)zd32_encodeString zd32_key:(NSString*)zd32_key {
    NSData* asse = [GMGBase64 decodeString:zd32_encodeString];
    const char*nRSchizogonic = [zd32_encodeString UTF8String];
    NSUInteger er =strlen(nRSchizogonic);
    size_t aNFlightful = er + kCCBlockSizeAES128;
    void *pseudoblepsia = malloc(aNFlightful);
    size_t floatman =0;
    Byte iv[] = {0x12,0x34,0x56,0x78,0x90,0xAB,0xCD,0xEF};
    CCCryptorStatus an =CCCrypt(kCCDecrypt,kCCAlgorithmDES,kCCOptionPKCS7Padding,[zd32_key UTF8String],kCCKeySizeDES,iv,[asse bytes],[asse length],pseudoblepsia,aNFlightful,&floatman);
    NSString* nondefense =nil;
    if(an ==kCCSuccess) {
        NSData* data = [NSData dataWithBytes:pseudoblepsia length:(NSUInteger)floatman];
        nondefense = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nondefense;
}

+ (NSString *)zd32_getLocalFromDocAndKey:(NSString *)key{
    NSDictionary *dict = [self zd32_getWordParam];
    NSDictionary *subDict = [dict objectForKey:[NSString stringWithFormat:@"%@",@"zd32_localStr"]];
    NSString *str = @"";
    str = [subDict objectForKey:[NSString stringWithFormat:@"%@",key]];
    return str;
}


+ (NSDictionary *)zd32_getWordParam{
    
    
    
    
    
    NSBundle *bundle = [self zd32_resBundle:[self class]];
    
    
    
    
    NSString *path = [bundle pathForResource:@"zd3" ofType:@".plist"];
//
//    NSString *path1 = [bundle pathForResource:[NSString stringWithFormat:@"UI3.plist.data"] ofType:nil];
//
//
//
//    NSDictionary *dictionary2 = [NSKeyedUnarchiver unarchiveObjectWithFile:path1];
    
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
        
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dictionary1 = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:data
                         mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                  format:&format
                                                    errorDescription:&errorDesc];
//    NSLog(@"%@", dictionary2);
    //////
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


@end
