
#import "UIImage+GrossExtension.h"

@implementation UIImage (MYMGExtension)

+ (UIImage *)zd32_captureImageFromView:(UIView *)view {
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext() ;
    
    return newImage;
}

@end
