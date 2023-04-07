
#import "AppDelegate.h"
#import <ZhendiFrameWork/ZhendiFrameWork.h>
#import <MOPMAdSDK/MOPMAdSDK.h>
#import "JPBaoFu_ViewController.h"
#import "XZMCoreNewFeatureVC.h"
#import "UIDevice+GrossExtension.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    ZhenD3AdjustConfig_Entity *adjustConfig = [[ZhenD3AdjustConfig_Entity alloc] init];
#ifdef DEBUG
    adjustConfig.environment = YLAF_EnvironmentSandbox;
    [ZhenD3OpenAPI zd3_openDevLog:YES];
#else
    adjustConfig.environment = YLAF_EnvironmentProduction;
#endif
    adjustConfig.adjustAppToken = @"heroywu3bqps";
    adjustConfig.zd3_eventTokenLogin = @"5z60uw";
    adjustConfig.zd3_eventTokenRegister = @"quye19";
    adjustConfig.zd3_eventTokenAccRegister = @"quye19";
    adjustConfig.zd3_eventTokenFBRegister = @"7pmo61";
    adjustConfig.zd3_eventTokenCreateRoles = @"jflrd2";
    adjustConfig.zd3_eventTokenCompleteNoviceTask = @"kb3grp";
    adjustConfig.zd3_eventTokenPurchase = @"wb9u6b";
    
    adjustConfig.zd3_eventTokenPurchaseARPU1 = @"4z8x60";
    adjustConfig.zd3_eventTokenPurchaseARPU5 = @"d1m9vz";
    adjustConfig.zd3_eventTokenPurchaseARPU10 = @"ve9c1i";
    adjustConfig.zd3_eventTokenPurchaseARPU30 = @"ofup5j";
    adjustConfig.zd3_eventTokenPurchaseARPU50 = @"3n81mw";
    adjustConfig.zd3_eventTokenPurchaseARPU100 = @"snempj";
    
    adjustConfig.zd3_eventTokenbegincdnTask = @"vnowj3";
    adjustConfig.zd3_eventTokenfinishcdnTask = @"b5vfs3";
    adjustConfig.zd3_eventTokenbeginNoviceTask = @"esdiar";
    

    ZhenD3SDKConfig_Entity *config = [[ZhenD3SDKConfig_Entity alloc] init];
    config.gameID = @"10";
    config.gameKey = @"ED9D91B21511F9A0AA7D43C165BB1F05";
    config.facebookAppID = @"5916077931785567";
    config.adjustConfig = adjustConfig;
    config.sdkConnectServer = YLAF_SDKServerVi;

    [ZhenD3OpenAPI zd3_launchSDKWithConfig:config
                           application:application
         didFinishLaunchingWithOptions:launchOptions];
    
    [MOPMAdSDKAPI initSDKWithAppKey:[NSString stringWithFormat:@"%@%@%@%@",@"1pB8Ma",@"FrvRr",@"eX6vVfmHu4Gt9o",@"MjHrRol"]];
    

    

    return YES;
}
- (NSUInteger) supportedInterfaceOrientations{
 #ifdef __IPHONE_6_0
//     if (ConfigParser::getInstance()->isLanscape()) {
         return UIInterfaceOrientationMaskLandscape;
//     }else{
//         return UIInterfaceOrientationMaskPortrait;
//     }
 #endif
 }
 
 - (BOOL) shouldAutorotate {
//     if (ConfigParser::getInstance()->isLanscape()) {
         return YES;
//     }else{
//         return NO;
//     }
 }
- (void)requestIDFA {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // Tracking authorization completed. Start loading ads here.
//             [self loadAd];
        }];
    } else {
        // Fallback on earlier versions
    }
}



- (void)zd32_initUI{
    
    JPBaoFu_ViewController *vc = [[JPBaoFu_ViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self requestIDFA];
    [ZhenD3OpenAPI activateApp];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return [ZhenD3OpenAPI application:application
                              openURL:url
                    sourceApplication:sourceApplication
                           annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [ZhenD3OpenAPI application:app openURL:url options:options];
}

@end
