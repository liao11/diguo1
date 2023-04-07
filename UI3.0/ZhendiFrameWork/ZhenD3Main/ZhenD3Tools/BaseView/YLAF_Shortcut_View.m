
#import "YLAF_Shortcut_View.h"
#import "ZhenD3SDKMainView_Controller.h"
#import "UIView+GrossExtension.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_Helper_Utils.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3RemoteData_Server.h"
#import "UIViewController+CWLateralSlide.h"
#import "YLAF_leftShowVCViewController.h"
@interface YLAF_Shortcut_View ()

@property (nonatomic, strong) UIImageView *zd32_ImageView;
@property (nonatomic, strong) UIView *zd32_BtnsBgView;
@property (nonatomic, assign) CGFloat zd32_BtnsBgViewWidth;
@property (nonatomic, strong) UILabel *zd31_hintLab;
@end

@implementation YLAF_Shortcut_View

+ (instancetype)zd32_SharedView {
    static YLAF_Shortcut_View *sharedShortcutView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedShortcutView = [[YLAF_Shortcut_View alloc] init];
    });
    return sharedShortcutView;
}

+ (void)zd32_ShowShort {
    UIView *topView = [MYMGSDKGlobalInfo zd32_CurrentVC].view.window;
    
    YLAF_Shortcut_View *shortcutView = [YLAF_Shortcut_View zd32_SharedView];
    if ([topView.subviews containsObject:shortcutView] == NO) {
        [shortcutView removeFromSuperview];
        [topView addSubview:shortcutView];
    }
    [topView bringSubviewToFront:shortcutView];
    [shortcutView zd32_u_ReLayoutSubViews];
    
    if (MYMGSDKGlobalInfo.zd32_sdkFlag & YLAF_SDKFlagShortcut) {
        shortcutView.hidden = NO;
    } else {
        shortcutView.hidden = YES;
    }
}

+ (void)zd32_DismissShort {
    [[YLAF_Shortcut_View zd32_SharedView] removeFromSuperview];
}

+ (void)zd32_ResetLocalizedString {
    [[YLAF_Shortcut_View zd32_SharedView] zd32_u_ResetLocalizedString];
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

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.blmg_bottom >= self.superview.blmg_height) {
        self.blmg_bottom = self.superview.blmg_height;
    }
    if (self.blmg_right >= self.superview.blmg_width) {
        self.blmg_right = self.superview.blmg_width;
    }
}

- (void)zd32_u_ResetLocalizedString {
    UIButton *accBtn = [_zd32_BtnsBgView viewWithTag:101];
    [accBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_Account_Short_Text") forState:UIControlStateNormal];
    
    UIButton *cuservicBtn = [_zd32_BtnsBgView viewWithTag:102];
    [cuservicBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_CustomerService_Text") forState:UIControlStateNormal];
    
    UIButton *ireBtn = [_zd32_BtnsBgView viewWithTag:103];
    [ireBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_QuickCheckPurchase_Text") forState:UIControlStateNormal];
}

- (void)zd32_SetupDefaultViews {
    self.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + 20, 40, 40);
    
    self.zd32_BtnsBgViewWidth = 150;
    
    [self addSubview:self.zd32_BtnsBgView];
    [self zd32_u_HidenBtns:NO completion:nil];
    [self performSelector:@selector(zd32_u_ResignActive) withObject:nil afterDelay:2.5];
    
    self.zd32_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.zd32_ImageView.image = [YLAF_Helper_Utils imageName:@"zdimagefloat"];
    self.zd32_ImageView.backgroundColor = [UIColor whiteColor];
    self.zd32_ImageView.layer.cornerRadius = 20.0;
    self.zd32_ImageView.layer.borderColor = [YLAF_Theme_Utils khxl_color_FBBlueColor].CGColor;
    self.zd32_ImageView.layer.borderWidth = 0.5;
    self.zd32_ImageView.layer.masksToBounds = YES;
    [self addSubview:self.zd32_ImageView];
    
    self.zd31_hintLab = [[UILabel alloc] initWithFrame:CGRectMake(self.zd32_ImageView.blmg_right, 0, 120, 40)];
    self.zd31_hintLab.textAlignment = NSTextAlignmentLeft;
    self.zd31_hintLab.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
    self.zd31_hintLab.layer.cornerRadius = 20;
    self.zd31_hintLab.clipsToBounds = true;
    self.zd31_hintLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    self.zd31_hintLab.text = [NSString stringWithFormat:@"  %@",MYMGSDKGlobalInfo.hint?:@""];
    if (MYMGSDKGlobalInfo.hint.length>0) {
        self.zd31_hintLab.hidden=YES;
    }else{
        self.zd31_hintLab.hidden=YES;
    }
    self.zd31_hintLab.font = [YLAF_Theme_Utils khxl_color_LargeFont];
    [self addSubview:self.zd31_hintLab];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zd32_HandleTapAction:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(zd32_HandlePanAction:)];
    [self addGestureRecognizer:panGesture];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(zd32_HandleLongPressAction:)];
    [self addGestureRecognizer:longPress];
}


- (UIView *)zd32_BtnsBgView {
    if (!_zd32_BtnsBgView) {
        _zd32_BtnsBgView = [[UIView alloc] initWithFrame:CGRectMake(6, 1.5, self.zd32_BtnsBgViewWidth, 37)];
        _zd32_BtnsBgView.backgroundColor = [UIColor whiteColor];
        _zd32_BtnsBgView.layer.borderColor = [YLAF_Theme_Utils khxl_color_FBBlueColor].CGColor;
        _zd32_BtnsBgView.layer.borderWidth = 0.5;
        _zd32_BtnsBgView.layer.cornerRadius = 16;
        _zd32_BtnsBgView.layer.masksToBounds = YES;
        
        UIButton *accBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        accBtn.frame = CGRectMake(41.5, 6, 40, 25);
        accBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_MainColor];
        accBtn.layer.cornerRadius = 5.0;
        accBtn.layer.masksToBounds = YES;
        accBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        accBtn.tag = 101;
        [accBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_Account_Short_Text") forState:UIControlStateNormal];
        [accBtn addTarget:self action:@selector(zd32_HandleClickedAccBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_zd32_BtnsBgView addSubview:accBtn];
        
        UIButton *cuservicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cuservicBtn.frame = CGRectMake(accBtn.blmg_right + 10, 6, 40, 25);
        cuservicBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_SecondaryColor];
        cuservicBtn.layer.cornerRadius = 5.0;
        cuservicBtn.layer.masksToBounds = YES;
        cuservicBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        cuservicBtn.tag = 102;
        [cuservicBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_CustomerService_Text") forState:UIControlStateNormal];
        [cuservicBtn addTarget:self action:@selector(zd32_HandleClickedCustomorServiceBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_zd32_BtnsBgView addSubview:cuservicBtn];
        
        UIButton *zd33_checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zd33_checkBtn.frame = CGRectMake(cuservicBtn.blmg_right + 10, 6, 40, 25);
        zd33_checkBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_OthersColor];
        zd33_checkBtn.layer.cornerRadius = 5.0;
        zd33_checkBtn.layer.masksToBounds = YES;
        zd33_checkBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        zd33_checkBtn.tag = 103;
        [zd33_checkBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_QuickCheckPurchase_Text") forState:UIControlStateNormal];
        [zd33_checkBtn addTarget:self action:@selector(zd32_HandleClickedCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_zd32_BtnsBgView addSubview:zd33_checkBtn];
        zd33_checkBtn.hidden = YES;
    }
    return _zd32_BtnsBgView;
}

- (void)zd32_u_BecameActiveCompletion:(void(^)(void))completion {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(zd32_u_ResignActive) object:nil];
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1.0f;
        if (self.blmg_left <= self.superview.blmg_width/2) {
            self.blmg_left = 0;
        } else {
            self.blmg_right = self.superview.blmg_width;
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)zd32_u_ResignActive {
    [self zd32_u_HidenBtns:YES completion:^{
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0.5f;
            
            UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
            if (@available(iOS 11.0, *)) {
                UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
                safeAreaInsets = window.safeAreaInsets;
            }
            if (self.blmg_left <= self.superview.blmg_width/2) {
                self.blmg_centerX = MAX(0, safeAreaInsets.left - 20);
            } else {
                self.blmg_centerX = self.superview.blmg_width - MAX(0, safeAreaInsets.right - 20);
            }
        }];
    }];
}

- (void)zd32_u_AdsorbToEdge:(CGPoint)center {
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
            safeAreaInsets = window.safeAreaInsets;
        }
        if (center.x < self.superview.blmg_width/2) {
            self.blmg_left = MAX(0, safeAreaInsets.left - 20);
        } else {
            self.blmg_right = self.superview.blmg_width - MAX(0, safeAreaInsets.right - 20);
        }
    } completion:^(BOOL finished) {
        [self performSelector:@selector(zd32_u_ResignActive) withObject:nil afterDelay:2.5];
    }];
}

- (void)zd32_u_ShowBtns:(BOOL)animated completion:(void(^)(void))completion {
    if (animated) {
        YLAF_leftShowVCViewController *vc = [[YLAF_leftShowVCViewController alloc]init];
//        UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
//        [window.rootViewController cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:nil];
        [[self zd32_CurrentVC] cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:nil];
//        self.zd32_BtnsBgView.hidden = NO;
//        [UIView animateWithDuration:0.25 animations:^{
//            self.zd32_BtnsBgView.blmg_width = self.zd32_BtnsBgViewWidth;
//            self.blmg_width = self.zd32_BtnsBgView.blmg_right;
//            if (self.blmg_left <= self.superview.blmg_width/2) {
//                self.blmg_left = 0;
//            } else {
//                self.blmg_right = self.superview.blmg_width;
//            }
//        } completion:^(BOOL finished) {
//            if (completion) {
//                completion();
//            }
//        }];
    } else {
//        self.zd32_BtnsBgView.hidden = NO;
//        self.zd32_BtnsBgView.blmg_width = self.zd32_BtnsBgViewWidth;
//        self.blmg_width = self.zd32_BtnsBgView.blmg_right;
//        if (completion) {
//            completion();
//        }
    }
}


- (UIViewController *)zd32_CurrentVC {
    if (YLMXGSDKAPI.context) {
        return YLMXGSDKAPI.context;
    }
    
    return [YLAF_Shortcut_View zd32_u_getCurrentVC];
}


+ (UIViewController *)zd32_u_getCurrentVC
{
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    }
    return [self topViewControllerWithRootViewController:[[UIApplication sharedApplication].windows lastObject].rootViewController];

}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    }
    else {
        return rootViewController;
    }
}

- (void)zd32_u_HidenBtns:(BOOL)animated completion:(void(^)(void))completion {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.zd32_BtnsBgView.blmg_width = 0;
            self.blmg_width = self.zd32_ImageView.blmg_width;
            self.zd31_hintLab.hidden = true;
        } completion:^(BOOL finished) {
            self.zd32_BtnsBgView.hidden = YES;
            if (completion) {
                completion();
            }
        }];
    } else {
        self.zd32_BtnsBgView.blmg_width = 0;
        self.zd32_BtnsBgView.hidden = YES;
        if (completion) {
            completion();
        }
    }
}

- (void)zd32_u_ReLayoutSubViews {
    
    UIButton *ireBtn = [_zd32_BtnsBgView viewWithTag:103];
    if ((MYMGSDKGlobalInfo.lightState << 2) == 0) {
        self.zd32_BtnsBgViewWidth = 150;
        ireBtn.hidden = YES;
    } else {
        self.zd32_BtnsBgViewWidth = 150 + 50;
        ireBtn.hidden = NO;
    }
}

- (void)zd32_HandleTapAction:(UITapGestureRecognizer *)recognizer {
    [self zd32_u_BecameActiveCompletion:^{
        [self zd32_u_ShowBtns:YES completion:nil];
        [self performSelector:@selector(zd32_u_ResignActive) withObject:nil afterDelay:3.0];
    }];
}

- (void)zd32_HandlePanAction:(UIPanGestureRecognizer *)recognizer {
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    
    CGFloat KWidth = topView.bounds.size.width;
    CGFloat KHeight = topView.bounds.size.height;
    
    
    CGPoint point = [recognizer translationInView:topView];
    
    CGFloat centerX = recognizer.view.center.x + point.x;
    CGFloat centerY = recognizer.view.center.y + point.y;
    
    CGFloat viewHalfH = recognizer.view.frame.size.height/2;
    CGFloat viewhalfW = recognizer.view.frame.size.width/2;
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
        safeAreaInsets = UIEdgeInsetsMake(window.safeAreaInsets.top, window.safeAreaInsets.left, window.safeAreaInsets.bottom, window.safeAreaInsets.right);
    }
    if (centerY - viewHalfH < MAX(20, safeAreaInsets.top - 15)) {
        centerY = viewHalfH + MAX(20, safeAreaInsets.top - 15);
    }
    if (centerY + viewHalfH > KHeight - safeAreaInsets.bottom) {
        centerY = KHeight - viewHalfH - safeAreaInsets.bottom;
    }
    if (centerX - viewhalfW < MAX(0, safeAreaInsets.left - 20)){
        centerX = viewhalfW + MAX(0, safeAreaInsets.left - 20);
    }
    if (centerX + viewhalfW > KWidth - MAX(0, safeAreaInsets.right - 20)){
        centerX = KWidth - viewhalfW - MAX(0, safeAreaInsets.right - 20);
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        recognizer.view.center = CGPointMake(centerX, centerY);
        [recognizer setTranslation:CGPointZero inView:topView];
    }];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1.0f;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self zd32_u_AdsorbToEdge:CGPointMake(centerX, centerY)];
    }
}

- (void)zd32_HandleLongPressAction:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        [self performSelector:@selector(zd32_u_ResignActive) withObject:nil afterDelay:2.5];
    }
}

- (void)zd32_HandleClickedAccBtn:(id)sender {
    [ZhenD3SDKMainView_Controller zd31_showAccountView];
}

- (void)zd32_HandleClickedCustomorServiceBtn:(id)sender {
    [ZhenD3SDKMainView_Controller zd31_showCustomerServiceView];
}

- (void)zd32_HandleClickedCheckBtn:(id)sender {
    NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : MYMGSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[MYMGSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [MYMGSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
    BOOL zd31_GvCheck = MYMGSDKGlobalInfo.zd31_GvCheck;
    NSString *url = [ZhenD3RemoteData_Server zd32_BuildFinalUrl:zd31_GvCheck?MYMGUrlConfig.zd32_httpsdomain.zd32_returnupsBaseUrl:MYMGUrlConfig.zd32_httpsdomain.zd32_backupsBaseUrl WithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAutoLoginPath andParams:params];
    
    [MYMGSDKGlobalInfo zd32_PresendWithUrlString:url];
}

@end
