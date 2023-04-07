
#import "MBProgressHUD+GrossExtension.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_Theme_Utils.h"
#import "ZhenD3OpenAPI.h"
#import "YLAF_Toast_View.h"
#import "ZhenD3SDKGlobalInfo_Entity.h"

@implementation MBProgressHUD (MYMGExtension)

+ (MBProgressHUD *)zd32_ShowLoadingHUD
{
    UIView *view = [MYMGSDKGlobalInfo zd32_CurrentVC].view.window;
    if (!view || view == nil) {
        if (@available(iOS 13.0, *)) {
            view = [[UIApplication sharedApplication].windows lastObject];
        } else {
            view = [UIApplication sharedApplication].keyWindow;
            if (!view || view == nil) {
                view = [[UIApplication sharedApplication].windows lastObject];
            }
        }
    }
    if (!view || view == nil) {
        return nil;
    }
    
    UIImageView *loadingImageView = [[UIImageView alloc] initWithImage:[YLAF_Helper_Utils imageName:@"zdimageloading"]];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"%@",@"transform.rotation.z"]];
    rotationAnimation.toValue = @(-M_PI * 2);
    rotationAnimation.repeatCount = HUGE;
    rotationAnimation.duration = 2.0;
    [loadingImageView.layer addAnimation:rotationAnimation forKey:[NSString stringWithFormat:@"%@",@"KCBasicAnimation_Rotation_HUDLoadingView"]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = loadingImageView;
    hud.bezelView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (void)zd32_DismissLoadingHUD {
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    if (@available(iOS 13.0, *)) {
    } else {
        UIView *view0 = [UIApplication sharedApplication].keyWindow;
        [self hideHUDForView:view0 animated:YES];
    }
    UIView *view1 = [MYMGSDKGlobalInfo zd32_CurrentVC].view.window;
    [self hideHUDForView:view animated:YES];
    [self hideHUDForView:view1 animated:YES];
}
+ (void)zd32_showSuccess_Toast:(NSString *)message {
    [YLAF_Toast_View zd32_showSuccess:message];
}

+ (void)zd32_ShowWarning_Toast:(NSString *)message {
    [YLAF_Toast_View zd32_ShowWarning:message];
}

+ (void)zd32_showError_Toast:(NSString *)message {
    [YLAF_Toast_View zd32_showError:message];
}

@end
