
#import "ViewController.h"
#import <ZhendiFrameWork/ZhendiFrameWork.h>
#import <MOPMAdSDK/MOPMAdSDK.h>

@interface ViewController () <ZhenD3OpenAPIDelegate, MOPMAdSDKRewardDelegate>

@property (strong, nonatomic) IBOutlet UIButton *inittSDKBtn;
@property (strong, nonatomic) IBOutlet UIButton *showLoginViewBtn;
@property (strong, nonatomic) IBOutlet UIButton *enterGameBtn;
@property (strong, nonatomic) IBOutlet UIButton *createRoleBtn;
@property (strong, nonatomic) IBOutlet UIButton *zf1Btn;
@property (strong, nonatomic) IBOutlet UIButton *zf2Btn;
@property (strong, nonatomic) IBOutlet UIButton *updateLevelBtn;
@property (strong, nonatomic) IBOutlet UIButton *logoutBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UITextField *levelInputTextField;
@property (strong, nonatomic) IBOutlet UITextView *logTextView;

- (IBAction)onClickInitBtn:(id)sender;
- (IBAction)onClickShowLoginViewBtn:(id)sender;
- (IBAction)onClickEnterGameBtn:(id)sender;
- (IBAction)onClickCreateRoleBtn:(id)sender;
- (IBAction)onClickZf1Btn:(id)sender;
- (IBAction)onClickZf2Btn:(id)sender;
- (IBAction)onClickUpdateLevelBtn:(id)sender;
- (IBAction)onCilckLogoutBtn:(id)sender;
- (IBAction)onClickSetLanguageBtn:(id)sender;
- (IBAction)onClickShowAd:(id)sender;
- (IBAction)onClickdelete:(id)sender;

@property (copy, nonatomic) NSString *roleName;
@property (copy, nonatomic) NSString *roleID;
@property (copy, nonatomic) NSString *roleLevel;
@end

@implementation ViewController

- (void)dealloc {
    [MOPMAdSDKAPI SharedInstance].rewardDelegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YLMXGSDKAPI.delegate = self;
    YLMXGSDKAPI.context = self;
    [MOPMAdSDKAPI SharedInstance].rewardDelegate = self;
    
    
    
    self.inittSDKBtn.enabled = YES;
    self.showLoginViewBtn.enabled = NO;
    self.enterGameBtn.enabled = NO;
    self.createRoleBtn.enabled = NO;
    self.zf1Btn.enabled = NO;
    self.zf2Btn.enabled = NO;
    self.updateLevelBtn.enabled = NO;
    self.logoutBtn.enabled = NO;
}

- (void)showLogMsg:(NSString *)msg typeText:(NSString *)typeText {
    NSString *str = [NSString stringWithFormat:@"---%@--- \n %@  \n---%@--- \n", typeText,msg,typeText];
    
    
    [self.logTextView insertText:str];
    
    CGFloat offset = self.logTextView.contentSize.height - self.logTextView.frame.size.height;
    if (offset < 0) {
        offset = 0;
    }
    [self.logTextView setContentOffset:CGPointMake(0, offset) animated:YES];
}


- (void)zd3_initialSDKFinished:(ZhenD3ResponseObject_Entity *)response {
    
    if (response.zd32_responseCode == YLAF_ResponseCodeSuccess) {
        [self.inittSDKBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.inittSDKBtn.enabled = NO;
        
        [self.showLoginViewBtn setBackgroundColor:[UIColor redColor]];
        self.showLoginViewBtn.enabled = YES;
        
        self.enterGameBtn.enabled = NO;
        self.createRoleBtn.enabled = NO;
        self.zf1Btn.enabled = NO;
        self.zf2Btn.enabled = NO;
        self.updateLevelBtn.enabled = NO;
        self.logoutBtn.enabled = NO;
        
    }
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"初始化"];
}

- (void)zd3_loginFinished:(ZhenD3ResponseObject_Entity *)response {
    if (response.zd32_responseCode == YLAF_ResponseCodeSuccess) {
        [self.inittSDKBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.inittSDKBtn.enabled = NO;
        
        [self.showLoginViewBtn setBackgroundColor:[UIColor redColor]];
        self.showLoginViewBtn.enabled = NO;
        
        self.enterGameBtn.enabled = YES;
        self.createRoleBtn.enabled = YES;
        self.zf1Btn.enabled = NO;
        self.zf2Btn.enabled = NO;
        self.updateLevelBtn.enabled = NO;
        self.logoutBtn.enabled = YES;
        
        [ZhenD3OpenAPI zd3_getPurchaseProduces];
    }
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"登录"];
}

- (void)zd3_enterGameFinished:(ZhenD3ResponseObject_Entity *)response {
    if (response.zd32_responseCode == YLAF_ResponseCodeSuccess) {
        [self.inittSDKBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.inittSDKBtn.enabled = NO;
        
        [self.showLoginViewBtn setBackgroundColor:[UIColor redColor]];
        self.showLoginViewBtn.enabled = NO;
        
        self.enterGameBtn.enabled = NO;
        self.createRoleBtn.enabled = YES;
        self.zf1Btn.enabled = YES;
        self.zf2Btn.enabled = YES;
        self.updateLevelBtn.enabled = YES;
        self.logoutBtn.enabled = YES;
    }
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"进入游戏"];
}

- (void)zd3_logoutFinished:(ZhenD3ResponseObject_Entity *)response {
    if (response.zd32_responseCode == YLAF_ResponseCodeSuccess) {
        [self.inittSDKBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.inittSDKBtn.enabled = NO;
        
        [self.showLoginViewBtn setBackgroundColor:[UIColor redColor]];
        self.showLoginViewBtn.enabled = YES;
        
        self.enterGameBtn.enabled = NO;
        self.createRoleBtn.enabled = NO;
        self.zf1Btn.enabled = NO;
        self.zf2Btn.enabled = NO;
        self.updateLevelBtn.enabled = NO;
        self.logoutBtn.enabled = NO;
    }
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"退出登录"];
}
- (void)zd3_deleteFinished:(ZhenD3ResponseObject_Entity *)response {
    if (response.zd32_responseCode == YLAF_ResponseCodeSuccess) {
        [self.inittSDKBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.inittSDKBtn.enabled = NO;
        
        [self.showLoginViewBtn setBackgroundColor:[UIColor redColor]];
        self.showLoginViewBtn.enabled = YES;
        
        self.enterGameBtn.enabled = NO;
        self.createRoleBtn.enabled = NO;
        self.zf1Btn.enabled = NO;
        self.zf2Btn.enabled = NO;
        self.updateLevelBtn.enabled = NO;
        self.logoutBtn.enabled = NO;
    }
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"删除账号"];
}




- (void)zd3_registerServerInfoFinished:(ZhenD3ResponseObject_Entity *)response {
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"注册区服信息"];
}

- (void)zd3_commitGameRoleLevelFinished:(ZhenD3ResponseObject_Entity *)response {
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"提升角色等级"];
}

- (void)zd3_getPriceOfProductsFinished:(ZhenD3ResponseObject_Entity *)response {
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"获取商品价格"];
}
- (void)zd3_startPurchaseProduceOrderFinished:(ZhenD3ResponseObject_Entity *)response {
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"购买商品支付"];
    
    if (response.zd32_responseCode == YLAF_ResponseCodeSuccess) {
        
    } else {
        
    }
}
- (void)zd3_checkOrderAppleReceiptFinished:(ZhenD3ResponseObject_Entity *)response {
    
    
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"支付苹果凭证验证"];
}

- (void)zd3_checkPresentFinish:(ZhenD3ResponseObject_Entity *)response{
    [self showLogMsg:[NSString stringWithFormat:@"%@", response] typeText:@"获取礼包"];
    if (response.zd32_responseCode == YLAF_ResponseCodeSuccess) {
        
    } else {
        
    }
}


- (void)rewardVideoChangedAvailability:(BOOL)available {
    if (available) {
         
    } else {
        
    }
}

- (void)rewardVideoDidOpen:(MOPM_AdScene_Entity*)scene {
    
    
}

- (void)rewardVideoPlayStart:(MOPM_AdScene_Entity*)scene {
    
}

- (void)rewardVideoPlayEnd:(MOPM_AdScene_Entity*)scene {
    
}

- (void)rewardVideoDidClick:(MOPM_AdScene_Entity*)scene {
    
}

- (void)rewardVideoDidReceiveReward:(MOPM_AdScene_Entity*)scene {
    
}

- (void)rewardVideoDidClose:(MOPM_AdScene_Entity*)scene {
    
    
}

- (void)rewardVideoDidFailToShow:(MOPM_AdScene_Entity*)scene withError:(NSError *)error {
    
}


- (void)closeKeyBorder {
    [self.view endEditing:YES];
}

- (NSString *)convertToJsonData:(NSDictionary *)dict {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        
    }
    else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (IBAction)onClickInitBtn:(id)sender {
    [ZhenD3OpenAPI zd3_initialSDK];
    [ZhenD3OpenAPI zd3_adjustEventWithEventToken:@"11111" parameters:@""];
    
    if ([@"1111" isEqualToString:@"2222"]) {
        
    }
    
}

- (IBAction)onClickShowLoginViewBtn:(id)sender {
    [ZhenD3OpenAPI showLoginView];
    

    
   
}

- (IBAction)onClickEnterGameBtn:(id)sender {
    if (!self.roleName || self.roleName.length <= 0) {
        self.roleName = [NSString stringWithFormat:@"%@%@",@"德玛西亚",@"1"];
    }
    if (!self.roleID || self.roleID.length <= 0) {
        self.roleID = [NSString stringWithFormat:@"%@%@%@",@"000",@"0",@"05"];
    }
    if (!self.roleLevel || self.roleLevel.length <= 0) {
        self.roleLevel = @"1";
    }
    
    [ZhenD3OpenAPI zd3_enterGameIntoServerId:[NSString stringWithFormat:@"%@%@%@",@"0",@"00",@"002"]
                              serverName:[NSString stringWithFormat:@"%@%@",@"爱莎",@"丽雅"]
                              withRoleId:self.roleID
                                roleName:self.roleName
                            andRoleLevel:[self.roleLevel integerValue]];
    
    [ZhenD3OpenAPI zd3_completeNoviceTask];
    
    [ZhenD3OpenAPI blmg_obtainPresentWithGameId:@"10" zd32_roleId:self.roleID];
}

- (IBAction)onClickCreateRoleBtn:(id)sender {
    
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@",@"创",@"建角色"] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [aler addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"%@%@",@"角色",@"名"];
    }];
    [aler addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"%@%@",@"角色I",@"D"];
    }];
    [aler addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"%@%@",@"角色等",@"级"];
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    [aler addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [aler addAction:[UIAlertAction actionWithTitle:@"创建" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.roleName = aler.textFields[0].text;
        self.roleID = aler.textFields[1].text;
        self.roleLevel = aler.textFields[2].text;
    }]];
    [self presentViewController:aler animated:YES completion:nil];
}

- (IBAction)onClickZf1Btn:(id)sender {
    
    ZhenD3CPPurchaseOrder_Entity *cpOrder = [ZhenD3CPPurchaseOrder_Entity new];
    cpOrder.cpOrderNO = @(arc4random() / 1000000).stringValue;
    cpOrder.cpExtraInfo = [NSString stringWithFormat:@"%@%@",@"测试充值-",@"1"];
    cpOrder.appleProductId = @"pay.dcqkaoe.2401111";
    cpOrder.productName = [NSString stringWithFormat:@"%@%@%@",@"60",@"钻石",@"包"];
    cpOrder.cpGameCurrency = 60;
    [ZhenD3OpenAPI zd3_startPurchaseProduceOrder:cpOrder];
}

- (IBAction)onClickZf2Btn:(id)sender {
    
    ZhenD3CPPurchaseOrder_Entity *cpOrder = [ZhenD3CPPurchaseOrder_Entity new];
    cpOrder.cpOrderNO = @(arc4random() / 1000000).stringValue;
    cpOrder.cpExtraInfo = [NSString stringWithFormat:@"%@%@",@"测试充值-",@"2"];
    cpOrder.appleProductId = [NSString stringWithFormat:@"pay.dcqkaoe.1300"];
    cpOrder.productName = [NSString stringWithFormat:@"%@%@",@"大",@"礼包"];
    cpOrder.cpGameCurrency = 1;
    [ZhenD3OpenAPI zd3_startPurchaseProduceOrder:cpOrder];
}

- (IBAction)onClickUpdateLevelBtn:(id)sender {
    [self.view endEditing:YES];
    if (_levelInputTextField.text.length == 0) {
        [self showLogMsg:[NSString stringWithFormat:@"%@%@%@",@"请输入正确",@"的等",@"级"] typeText:[NSString stringWithFormat:@"%@%@",@"更新等",@"级"]];
        return;
    }
    [ZhenD3OpenAPI zd3_updateAndCommitGameRoleLevel:[_levelInputTextField.text intValue]];
}

- (IBAction)onCilckLogoutBtn:(id)sender {
    [ZhenD3OpenAPI logout:NO];
}

- (IBAction)onClickSetLanguageBtn:(id)sender {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@",@"设置",@"语言"] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"中文(调试用)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [YLMXGSDKAPI setZd3_localizedLanguage:YLAF_LanguageCh];
    }]];
    [aler addAction:[UIAlertAction actionWithTitle:@"越南文" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [YLMXGSDKAPI setZd3_localizedLanguage:YLAF_LanguageVi];
//        [YLMXGSDKAPI setzd3_localizedLanguage:YLAF_LanguageVi];
    }]];
    [aler addAction:[UIAlertAction actionWithTitle:@"泰语" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [YLMXGSDKAPI setZd3_localizedLanguage:YLAF_LanguageTh];
//        [YLMXGSDKAPI setzd3_localizedLanguage:YLAF_LanguageTh];
    }]];
    [aler addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:aler animated:YES completion:nil];
}

- (IBAction)onClickdelete:(id)sender {
    [ZhenD3OpenAPI zd3_delete:YES];
    
}

- (IBAction)onClickShowAd:(id)sender {

    [MOPMAdSDKAPI showRewardVideoAd:[NSString stringWithFormat:@"%@%@%@",@"tes",@"tvad0",@"1"] inViewController:self];
}

@end
