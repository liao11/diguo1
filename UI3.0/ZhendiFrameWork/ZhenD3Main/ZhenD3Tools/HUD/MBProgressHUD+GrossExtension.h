
#import <MBProgressHUD/MBProgressHUD.h>
@interface MBProgressHUD (MYMGExtension)

+ (MBProgressHUD *)zd32_ShowLoadingHUD;
+ (void)zd32_DismissLoadingHUD;

+ (void)zd32_showSuccess_Toast:(NSString *)message;
+ (void)zd32_ShowWarning_Toast:(NSString *)message;
+ (void)zd32_showError_Toast:(NSString *)message;

@end

