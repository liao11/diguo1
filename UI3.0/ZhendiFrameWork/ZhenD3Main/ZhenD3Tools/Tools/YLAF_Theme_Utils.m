
#import "YLAF_Theme_Utils.h"

#define YLAF_HEXRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define YLAF_HEXRGB(rgbValue)    YLAF_HEXRGBA(rgbValue,1.0f)
#define YLAF_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define YLAF_RGB(r,g,b)          YLAF_RGBA(r,g,b,1.0f)

@implementation YLAF_Theme_Utils

+ (UIColor *)zd32_colorWithHexString:(NSString *)hexString {
    return [self zd32_colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)zd32_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([hexString length] < 6) return [UIColor clearColor];
    
    if ([hexString hasPrefix:@"0X"]) hexString = [hexString substringFromIndex:2];
    if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
    if ([hexString length] != 6) return [UIColor clearColor];
    
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) return [UIColor clearColor];
    
    return [UIColor colorWithRed:((float)((hexNumber & 0xFF0000) >> 16))/255.0
                           green:((float)((hexNumber & 0xFF00) >> 8))/255.0
                            blue:((float)(hexNumber & 0xFF))/255.0
                           alpha:alpha];
}


+ (UIColor *)khxl_color_BackgroundColor {
    return UIColor.whiteColor;
}
+ (UIColor *)khxl_color_MaskInputColor {
    return [UIColor whiteColor];
}
+ (UIColor *)khxl_color_LineColor {
    return YLAF_HEXRGB(0xE6E6E6);
}
+ (UIColor *)khxl_color_ButtonColor {
//
//    return YLAF_RGB(26, 190, 251);
    return [self zd32_colorWithHexString:@"#ff8765"];
}
+ (UIColor *)khxl_color_DisableColor {
    return YLAF_RGB(177, 188, 193);
}

+ (UIColor *)khxl_color_headBgColor {
    return YLAF_RGB(156, 255, 255);
}

+ (UIColor *)khxl_color_faceColor {
    return YLAF_RGB(60, 90, 153);
}

+ (UIColor *)khxl_color_yellowColor {
    return YLAF_RGB(255, 223, 97);
}

+ (UIColor *)khxl_color_MainColor {
    return YLAF_HEXRGB(0xffaa5b);
}
+ (UIColor *)khxl_color_SecondaryColor {
    return YLAF_HEXRGB(0x5fd083);
}
+ (UIColor *)khxl_color_OthersColor {
    return YLAF_HEXRGB(0xfc5371);
}
+ (UIColor *)khxl_color_FBBlueColor {
    return YLAF_HEXRGB(0x2684ff);
}
+ (UIColor *)khxl_color_brown{
    return [self zd32_colorWithHexString:@"#664630"];
}
+ (UIColor *)khxl_color_DarkColor {
    return [UIColor blackColor];
}
+ (UIColor *)khxl_color_DarkGrayColor {
    return YLAF_HEXRGB(0x191919);
}
+ (UIColor *)khxl_color_GrayColor {
    return YLAF_HEXRGB(0x62707b);
}
+ (UIColor *)khxl_color_LightGrayColor {
    return YLAF_HEXRGB(0xced1d5);
}
+ (UIColor *)khxl_color_LightColor {
    return [UIColor blackColor];
}

+ (UIColor *)khxl_textPlaceholderColor {
    return YLAF_RGB(173,173,173);
}

+ (UIColor *)khxl_goldColor {
    return YLAF_RGB(212,178,54);
}

+ (UIColor *)khxl_SmallGrayColor {
//    return [self zd32_colorWithHexString:@"#666666"];
    return [self zd32_colorWithHexString:@"#ff8765"];
}

+ (UIColor *)khxl_redColor {
    return [self zd32_colorWithHexString:@"#FE0000"];
}


+ (UIFont *)khxl_color_LargestFont {
    return [UIFont systemFontOfSize:18];
}
+ (UIFont *)khxl_color_LargeFont {
    return [UIFont systemFontOfSize:15];
}
+ (UIFont *)khxl_color_NormalFont {
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)khxl_color_SmallFont {
    return [UIFont systemFontOfSize:12];
}
+ (UIFont *)khxl_color_LeastFont {
    return [UIFont systemFontOfSize:9];
}

+ (UIFont *)khxl_FontSize13 {
    return [UIFont systemFontOfSize:13];
}

+ (UIFont *)khxl_FontSize35 {
    return [UIFont systemFontOfSize:35];
}

+ (UIFont *)khxl_FontSize17 {
    return [UIFont systemFontOfSize:17];
}

+ (UIFont *)khxl_FontSize10 {
    return [UIFont systemFontOfSize:10];
}



+ (CAGradientLayer *)khxl_color_GradientOrange:(CGRect)frame {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:239/255.0 blue:103/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:254/255.0 green:108/255.0 blue:69/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    return gl;
}

+ (CAGradientLayer *)khxl_color_GradientBlue:(CGRect)frame {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:0/255.0 blue:159/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:55/255.0 green:247/255.0 blue:232/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:94/255.0 green:159/255.0 blue:243/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.0),@(1.0)];
    return gl;
}

@end
