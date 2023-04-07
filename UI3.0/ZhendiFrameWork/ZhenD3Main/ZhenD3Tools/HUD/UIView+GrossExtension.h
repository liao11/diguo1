
#import <UIKit/UIKit.h>
#import "YLAF_Macro_Define.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MYMGExtension)

@property (nonatomic) CGFloat blmg_left;
@property (nonatomic) CGFloat blmg_top;
@property (nonatomic) CGFloat blmg_right;
@property (nonatomic) CGFloat blmg_bottom;
@property (nonatomic) CGFloat blmg_width;
@property (nonatomic) CGFloat blmg_height;
@property (nonatomic) CGPoint blmg_origin;
@property (nonatomic) CGSize  blmg_size;
@property (nonatomic) CGFloat blmg_centerX;
@property (nonatomic) CGFloat blmg_centerY;

- (void)blmg_removeAllSubviews;
- (UIViewController *)blmg_viewController;

- (void)blmg_moveBy:(CGPoint)delta;
- (void)blmg_scaleBy:(CGFloat)scaleFactor;
- (void)blmg_fitInSize:(CGSize)aSize;

- (void)blmg_drawCircle;
- (void)blmg_drawCircleRadius:(CGFloat)cornerRadius;
- (void)blmg_drawCircleCornerRadii:(CGSize)cornerRadii byRoundingCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
