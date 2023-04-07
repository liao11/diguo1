
#import "YLAF_Toast_View.h"
#import "UIView+GrossExtension.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_WeakProxy_Utils.h"

@interface YLAF_Toast_View ()

@property (nonatomic, strong) UIImageView *zd32_ToastImageView;
@property (nonatomic, strong) UILabel *zd32_ToastLab;
@end

@implementation YLAF_Toast_View

+ (void)zd32_showSuccess:(NSString *)message {
     [self zd32_u_showToast:[NSString stringWithFormat:@"%@",@"zdimagesuccess"] message:message];
}

+ (void)zd32_ShowWarning:(NSString *)message {
     [self zd32_u_showToast:[NSString stringWithFormat:@"%@",@"zdimagewarn"] message:message];
}

+ (void)zd32_showError:(NSString *)message {
    [self zd32_u_showToast:[NSString stringWithFormat:@"%@",@"zdimageerror"] message:message];
}

+ (void)zd32_u_showToast:(NSString *)icon message:(NSString *)message {
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    YLAF_Toast_View *toastView = [[YLAF_Toast_View alloc] init];
    toastView.zd32_ToastImageView.image = [YLAF_Helper_Utils imageName:icon];
    toastView.zd32_ToastLab.text = message;
    [topView addSubview:toastView];
    [topView bringSubviewToFront:toastView];
    [toastView zd32_u_ShowToast];
}

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zd32_SetupDefaultViews];
    }
    return self;
}

- (void)zd32_SetupDefaultViews {
    CGFloat margin = 10.0f;
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width - margin*2, 500);
    self.frame = CGRectMake(margin, [[UIApplication sharedApplication] statusBarFrame].size.height, width, 30 + margin*2);
    self.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    
    
    self.zd32_ToastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, (self.blmg_height-20.0)/2, 20, 20)];
    [self addSubview:self.zd32_ToastImageView];
    
    self.zd32_ToastLab = [[UILabel alloc] initWithFrame:CGRectMake(self.zd32_ToastImageView.blmg_right+margin, margin, self.blmg_width- margin*2 - self.zd32_ToastImageView.blmg_right, 30)];
    self.zd32_ToastLab.font = [YLAF_Theme_Utils khxl_color_SmallFont];
    self.zd32_ToastLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    self.zd32_ToastLab.numberOfLines = 0;
    [self addSubview:self.zd32_ToastLab];
    self.blmg_bottom = 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.blmg_width = MIN([UIScreen mainScreen].bounds.size.width - 20, 500);
    self.blmg_centerX = self.superview.blmg_width / 2;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self zd32_u_DismissToast];
}


- (void)zd32_u_ShowToast {
    self.blmg_bottom = 0;
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
        safeAreaInsets = window.safeAreaInsets;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.blmg_top = MAX(safeAreaInsets.top, 20);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(zd32_u_DismissToast) withObject:nil afterDelay:2.5];
    }];
}

- (void)zd32_u_DismissToast {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
