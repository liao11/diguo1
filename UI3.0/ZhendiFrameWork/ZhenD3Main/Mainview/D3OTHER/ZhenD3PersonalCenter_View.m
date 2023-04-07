
#import "ZhenD3PersonalCenter_View.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3Account_Server.h"
#import "NSString+GrossExtension.h"
@interface ZhenD3PersonalCenter_View ()

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) UILabel *zd31_AccountLab;
@property (nonatomic, strong) UILabel *zd31_EmailLab;
@property (nonatomic, strong) UILabel *zd32_telNumLab;
@property (nonatomic, strong) UILabel *blmg_accCountLab;
@property (nonatomic, strong) UILabel *zd31_LevelLab;
@property (nonatomic, strong) UILabel *zd31_IntegralLab;
@property (nonatomic, strong) UIButton *zd31_BindBtn;

@end

@implementation ZhenD3PersonalCenter_View

- (instancetype)init {
    if (self = [super initWithCurType:@"1"]) {
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
    self.title = MUUQYLocalizedString(@"MUUQYKey_PersonCenter_Text");
    [self zd32_ShowBackBtn:YES];
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(30, 55, self.blmg_width - 60, 180)];
    [self addSubview:inputBgView];
    
    CGFloat titleWidth = 80;
    
    UILabel *accLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, 25)];
    accLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    accLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    accLab.textAlignment = NSTextAlignmentRight;
    accLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"MUUQYKey_AccountNumber_Text")];
    [inputBgView addSubview:accLab];
    
    self.zd31_AccountLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 5, accLab.blmg_top, inputBgView.blmg_width - titleWidth - 5, 25)];
    self.zd31_AccountLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd31_AccountLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    [inputBgView addSubview:self.zd31_AccountLab];
    
    UILabel *bindEmailLab = [[UILabel alloc] initWithFrame:CGRectMake(0, accLab.blmg_bottom + 10, titleWidth, 25)];
    bindEmailLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    bindEmailLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    bindEmailLab.textAlignment = NSTextAlignmentRight;
    bindEmailLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"MUUQYKey_BindEmail_Text")];
    [inputBgView addSubview:bindEmailLab];

    self.zd31_EmailLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 5, bindEmailLab.blmg_top, inputBgView.blmg_width - titleWidth - 5, 25)];
    self.zd31_EmailLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd31_EmailLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    [inputBgView addSubview:self.zd31_EmailLab];
    
    UILabel *zd33_tel = [[UILabel alloc] initWithFrame:CGRectMake(0, bindEmailLab.blmg_bottom + 10, titleWidth, 25)];
    zd33_tel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    zd33_tel.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    zd33_tel.textAlignment = NSTextAlignmentRight;
    zd33_tel.text = [NSString stringWithFormat:@"%@:",MUUQYLocalizedString(@"MUUQYKey_WordTel")];
    [inputBgView addSubview:zd33_tel];

    self.zd32_telNumLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 5, zd33_tel.blmg_top, inputBgView.blmg_width - titleWidth - 5, 25)];
    self.zd32_telNumLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_telNumLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    [inputBgView addSubview:self.zd32_telNumLab];
    
    UILabel *zd3_acc = [[UILabel alloc] initWithFrame:CGRectMake(0, zd33_tel.blmg_bottom + 10, titleWidth, 25)];
    zd3_acc.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    zd3_acc.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    zd3_acc.textAlignment = NSTextAlignmentRight;
    zd3_acc.text = [NSString stringWithFormat:@"%@",MUUQYLocalizedString(@"MUUQYKey_expWord")];
    [inputBgView addSubview:zd3_acc];

    self.blmg_accCountLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 5, zd3_acc.blmg_top, inputBgView.blmg_width - titleWidth - 5, 25)];
    self.blmg_accCountLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.blmg_accCountLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    [inputBgView addSubview:self.blmg_accCountLab];
    
    UILabel *levelLab = [[UILabel alloc] initWithFrame:CGRectMake(0, zd3_acc.blmg_bottom + 10, titleWidth, 25)];
    levelLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    levelLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    levelLab.textAlignment = NSTextAlignmentRight;
    levelLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"MUUQYKey_AccountLevel_Text")];
    [inputBgView addSubview:levelLab];
    
    self.zd31_LevelLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 5, levelLab.blmg_top, inputBgView.blmg_width - titleWidth - 5, 25)];
    self.zd31_LevelLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd31_LevelLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    [inputBgView addSubview:self.zd31_LevelLab];
    
    UILabel *integralLab = [[UILabel alloc] initWithFrame:CGRectMake(0, levelLab.blmg_bottom + 10, titleWidth, 25)];
    integralLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    integralLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    integralLab.textAlignment = NSTextAlignmentRight;
    integralLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"MUUQYKey_AccountIntegral_Text")];
    [inputBgView addSubview:integralLab];
    
    self.zd31_IntegralLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 5, integralLab.blmg_top, inputBgView.blmg_width - titleWidth - 5, 25)];
    self.zd31_IntegralLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd31_IntegralLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    [inputBgView addSubview:self.zd31_IntegralLab];
    
    inputBgView.blmg_height = integralLab.blmg_bottom;
    
    UIButton *bindEmailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bindEmailBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    bindEmailBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    bindEmailBtn.layer.cornerRadius = 5.0;
    bindEmailBtn.layer.masksToBounds = YES;
    [bindEmailBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_BindEmail_Text") forState:UIControlStateNormal];
    [bindEmailBtn addTarget:self action:@selector(zd31_HandleClickedBindEmailBtn:) forControlEvents:UIControlEventTouchUpInside];
    [inputBgView addSubview:bindEmailBtn];
    [bindEmailBtn sizeToFit];
    bindEmailBtn.blmg_size = CGSizeMake(bindEmailBtn.blmg_width + 20, 30);
    bindEmailBtn.blmg_right = inputBgView.blmg_width;
    bindEmailBtn.blmg_centerY = bindEmailLab.blmg_centerY;
    self.zd31_BindBtn = bindEmailBtn;
    
    self.blmg_height = inputBgView.blmg_bottom + 25;
    
    [self zd32_u_UpdateInterfaceWithData:nil];
    [self zd31_GetUserInfo];
}

- (void)zd32_u_UpdateInterfaceWithData:(NSDictionary *)data {
    NSString *_account = MYMGSDKGlobalInfo.userInfo.userName;
    NSString *_bindEmail = @"";
    NSString *_level = @"0";
    NSString *_integral = @"0";
    NSString *_tel = @"";
    NSString *_exp = @"0";
    
    if (data && data.count > 0) {
        _account = [data objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
        _bindEmail = [data objectForKey:[NSString stringWithFormat:@"%@",@"bind_email"]];
        _level = [data objectForKey:[NSString stringWithFormat:@"%@",@"user_level"]];
        _integral = [data objectForKey:[NSString stringWithFormat:@"%@",@"user_points"]];
        _tel = [data objectForKey:[NSString stringWithFormat:@"%@",@"mobile"]];
        _exp = [data objectForKey:[NSString stringWithFormat:@"%@",@"user_exp"]];
        if (!_bindEmail || [_bindEmail isEmpty]) {
            _bindEmail = MUUQYLocalizedString(@"MUUQYKey_AccountNoBind_Text");
        }
    }
    
    if (MYMGSDKGlobalInfo.userInfo.accountType != YLAF_AccountTypeMuu) {
        _account = MYMGSDKGlobalInfo.userInfo.userID;
    }
    
    self.zd31_BindBtn.hidden = MYMGSDKGlobalInfo.userInfo.isBindEmail;
    
    self.zd31_AccountLab.text = _account;
    self.zd31_EmailLab.text = _bindEmail;
    self.zd31_LevelLab.text = _level;
    self.zd32_telNumLab.text = _tel;
    self.zd31_IntegralLab.text = _integral;
    self.blmg_accCountLab.text = _exp;
}

- (void)zd31_GetUserInfo {
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_GetUserInfo:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        [weakSelf zd32_u_UpdateInterfaceWithData:result.zd32_responeResult];
        
        if (result.zd32_responseCode != YLAF_ResponseCodeSuccess) {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}


- (void)zd32_HandleClickedBackBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_handleClosePersonalCenter_Delegate:)]) {
        [_delegate zd31_handleClosePersonalCenter_Delegate:self];
    }
}


- (void)zd31_HandleClickedBindEmailBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_handleBindEmailInPersonalCenter_Delegate:)]) {
        [_delegate zd31_handleBindEmailInPersonalCenter_Delegate:self];
    }
}

@end
