
#import "ZhenD3CustomerService_View.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"
#import "ZhenD3SDKGlobalInfo_Entity.h"
#import "ZhenD3Account_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "NSString+GrossExtension.h"

@interface ZhenD3CustomerService_View ()

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) NSString *zd31_Facebook_url;
@property (nonatomic, strong) NSString *zd31_Service_email;
@property (nonatomic, strong) UIButton *feedbackBtn;
@property (nonatomic, strong) UIButton *facebookBtn;
@property (nonatomic, strong) UILabel *zd31_CSKH_email;
@end

@implementation ZhenD3CustomerService_View

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

- (void)zd32_setupViews {
    self.title = MUUQYLocalizedString(@"MUUQYKey_CustomerServiceContact_Text");
    
    [self zd32_ShowCloseBtn:YES];
    
    self.feedbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.feedbackBtn.frame = CGRectMake(20, 75, self.blmg_width - 40, 50);
    self.feedbackBtn.blmg_centerX = self.blmg_width/2;
    self.feedbackBtn.titleLabel.font = [YLAF_Theme_Utils khxl_FontSize35];
    self.feedbackBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_MainColor];
    self.feedbackBtn.layer.cornerRadius = 6.0;
    self.feedbackBtn.layer.masksToBounds = YES;
    [self.feedbackBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_Feedback_Text") forState:UIControlStateNormal];
    [self.feedbackBtn addTarget:self action:@selector(zd31_HandleFeedbackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.feedbackBtn];
    
    self.facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.facebookBtn.frame = CGRectMake(20, self.feedbackBtn.blmg_bottom + 30, self.blmg_width - 40, 50);
    self.facebookBtn.blmg_centerX = self.feedbackBtn.blmg_centerX;
    self.facebookBtn.titleLabel.font = [YLAF_Theme_Utils khxl_FontSize35];
    [self.facebookBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_Facebook_Text") forState:UIControlStateNormal];
    [self.facebookBtn setBackgroundImage:[YLAF_Helper_Utils imageName:@"zdimagefeedFb"] forState:UIControlStateNormal];
    [self.facebookBtn addTarget:self action:@selector(zd31_HandleFacebookBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.facebookBtn];
    
    self.zd31_CSKH_email = [[UILabel alloc] initWithFrame:CGRectMake(20, self.facebookBtn.blmg_bottom + 20, self.blmg_width - 40, 25)];
    self.zd31_CSKH_email.font = [YLAF_Theme_Utils khxl_color_SmallFont];
    self.zd31_CSKH_email.textColor = [YLAF_Theme_Utils khxl_color_GrayColor];
    self.zd31_CSKH_email.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"MUUQYKey_CustomerServiceMail_Text")];
    [self addSubview:self.zd31_CSKH_email];
    
    self.blmg_height = self.zd31_CSKH_email.blmg_bottom + 15;
    
    [self zd31_GetCustomerSeviceInfo];
}

- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandleCloseCustomerServiceView_Delegate:)]) {
        [_delegate zd31_HandleCloseCustomerServiceView_Delegate:self];
    }
}


- (void)zd31_showCSKHEmail:(NSString *)email  {
    if (email && email.length > 0) {
        self.zd31_CSKH_email.text = [NSString stringWithFormat:@"%@：%@",MUUQYLocalizedString(@"MUUQYKey_CustomerServiceMail_Text"), email];
    } else {
        self.zd31_CSKH_email.text = [NSString stringWithFormat:@"%@：%@",MUUQYLocalizedString(@"MUUQYKey_CustomerServiceMail_Text"), MYMGSDKGlobalInfo.customorSeviceMail?:@""];
    }
}

- (void)zd31_HandleFeedbackBtn:(id)sender {
    [self zd32_HandleClickedCloseBtn:sender];
    
    if (!self.zd31_Service_email || [self.zd31_Service_email isEmpty]) {
        [MBProgressHUD zd32_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.zd31_AccountServer zd31_GetCustomerService:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD zd32_DismissLoadingHUD];
            if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
                NSString *url = [result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"facebook_url"]];
                NSString *email = [result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"service_email"]];
                
                weakSelf.zd31_Facebook_url = url;
                weakSelf.zd31_Service_email = email;
                [weakSelf zd31_showCSKHEmail:email];
                
                [MYMGSDKGlobalInfo zd32_SendEmail:email];
            } else {
                [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
            }
        }];
    } else {
        [MYMGSDKGlobalInfo zd32_SendEmail:self.zd31_Service_email];
    }
}

- (void)zd31_HandleFacebookBtn:(id)sender {
    [self zd32_HandleClickedCloseBtn:sender];
    
    if (!self.zd31_Facebook_url || [self.zd31_Facebook_url isEmpty]) {
        [MBProgressHUD zd32_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.zd31_AccountServer zd31_GetCustomerService:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD zd32_DismissLoadingHUD];
            if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
                NSString *url = [result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"facebook_url"]];
                NSString *email = [result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"service_email"]];
                
                weakSelf.zd31_Facebook_url = url;
                weakSelf.zd31_Service_email = email;
                
                [weakSelf zd31_showCSKHEmail:email];
                
                [MYMGSDKGlobalInfo zd32_PresendWithUrlString:url];
            } else {
                [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
            }
        }];
    } else {
        [MYMGSDKGlobalInfo zd32_PresendWithUrlString:self.zd31_Facebook_url];
    }
}

- (void)zd31_GetCustomerSeviceInfo {
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_GetCustomerService:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd31_Facebook_url = [result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"facebook_url"]];
            NSString *cskh_email = [result.zd32_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"service_email"]];
            weakSelf.zd31_Service_email = cskh_email;
            [weakSelf zd31_showCSKHEmail:cskh_email];
        } else{
            [weakSelf zd31_showCSKHEmail:nil];
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

@end
