
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (MYMGExtension)

+ (NSString *)zd32_deviceNO;
+ (NSString *)blmg_getDeviceNo;
+ (NSString *)zd32_getCurrentDeviceModel;
+ (NSString *)zd32_getCurrentDeviceUUID;
+(NSString *)zd32_getCurrentDeviceModelProvider;
+ (NSString *)zd32_getCurrentDeviceNetworkingStates;
+ (void)setDeviceVibrate;
@property (nonatomic, readonly) int64_t diskSpace;
@property (nonatomic, readonly) int64_t diskSpaceFree;
@property (nonatomic, readonly) int64_t diskSpaceUsed;
+ (NSString *)gainIDFA;
+ (NSString *)gainAppVersion;
- (NSString *)getIPAddress:(BOOL)preferIPv4;
- (NSDictionary *)getIPAddresses;
- (NSDictionary *)getWWANAndWIFIAddresses;
+ (NSString *)obtainChannel;

+ (NSString *)obtainSubChannel;

@end

NS_ASSUME_NONNULL_END
