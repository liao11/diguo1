
#import "ZhenD3AccountLogin_View.h"
#import "ZhenD3Login_Server.h"
#import "ZhenD3LocalData_Server.h"
#import "KeenWireField.h"
#import "NSString+GrossExtension.h"

@interface ZhenD3AccountLogin_View () <UITableViewDelegate, UITableViewDataSource, KeenWireFieldDelegate>

@property (strong, nonatomic) UIView * zd31_inputBgView;
@property (strong, nonatomic) KeenWireField *zd32_inputAccView;
@property (strong, nonatomic) UIButton *zd31_moreBtn;
@property (strong, nonatomic) KeenWireField *zd32_inputPwdView;
@property (strong, nonatomic) UIButton *zd31_forgetPwdBtn;
@property (strong, nonatomic) UIButton *zd32_loginBtn;
@property (strong, nonatomic) UITableView *zd32_HistoryTableView;
@property (strong, nonatomic) NSMutableArray *zd32_HistoryAccounts;
@property (strong, nonatomic) ZhenD3Login_Server *zd32_LoginServer;
@property (strong, nonatomic) ZhenD3UserInfo_Entity *zd32_SelectUser;

@end

@implementation ZhenD3AccountLogin_View

- (instancetype)init {
    self = [super initWithCurType:@"0"];
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
    [self zd32_ShowBackBtn:YES];
    
    self.zd31_inputBgView = [[UIView alloc] initWithFrame:CGRectMake(35, 70, self.blmg_width-70, 100)];
    [self addSubview:self.zd31_inputBgView];
    
    self.zd32_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 0, self.zd31_inputBgView.blmg_width, 64.0f)];
    self.zd32_inputAccView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_AccountNum_Placeholder_Text");
    self.zd32_inputAccView.delegate = self;
    self.zd32_inputAccView.zd32_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.zd31_inputBgView addSubview:self.zd32_inputAccView];
    
    self.zd32_inputAccView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimageacc"];
    
    self.zd31_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_moreBtn.frame = CGRectMake(0, 0, 32, 32);
    self.zd31_moreBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [self.zd31_moreBtn setImage:[YLAF_Helper_Utils imageName:@"zdimagepush"] forState:UIControlStateNormal];
    [self.zd31_moreBtn addTarget:self action:@selector(zd32_HandleClickedHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zd32_inputAccView zd32_setRightView:self.zd31_moreBtn];
    
    self.zd32_inputPwdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.zd32_inputAccView.blmg_bottom + 5, self.zd31_inputBgView.blmg_width, 64.0f)];
    self.zd32_inputPwdView.zd32_TextField.placeholder = MUUQYLocalizedString(@"MUUQYKey_Password_Placeholder_Text");
    self.zd32_inputPwdView.zd32_TextField.secureTextEntry = YES;
    self.zd32_inputPwdView.delegate = self;
    [self.zd31_inputBgView addSubview:self.zd32_inputPwdView];
    self.zd31_inputBgView.blmg_height = self.zd32_inputPwdView.blmg_bottom;
    
    self.zd32_inputPwdView.zd32_fieldLeftIcon.image = [YLAF_Helper_Utils imageName:@"zdimagepwd"];
    
    self.zd31_forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd31_forgetPwdBtn.frame = CGRectMake(0, self.zd31_inputBgView.blmg_bottom + 5, 120, 25);
    self.zd31_forgetPwdBtn.blmg_right = self.zd31_inputBgView.blmg_right;
    self.zd31_forgetPwdBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd31_forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.zd31_forgetPwdBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ForgetPassword_Text") forState:UIControlStateNormal];
    [self.zd31_forgetPwdBtn setTitleColor:[YLAF_Theme_Utils khxl_color_GrayColor] forState:UIControlStateNormal];
    [self.zd31_forgetPwdBtn addTarget:self action:@selector(zd32_HandleClickedForgetPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd31_forgetPwdBtn];
    
    self.zd32_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd32_loginBtn.tag = 100;
    self.zd32_loginBtn.frame = CGRectMake(0, self.zd31_forgetPwdBtn.blmg_bottom + 10, 127, 35);
    self.zd32_loginBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_loginBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    self.zd32_loginBtn.layer.cornerRadius = 5.0;
    self.zd32_loginBtn.layer.masksToBounds = YES;
    [self.zd32_loginBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_Login_Text") forState:UIControlStateNormal];
    [self.zd32_loginBtn addTarget:self action:@selector(zd32_HandleClickedLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd32_loginBtn];
    
    [self.zd32_loginBtn sizeToFit];
    self.zd32_loginBtn.blmg_size = CGSizeMake(MAX(self.zd32_loginBtn.blmg_width + 30, 127), 35);
    self.zd32_loginBtn.blmg_centerX = self.zd31_inputBgView.blmg_centerX;
    
    self.zd32_HistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.zd31_inputBgView.blmg_left, self.zd31_inputBgView.blmg_top + self.zd32_inputAccView.blmg_height-3, self.zd32_inputAccView.blmg_width, 92) style:UITableViewStylePlain];
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

- (void)zd32_SetupDatas {
    NSArray *historyAccounts = [ZhenD3LocalData_Server zd32_loadAllSavedLoginedUser];
    self.zd32_HistoryAccounts = [[NSMutableArray alloc] initWithCapacity:historyAccounts.count];
    for (ZhenD3UserInfo_Entity *user in [historyAccounts reverseObjectEnumerator]) {
        if (user.accountType == YLAF_AccountTypeMuu) {
            [self.zd32_HistoryAccounts addObject:user];
        }
    }
    ZhenD3UserInfo_Entity *lastLoginUser = self.zd32_HistoryAccounts.firstObject;
    self.zd32_SelectUser = lastLoginUser;
    self.zd32_inputAccView.zd32_TextField.text = lastLoginUser.userName;
    self.zd32_inputPwdView.zd32_TextField.text = lastLoginUser?[NSString stringWithFormat:@"%@",@"********"]:@"";
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


- (void)zd32_HandleClickedForgetPwdBtn:(id)sender {
    [self zd31_HiddenHistoryTable];
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd33_ForgetPwdAtLoginView:)]) {
        [self.delegate zd33_ForgetPwdAtLoginView:self];
    }
}

- (void)zd32_HandleClickedLoginBtn:(id)sender {
    [self zd31_HiddenHistoryTable];
    NSString *account = _zd32_inputAccView.zd32_TextField.text;
    NSString *password = _zd32_inputPwdView.zd32_TextField.text;
    
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
            weakSelf.zd32_inputPwdView.zd32_TextField.text = @"";
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
    if (sender.tag - 1 < self.zd32_HistoryAccounts.count) {
        ZhenD3UserInfo_Entity *user = self.zd32_HistoryAccounts[sender.tag - 1];
        [self.zd32_HistoryAccounts removeObject:user];
        
        [ZhenD3LocalData_Server zd32_removeLoginedUserInfoFormHistory:user];
    }
    
    [self.zd32_HistoryTableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self zd31_HiddenHistoryTable];
    
    self.zd32_SelectUser = self.zd32_HistoryAccounts[indexPath.row];
    
    self.zd32_inputAccView.zd32_TextField.text = self.zd32_SelectUser.userName;
    self.zd32_inputPwdView.zd32_TextField.text = (self.zd32_HistoryAccounts.count>0)?[NSString stringWithFormat:@"%@",@"********"]:@"";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.zd32_HistoryAccounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",@"HistoryAccountCell"] forIndexPath:indexPath];
    [cell.contentView blmg_removeAllSubviews];
    
    ZhenD3UserInfo_Entity *user = self.zd32_HistoryAccounts[indexPath.row];
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
    delBtn.frame = CGRectMake(cell.blmg_width - cell.blmg_height/2, cell.blmg_height/4, cell.blmg_height/2, cell.blmg_height/2);
    [delBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageshan"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(zd32_HandleClickedDelHistoryAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:delBtn];
    
    return cell;
}


- (BOOL)zd32_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    self.zd32_SelectUser = nil;
    if (inputView == self.zd32_inputAccView) {
        [self.zd32_inputPwdView.zd32_TextField becomeFirstResponder];
    } else if (inputView == self.zd32_inputPwdView) {
        
    }
    return YES;
}

- (void)zd32_InputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    self.zd32_SelectUser = nil;
    if (inputView == self.zd32_inputAccView) {
        self.zd32_inputPwdView.zd32_TextField.text = @"";
    }
}
@end
