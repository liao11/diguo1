
#import "UIView+GrossExtension.h"

@implementation UIView (MYMGExtension)

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

- (CGFloat)blmg_left {
    return self.frame.origin.x;
}

- (void)setBlmg_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)blmg_top {
    return self.frame.origin.y;
}

- (void)setBlmg_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)blmg_right {
    return self.blmg_left + self.blmg_width;
}

- (void)setBlmg_right:(CGFloat)right {
    if(right == self.blmg_right){
        return;
    }
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)blmg_bottom {
    return self.blmg_top + self.blmg_height;
}

- (void)setBlmg_bottom:(CGFloat)bottom {
    if(bottom == self.blmg_bottom){
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)blmg_centerX {
    return self.center.x;
}

- (void)setBlmg_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)blmg_centerY {
    return self.center.y;
}

- (void)setBlmg_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)blmg_width {
    return self.frame.size.width;
}

- (void)setBlmg_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)blmg_height {
    return self.frame.size.height;
}

- (void)setBlmg_height:(CGFloat)height {
    if(height == self.blmg_height){
        return;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)blmg_origin {
    return self.frame.origin;
}

- (void)setBlmg_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)blmg_size {
    return self.frame.size;
}

- (void)setBlmg_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)blmg_removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController*)blmg_viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

- (void)blmg_moveBy:(CGPoint)delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

- (void)blmg_scaleBy:(CGFloat)scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

- (void)blmg_fitInSize:(CGSize)aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (void)blmg_drawCircle {
    [self blmg_drawCircleCornerRadii:CGSizeZero byRoundingCorners:UIRectCornerAllCorners];
}

- (void)blmg_drawCircleRadius:(CGFloat)cornerRadius {
    [self blmg_drawCircleCornerRadii:CGSizeMake(cornerRadius, cornerRadius) byRoundingCorners:UIRectCornerAllCorners];
}

- (void)blmg_drawCircleRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners {
    [self blmg_drawCircleCornerRadii:CGSizeMake(cornerRadius, cornerRadius) byRoundingCorners:corners];
}

- (void)blmg_drawCircleCornerRadii:(CGSize)cornerRadii byRoundingCorners:(UIRectCorner)corners {
    if (CGSizeEqualToSize(cornerRadii,CGSizeZero)) {
        cornerRadii = self.bounds.size;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
