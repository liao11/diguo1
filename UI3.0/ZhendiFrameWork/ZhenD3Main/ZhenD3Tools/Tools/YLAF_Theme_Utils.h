
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLAF_Theme_Utils : NSObject

+ (UIColor *)zd32_colorWithHexString:(NSString *)hexString;
+ (UIColor *)zd32_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)khxl_color_BackgroundColor;
+ (UIColor *)khxl_color_MaskInputColor;
+ (UIColor *)khxl_color_LineColor;

+ (UIColor *)khxl_color_ButtonColor;
+ (UIColor *)khxl_color_DisableColor;
+ (UIColor *)khxl_color_headBgColor;
+ (UIColor *)khxl_color_MainColor;
+ (UIColor *)khxl_color_SecondaryColor;
+ (UIColor *)khxl_color_OthersColor;
+ (UIColor *)khxl_color_FBBlueColor;
+ (UIColor *)khxl_color_brown;

+ (UIColor *)khxl_color_DarkColor;
+ (UIColor *)khxl_color_DarkGrayColor;
+ (UIColor *)khxl_color_GrayColor;
+ (UIColor *)khxl_color_LightGrayColor;
+ (UIColor *)khxl_color_LightColor;

+ (UIFont *)khxl_color_LargestFont;
+ (UIFont *)khxl_color_LargeFont;
+ (UIFont *)khxl_color_NormalFont;
+ (UIFont *)khxl_color_SmallFont;
+ (UIFont *)khxl_color_LeastFont;

+ (UIColor *)khxl_textPlaceholderColor;
+ (UIColor *)khxl_goldColor;
+ (UIColor *)khxl_SmallGrayColor;
+ (UIColor *)khxl_redColor;
+ (UIColor *)khxl_color_yellowColor;
+ (UIColor *)khxl_color_faceColor;

+ (UIFont *)khxl_FontSize13;
+ (UIFont *)khxl_FontSize35;
+ (UIFont *)khxl_FontSize17;
+ (UIFont *)khxl_FontSize10;
@end

NS_ASSUME_NONNULL_END
