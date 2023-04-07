
#import "YLAF_W_ViewController.h"
#import "ZhenD3OpenAPI.h"
#import <WebKit/WebKit.h>
#import "YLAF_Helper_Utils.h"
#import "ZhenD3Account_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "AppDelegate.h"
@interface YLAF_W_ViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@end

@implementation YLAF_W_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (instancetype)initWithblmg_meetData:(NSString *)blmg_meetData zd31_exp:(NSString *)zd31_exp{
    self = [super init];
    if (self) {
        self.blmg_meetData = blmg_meetData;
        self.zd31_exp = zd31_exp;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSLog(@"哈哈哈");
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    if (_alhm_uString && [_alhm_uString isKindOfClass:[NSString class]]) {
        NSURLRequest *qt = [NSURLRequest requestWithURL:[NSURL URLWithString:_alhm_uString]];
        NSLog(@"%@",_alhm_uString);
        [self.webView loadRequest:qt];
    }
    
    
    if (_zd32_htstr && [_zd32_htstr isKindOfClass:[NSURL class]]) {
        NSURLRequest *qt = [NSURLRequest requestWithURL:_zd32_htstr];
        NSLog(@"%@",_zd32_htstr);
        [self.webView loadRequest:qt];
    }
    
    [self.view addSubview:self.webView];
    
    
}



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
        
    _webView.frame = self.view.bounds;
}

- (void)doneAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)refreshAction:(id)sender {
    [self.webView reload];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [ZhenD3OpenAPI zd3_setShortCutHidden:NO];
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
  if(!message) {
    return;
  }
  
    NSLog(@"js调用的方法:%@",message.name);
//    NSLog(@"js传过来的数据:%@",message.body);
  if(message.name) {
    if([message.name isEqualToString:@"BaseInfo"]) {
//        NSLog(@"%@",message.body);
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
        [dic setValue:self.zd31_exp?:@"" forKey:@"exp"];
        [dic setValue:@"vn" forKey:@"lang"];
        [dic setValue:YLMXGSDKAPI.gameInfo.gameID forKey:@"gameid"];
        [self sendFuncTo:@"getBaseInfo" sendTojsPrama:dic];
    }
    else if ([message.name isEqualToString:@"getBindList"]){
        [self blmg_obtainRoleInfo];
    }
    else if ([message.name isEqualToString:@"getPresent"]){
//        NSLog(@"%@",message.body);
        NSDictionary *dict = [YLAF_W_ViewController dictionaryWithJsonString:message.body];
        [self zd33_exchangePresentzd32_GameId:dict[@"serve_id"] zd32_roleId:dict[@"role_id"]];
    }
    else if ([message.name isEqualToString:@"clseV"]){
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else if ([message.name isEqualToString:@"getMeetDate"]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
        [dic setValue:self.blmg_meetData?:@"" forKey:@"meetdata"];
        [self sendFuncTo:@"getMeetDate" sendTojsPrama:dic];
    }
  }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
//        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



- (void)sendFuncTo:(NSString *)methodName sendTojsPrama:(id)prama {
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
//  [dic setValue:methodName forKey:@"method"];
  [dic setValue:prama forKey:@"prama"];
  NSString *jsonStr = [[NSString alloc] initWithData:[self toJSONData:dic] encoding:NSUTF8StringEncoding];
  [self callbackToJS:jsonStr methodName:methodName];
}

- (NSData *)toJSONData:(id)theData {
  NSError *error = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                     options:0
                                                       error:&error];
  if ([jsonData length] > 0 && error == nil){
      return jsonData;
  } else {
      return nil;
  }
}

- (void)callbackToJS:(NSString*)jsonParam methodName:(NSString *)methodName{
//  NSString *js = [NSString stringWithFormat:@"fromIosCall('%@');", jsonParam];
    NSString * jsStr = [NSString stringWithFormat:@"%@('%@')",methodName,jsonParam];
    NSLog(@"%@",jsStr);
  [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    if (response || error) {
      NSLog(@"value=======: %@ error: %@", response, error);
    }
  }];
}



- (void)blmg_obtainRoleInfo
{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer lhxy_getUserRoleRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [weakSelf sendFuncTo:@"getBindList" sendTojsPrama:result.zd32_responeResult];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd33_exchangePresentzd32_GameId:(NSString *)zd32_GameId zd32_roleId:(NSString *)zd32_roleId
{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer lhxy_exchangePresentWithGameId:zd32_GameId zd32_roleId:zd32_roleId Request:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        
//        [weakSelf sendFuncTo:@"getPresentMsg" sendTojsPrama:result.zd32_responeMsg];
        
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showSuccess_Toast:MUUQYLocalizedString(@"MUUQYKey_vipRoleObtainPresent")];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

- (WKWebView*)webView {
    if(!_webView) {
        WKWebViewConfiguration *cf = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController =[[WKUserContentController alloc]init];
     
       
    [userContentController addScriptMessageHandler:self name:@"BaseInfo"];
       
    [userContentController addScriptMessageHandler:self name:@"getBindList"];
   
     [userContentController addScriptMessageHandler:self name:@"getPresent"];

     [userContentController addScriptMessageHandler:self name:@"clseV"];
    [userContentController addScriptMessageHandler:self name:@"getMeetDate"];
        
        
        
        cf.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:cf];
        _webView.UIDelegate=self;
        
        _webView.navigationDelegate = self;

//        _webView.delegate = self;

//        _webView.UIDelegate = self;
        
    }
    return _webView;
}


@end
