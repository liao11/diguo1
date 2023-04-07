//
//  YLAF_RecentNewsV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_RecentNews2V.h"
#import "TKCarouselView.h"
#import "ZhenD3Account_Server.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+GrossExtension.h"
#import "YLAF_W_ViewController.h"
#import <WebKit/WebKit.h>
@interface YLAF_RecentNews2V ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *zd31_carouselView;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) NSArray *zd33_imgArr;
@end

@implementation YLAF_RecentNews2V

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:YES];
    
    [self setTitle:@"Thông báo"];
    self.center=CGPointMake(YLAFWIDTH/2, YLAFHEIGHT/2);
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];

    WKUserContentController *content = [[WKUserContentController alloc]init];

    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];

    // 添加自适应屏幕宽度js调用的方法

    [content addUserScript:wkUserScript];

    wkWebConfig.userContentController= content;

    self.zd31_carouselView = [[WKWebView alloc]initWithFrame:CGRectMake(15, 50, self.blmg_width - 30, self.blmg_width/2 - 30) configuration:wkWebConfig];

   
    
//    self.zd31_carouselView = [[WKWebView alloc] initWithFrame:CGRectMake(15, 50, self.blmg_width - 30, self.blmg_width/2 - 30)];
    [self addSubview:self.zd31_carouselView];
    
    NSString *html_str = MYMGSDKGlobalInfo.notice;
    self.zd31_carouselView.navigationDelegate = self;

        self.zd31_carouselView.scrollView.delegate = self;

        self.zd31_carouselView.UIDelegate = self;

   

    NSLog(@"富文本%@",html_str);
    [self.zd31_carouselView loadHTMLString:html_str baseURL:nil];
    
}
- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation {

    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id result, NSError *_Nullable error) {

        //result 就是加载完成后 webView的实际高度

        //获取后返回重新布局

        NSLog(@"%@",result);

        self.zd31_carouselView.frame = CGRectMake(15, 50, self.blmg_width - 30, [result integerValue]);

    }];

}




- (UIViewController *)zd32_CurrentVC {
    if (YLMXGSDKAPI.context) {
        return YLMXGSDKAPI.context;
    }
    
    return [YLAF_RecentNews2V zd32_u_getCurrentVC];
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
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseRecentNews2V:)]) {
        [self.delegate zd31_handleCloseRecentNews2V:self];
    }
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

@end
