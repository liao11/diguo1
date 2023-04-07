
#import "ZhenD3Login_View.h"
#import "KeenWireField.h"
#import "ZhenD3Login_Server.h"
#import "ZhenD3LocalData_Server.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3TelDataServer.h"
#define YLAF_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define YLAF_RGB(r,g,b)          YLAF_RGBA(r,g,b,1.0f)
@interface ZhenD3Login_View () <UITableViewDelegate, UITableViewDataSource, KeenWireFieldDelegate>

@property (strong, nonatomic) UIView *zd33_viewBg;
@property (nonatomic, assign) NSInteger zd3_type;
@property (nonatomic, strong) UISegmentedControl *zd32_segment;
@property (strong, nonatomic) KeenWireField *zd32_inputTxtView;
@property (strong, nonatomic) UIButton *zd31_moreBtn;
@property (strong, nonatomic) KeenWireField *zd32_inputPsdView;
@property (strong, nonatomic) UIButton *zd31_fgtPsdBtn;
@property (strong, nonatomic) UIButton *zd31_loginBtn;
@property (strong, nonatomic) UITableView *zd32_HistoryTableView;
@property (strong, nonatomic) NSMutableArray *zd32_HistoryAccounts;
@property (strong, nonatomic) NSMutableArray *blmg_historyTelUser;
@property (strong, nonatomic) ZhenD3Login_Server *zd32_LoginServer;
@property (strong, nonatomic) ZhenD3UserInfo_Entity *zd32_SelectUser;

@end

@implementation ZhenD3Login_View

- (instancetype)init {
    self = [super initWithCurType:@"1"];
    if (self) {
        [self zd32_setupViews];
    }
    return self;
}


- (ZhenD3Login_Server *)zd32_LoginServer {
    if (!_zd32_LoginServer) {
        _zd32_LoginServer = [[ZhenD3Login_Server alloc] init];
    }
    return _zd32_LoginServer;
}


- (void)zd32_setupViews {
    
    self.zd3_type = 0;
    
    [self zd32_ShowBackBtn:YES];
        
    self.zd33_viewBg = [[UIView alloc] initWithFrame:CGRectMake(35, 60, self.blmg_width-70, 137)];
    [self addSubview:self.zd33_viewBg];
    
    self.zd32_segment = [[UISegmentedControl alloc] initWithItems:@[MUUQYLocalizedString(@"MUUQYKey_Email_Text"), MUUQYLocalizedString(@"MUUQYKey_WordTel")]];
    self.zd32_segment.tintColor = YLAF_RGB(255, 135, 101);
    [self.zd32_segment setBackgroundColor:YLAF_RGB(243, 243, 243)];
    NSDictionary *zd32_atru = [NSDictionary dictionaryWithObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
    [self.zd32_segment setTitleTextAttributes:zd32_atru forState:UIControlStateNormal];
    if (@available(iOS 13.0, *)) {
        self.zd32_segment.selectedSegmentTintColor =  YLAF_RGB(255, 135, 101);
    } else {
        
    }
    
    self.zd32_segment.frame = CGRectMake(30, 0, self.zd33_viewBg.blmg_width-60, 30);
    [self.zd32_segment addTarget:self action:@selector(zd31_SegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.zd32_segment.selectedSegmentIndex = 0;
    self.zd32_segment.tag = 200;
    [self.zd33_viewBg addSubview:self.zd32_segment];
    
    self.zd32_inputTxtView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 45, self.zd33_viewBg.blmg_width, 40)];
    self.zd32_inputTxtView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_AccountNum_Placeholder_Text");
    self.zd32_inputTxtView.delegate = self;
    self.zd32_inputTxtView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.zd33_viewBg addSubview:self.zd32_inputTxtView];
    
    self.zd32_inputTxtView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageacc"];
    
    self.zd31_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_moreBtn.frame = CGRectMake(0, 0, 32, 32);
    self.zd31_moreBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [self.zd31_moreBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagepush"] forState:UIControlStateNormal];
    [self.zd31_moreBtn addTarget:self action:@selector(zd32_HandleClickedHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd32_inputTxtView zd32_setRightView:self.zd31_moreBtn];
    
    self.zd32_inputPsdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd32_inputTxtView.blmg_bottom + 12, self.zd33_viewBg.blmg_width, 40)];
    self.zd32_inputPsdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Password_Placeholder_Text");
    self.zd32_inputPsdView.zd32_TextField.secureTextEntry = YES;
    self.zd32_inputPsdView.delegate = self;
    [self.zd33_viewBg addSubview:self.zd32_inputPsdView];
    self.zd33_viewBg.blmg_height = self.zd32_inputPsdView.blmg_bottom;
    
    self.zd32_inputPsdView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageresetPwd"];
    
    
    self.zd31_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_loginBtn.tag = 100;
    self.zd31_loginBtn.frame = CGRectMake(35, self.zd33_viewBg.blmg_bottom + 15, self.zd33_viewBg.blmg_width, 40);
    self.zd31_loginBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    [self.zd31_loginBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_Login_Text") forState:UIControlStateNormal];
    [self.zd31_loginBtn setBackgroundColor:YLAF_RGB(255, 135, 101)];
    self.zd31_loginBtn.layer.cornerRadius = 20;
    self.zd31_loginBtn.clipsToBounds = true;
    [self.zd31_loginBtn addTarget:self action:@selector(zd32_HandleClickedlogBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd31_loginBtn];
    
    
    self.zd31_fgtPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_fgtPsdBtn.frame = CGRectMake(0, self.zd31_loginBtn.blmg_bottom + 10, 120, 33);
    self.zd31_fgtPsdBtn.titleLabel.font = [YLAF_Theme_Utils khxl_FontSize13];
    self.zd31_fgtPsdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.zd31_fgtPsdBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ForgetPassword_Text") forState:UIControlStateNormal];
    [self.zd31_fgtPsdBtn setTitleColor:[YLAF_Theme_Utils khxl_SmallGrayColor] forState:UIControlStateNormal];
    [self.zd31_fgtPsdBtn addTarget:self action:@selector(zd32_HandleClickedfgtPsdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd31_fgtPsdBtn];
    
    [self.zd31_fgtPsdBtn sizeToFit];
    self.zd31_fgtPsdBtn.blmg_size = CGSizeMake(MAX(self.zd31_fgtPsdBtn.blmg_width + 20, 128), 33);
    self.zd31_fgtPsdBtn.blmg_centerX = self.zd33_viewBg.blmg_centerX;
    
    self.zd32_HistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.zd33_viewBg.blmg_left, self.zd33_viewBg.blmg_top + self.zd32_inputTxtView.blmg_height -3 + 45, self.zd32_inputTxtView.blmg_width, 92) style:UITableViewStylePlain];
    self.zd32_HistoryTableView.hidden = YES;
    self.zd32_HistoryTableView.delegate = self;
    self.zd32_HistoryTableView.dataSource = self;
    self.zd32_HistoryTableView.tableFooterView = [UIView new];
    self.zd32_HistoryTableView.layer.borderWidth = YLAF_1_PIXEL_SIZE;
    self.zd32_HistoryTableView.layer.borderColor = [YLAF_Theme_Utils khxl_color_LineColor].CGColor;
    [self.zd32_HistoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@",@"HistoryAccountCell"]];
    [self addSubview:self.zd32_HistoryTableView];
    
    [self zd32_SetupDatas];
}

- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    [self zd31_HiddenHistoryTable];
    switch (seg.selectedSegmentIndex) {
            //对应placeholder要更改
        case 0:
        {
            self.zd3_type = 0;
            self.zd32_inputTxtView.zd3_tel = false;
            self.zd32_inputTxtView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_AccountNum_Placeholder_Text");
            self.zd32_inputPsdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Password_Placeholder_Text");
            [self zd32_SetupDatas];
        }
            break;
        default:
        {
            self.zd3_type = 1;
            self.zd32_inputTxtView.zd3_tel = true;
            self.zd32_inputTxtView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_pleaseTel");
            self.zd32_inputPsdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Password_Placeholder_Text");
            [self zd32_SetupDatas];
        }
            break;
    }
    
    
    
}

- (void)zd32_SetupDatas {
    NSMutableArray *historyAccounts;
    if (self.zd3_type == 0) {
        historyAccounts = [NSMutableArray arrayWithArray:[ZhenD3LocalData_Server zd32_loadAllSavedLoginedUser]];
        self.zd32_HistoryAccounts = [[NSMutableArray alloc] initWithCapacity:historyAccounts.count];
    }
    else{
        historyAccounts = [NSMutableArray arrayWithArray:[ZhenD3TelDataServer zd32_loadAllSavedLoginedUser]];
        self.blmg_historyTelUser = [[NSMutableArray alloc] initWithCapacity:historyAccounts.count];
    }
    
    self.zd32_inputTxtView.zd32_TextField.text = @"";
    self.zd32_inputPsdView.zd32_TextField.text = @"";
    for (ZhenD3UserInfo_Entity *user in [historyAccounts reverseObjectEnumerator]) {
        if (self.zd3_type == 0) {
            if (user.accountType == YLAF_AccountTypeMuu) {
                [self.zd32_HistoryAccounts addObject:user];
                ZhenD3UserInfo_Entity *lastLoginUser = self.zd32_HistoryAccounts.firstObject;
                self.zd32_SelectUser = lastLoginUser;
                self.zd32_inputTxtView.zd32_TextField.text = lastLoginUser.userName;
                self.zd32_inputPsdView.zd32_TextField.text = lastLoginUser?[NSString stringWithFormat:@"%@",@"********"]:@"";
            }
        }
        else{
            [self.blmg_historyTelUser addObject:user];
            ZhenD3UserInfo_Entity *lastLoginUser = self.blmg_historyTelUser.firstObject;
            self.zd32_SelectUser = lastLoginUser;
            self.zd32_inputTxtView.zd32_TextField.text = lastLoginUser.userName;
            self.zd32_inputPsdView.zd32_TextField.text = lastLoginUser?[NSString stringWithFormat:@"%@",@"********"]:@"";
        }
        
    }
    
    [self.zd32_HistoryTableView reloadData];
    
}

- (void)zd31_HiddenHistoryTable {
    if (self.zd32_HistoryTableView.hidden != YES) {
        [UIView animateWithDuration:0.25 animations:^{
            self.zd32_HistoryTableView.blmg_height = 0;
        } completion:^(BOOL finished) {
            self.zd32_HistoryTableView.hidden = YES;
        }];
    }
}

- (void)zd32_u_ShowHistoryTable {
    if (self.zd32_HistoryTableView.hidden == YES) {
        self.zd32_HistoryTableView.hidden = NO;
        self.zd32_HistoryTableView.blmg_height = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.zd32_HistoryTableView.blmg_height = 90;
        }];
    }
}


- (void)zd32_HandleClickedBackBtn:(id)sender {
    [self zd31_HiddenHistoryTable];
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd33_CloseAccountLoginView:loginSucess:)]) {
        [self.delegate zd33_CloseAccountLoginView:self loginSucess:NO];
    }
}


- (void)zd32_HandleClickedfgtPsdBtn:(id)sender {
    [self zd31_HiddenHistoryTable];
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd33_ForgetPwdAtLoginView:)]) {
        [self.delegate zd33_ForgetPwdAtLoginView:self];
    }
}

- (void)zd32_HandleClickedlogBtn:(id)sender {
    [self zd31_HiddenHistoryTable];
    NSString *account = _zd32_inputTxtView.zd32_TextField.text;
    NSString *password = _zd32_inputPsdView.zd32_TextField.text;
    
    if (!account || [account isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_AccountNum_Miss_Alert_Text")];
        return;
    }
    if (!password || [password isEmpty]) {
        [MBProgressHUD zd32_showError_Toast:MUUQYLocalizedString(@"MUUQYKey_Password_Miss_Alert_Text")];
        return;
    }
    
    if (self.zd32_SelectUser) {
        password = self.zd32_SelectUser.password;
    } else {
        password = [[password hash_md5] uppercaseString];
    }
    
    if (self.zd3_type == 0) {
        [self zd31_emailLoginWithAccount:account password:password];
    }else{
        [self blmg_telLoginWithAccount:account password:password zd32_telDist:MUUQYLocalizedString(@"MUUQYKey_nowDist")];
    }
}

- (void)zd31_emailLoginWithAccount:(NSString *)account password:(NSString *)password
{
    
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd32_LoginServer lhxy_DeviceActivate:account md5Password:password responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_CloseAccountLoginView:loginSucess:)]) {
                [weakSelf.delegate zd33_CloseAccountLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            weakSelf.zd32_inputPsdView.zd32_TextField.text = @"";
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)blmg_telLoginWithAccount:(NSString *)account password:(NSString *)password zd32_telDist:(NSString *)zd32_telDist
{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd32_LoginServer lhxy_telLogin:account md5Password:password zd32_telDist:zd32_telDist responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        
        [MBProgressHUD zd32_DismissLoadingHUD];
        
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_CloseAccountLoginView:loginSucess:)]) {
                [weakSelf.delegate zd33_CloseAccountLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            weakSelf.zd32_inputPsdView.zd32_TextField.text = @"";
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd32_HandleClickedHistoryBtn:(id)sender {
    if (self.zd32_HistoryTableView.hidden) {
        [self zd32_u_ShowHistoryTable];
        [self.zd32_HistoryTableView reloadData];
    } else {
        [self zd31_HiddenHistoryTable];
    }
}

- (void)zd32_HandleClickedDelHistoryAccountBtn:(UIButton *)sender {
    if (self.zd3_type == 0) {
        if (sender.tag - 1 < self.zd32_HistoryAccounts.count) {
            ZhenD3UserInfo_Entity *user = self.zd32_HistoryAccounts[sender.tag - 1];
            [self.zd32_HistoryAccounts removeObject:user];
            
            [ZhenD3LocalData_Server zd32_removeLoginedUserInfoFormHistory:user];
        }
    }else{
        if (sender.tag - 1 < self.blmg_historyTelUser.count) {
            ZhenD3UserInfo_Entity *user = self.blmg_historyTelUser[sender.tag - 1];
            [self.blmg_historyTelUser removeObject:user];
            
            [ZhenD3TelDataServer zd32_removeLoginedUserInfoFormHistory:user];
        }
    }
    
    
    [self.zd32_HistoryTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self zd31_HiddenHistoryTable];
    
    if (self.zd3_type == 0) {
        self.zd32_SelectUser = self.zd32_HistoryAccounts[indexPath.row];
        self.zd32_inputTxtView.zd32_TextField.text = self.zd32_SelectUser.userName;
        self.zd32_inputPsdView.zd32_TextField.text = (self.zd32_HistoryAccounts.count>0)?[NSString stringWithFormat:@"%@",@"********"]:@"";
    }else{
        self.zd32_SelectUser = self.blmg_historyTelUser[indexPath.row];
        self.zd32_inputTxtView.zd32_TextField.text = self.zd32_SelectUser.userName;
        self.zd32_inputPsdView.zd32_TextField.text = (self.blmg_historyTelUser.count>0)?[NSString stringWithFormat:@"%@",@"********"]:@"";
    }
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.zd3_type == 0) {
        return self.zd32_HistoryAccounts.count;
    }else
        return self.blmg_historyTelUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",@"HistoryAccountCell"] forIndexPath:indexPath];
    [cell.contentView blmg_removeAllSubviews];
    
    ZhenD3UserInfo_Entity *user;
    if (self.zd3_type == 0) {
        user = self.zd32_HistoryAccounts[indexPath.row];
    }else{
        user = self.blmg_historyTelUser[indexPath.row];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, cell.blmg_width - cell.blmg_height - 15, cell.blmg_height)];
    if (user.accountType == YLAF_AccountTypeMuu) {
        lab.text = user.userName;
    } else {
        lab.text = user.userID;
    }
    lab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    [cell.contentView addSubview:lab];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.tag = indexPath.row + 1;
    delBtn.frame = CGRectMake(cell.blmg_width - cell.blmg_height/2, cell.blmg_height/4, cell.blmg_height/4, cell.blmg_height/4);
    [delBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageshan"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(zd32_HandleClickedDelHistoryAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:delBtn];
    
    return cell;
}


- (BOOL)zd32_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    self.zd32_SelectUser = nil;
    if (inputView == self.zd32_inputTxtView) {
        [self.zd32_inputPsdView.zd32_TextField becomeFirstResponder];
    } else if (inputView == self.zd32_inputPsdView) {
        
    }
    return YES;
}

- (void)zd32_InputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    self.zd32_SelectUser = nil;
    if (inputView == self.zd32_inputTxtView) {
        self.zd32_inputPsdView.zd32_TextField.text = @"";
    }
}

@end
