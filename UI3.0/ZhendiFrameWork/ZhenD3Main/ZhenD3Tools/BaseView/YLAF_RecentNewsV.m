//
//  YLAF_RecentNewsV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_RecentNewsV.h"
#import "TKCarouselView.h"
#import "ZhenD3Account_Server.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+GrossExtension.h"
#import "YLAF_W_ViewController.h"

@interface YLAF_RecentNewsV ()

@property (nonatomic, strong) TKCarouselView *zd31_carouselView;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) NSArray *zd33_imgArr;
@end

@implementation YLAF_RecentNewsV

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:YES];
    
    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_lastNew")];
    
    self.zd31_carouselView = [[TKCarouselView alloc] initWithFrame:CGRectMake(15, 50, self.blmg_width - 30, self.blmg_width/2 - 30)];
    [self addSubview:self.zd31_carouselView];
    
    [self zd31_getBannerListData];
}

- (void)zd31_getBannerListData{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_GetNewsListRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd33_imgArr = (NSArray *)result.zd32_responeResult;
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
        
        [weakSelf.zd31_carouselView reloadImageCount:weakSelf.zd33_imgArr.count itemAtIndexBlock:^(UIImageView *imageView, NSInteger index) {
            NSDictionary *zd33_Dict = weakSelf.zd33_imgArr[index];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",zd33_Dict[@"img"]]] placeholderImage:[YLAF_Helper_Utils imageName:@""]]; //ImageNationfeedFb
        } imageClickedBlock:^(NSInteger index) {
            NSDictionary *zd33_Dict = weakSelf.zd33_imgArr[index];
            //1 富文本 2 外联 3 没效果
            if ([zd33_Dict[@"type"] isEqualToString:@"1"]) {
                YLAF_W_ViewController *vc = [[YLAF_W_ViewController alloc]init];
                
                //加载本地 html js 文件
                NSBundle *bundle = [YLAF_Helper_Utils zd32_resBundle:[YLAF_Helper_Utils class]];
                NSString *pathStr = [bundle pathForResource:@"www" ofType:@"html"];
                NSURL *url = [NSURL fileURLWithPath:pathStr];
                NSString *html = [[NSString alloc] initWithContentsOfFile:pathStr encoding:NSUTF8StringEncoding error:nil];
                vc.zd32_htstr = url;
                vc.zd33_base = html;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [[weakSelf zd32_CurrentVC] presentViewController:nav animated:YES completion:nil];
            }else if ([zd33_Dict[@"type"] isEqualToString:@"2"]) {
                __weak typeof(self) weakSelf = self;
                YLAF_W_ViewController *vc = [[YLAF_W_ViewController alloc]init];
                vc.alhm_uString = zd33_Dict[@"url"];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [[weakSelf zd32_CurrentVC] presentViewController:nav animated:YES completion:nil];
            }
        }];
    }];
}

- (UIViewController *)zd32_CurrentVC {
    if (YLMXGSDKAPI.context) {
        return YLMXGSDKAPI.context;
    }
    
    return [YLAF_RecentNewsV zd32_u_getCurrentVC];
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




- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseRecentNewsV:)]) {
        [self.delegate zd31_handleCloseRecentNewsV:self];
    }
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

@end
