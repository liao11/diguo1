
#import "ZhenD3PresentPackage_View.h"
#import "ZhenD3AllPresentListCell_View.h"
#import "ZhenD3MyPresentCell_View.h"
#import "YLAF_Progress_View.h"
#import "ZhenD3Account_Server.h"

@interface ZhenD3PresentPackage_View () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *zd31_PresentListView;
@property (nonatomic, strong) UIView *zd31_PresentDetailView;
@property (nonatomic, strong) UIView *zd31_GetPresentSuccessView;
@property (nonatomic, strong) UIImageView *zd31_NodataView;

@property (nonatomic, strong) UITableView *zd31_all_Present_tableView;
@property (nonatomic, strong) UITableView *zd31_my_present_tableView;

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) NSArray *zd31_all_Presents;
@property (nonatomic, strong) NSArray *zd31_my_Presents;
@property (nonatomic, strong) NSDictionary *zd31_select_present;
@end

@implementation ZhenD3PresentPackage_View

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

- (void)zd31_GetAllPresentList {
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_GetAllPresent:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd31_all_Presents = (NSArray *)result.zd32_responeResult;
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
        [weakSelf.zd31_all_Present_tableView reloadData];
        weakSelf.zd31_NodataView.hidden = weakSelf.zd31_all_Presents.count > 0;
    }];
}

- (void)zd31_GetMyPresentList {
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_GetMyPresents:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd31_my_Presents = (NSArray *)result.zd32_responeResult;
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
        [weakSelf.zd31_my_present_tableView reloadData];
        weakSelf.zd31_NodataView.hidden = weakSelf.zd31_my_Presents.count > 0;
    }];
}


- (void)zd32_setupViews {
    self.title = MUUQYLocalizedString(@"MUUQYKey_PresentCollection_Text");
    
    [self zd32_ShowCloseBtn:YES];
    
    [self addSubview:self.zd31_PresentListView];
    
    [self zd31_GetAllPresentList];
}

- (UIView *)zd31_PresentListView {
    if (!_zd31_PresentListView) {
        _zd31_PresentListView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.blmg_width - 70, self.blmg_height - 55 - 25)];
        
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[MUUQYLocalizedString(@"MUUQYKey_AllPresent_Text"), MUUQYLocalizedString(@"MUUQYKey_MyPresent_Text")]];
        segment.tintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
        [segment setBackgroundColor:[YLAF_Theme_Utils khxl_color_headBgColor]];
        NSDictionary *zd32_atru = [NSDictionary dictionaryWithObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
        [segment setTitleTextAttributes:zd32_atru forState:UIControlStateNormal];
        if (@available(iOS 13.0, *)) {
            segment.selectedSegmentTintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
        } else {
            
        }
        
        segment.frame = CGRectMake(0, 0, _zd31_PresentListView.blmg_width, 30);
        [segment addTarget:self action:@selector(zd31_SegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        segment.selectedSegmentIndex = 0;
        segment.tag = 100;
        [_zd31_PresentListView addSubview:segment];
        
        self.zd31_all_Present_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segment.blmg_bottom, _zd31_PresentListView.blmg_width, _zd31_PresentListView.blmg_height - segment.blmg_bottom) style:UITableViewStylePlain];
        self.zd31_all_Present_tableView.backgroundColor = [UIColor clearColor];
        
        self.zd31_all_Present_tableView.delegate = self;
        self.zd31_all_Present_tableView.dataSource = self;
        self.zd31_all_Present_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.zd31_all_Present_tableView.tableFooterView = [UIView new];
        [self.zd31_all_Present_tableView registerClass:[ZhenD3AllPresentListCell_View class] forCellReuseIdentifier:NSStringFromClass([ZhenD3AllPresentListCell_View class])];
        [_zd31_PresentListView addSubview:self.zd31_all_Present_tableView];
        
        self.zd31_my_present_tableView = [[UITableView alloc] initWithFrame:self.zd31_all_Present_tableView.frame style:UITableViewStylePlain];
        self.zd31_my_present_tableView.backgroundColor = [UIColor clearColor];
        self.zd31_my_present_tableView.hidden = YES;
        self.zd31_my_present_tableView.delegate = self;
        self.zd31_my_present_tableView.dataSource = self;
        self.zd31_my_present_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.zd31_my_present_tableView.tableFooterView = [UIView new];
        [self.zd31_my_present_tableView registerClass:[ZhenD3MyPresentCell_View class] forCellReuseIdentifier:NSStringFromClass([ZhenD3MyPresentCell_View class])];
        [_zd31_PresentListView addSubview:self.zd31_my_present_tableView];
        
        self.zd31_NodataView.frame = self.zd31_all_Present_tableView.frame;
    }
    return _zd31_PresentListView;
}

- (UIView *)zd31_PresentDetailView {
    if (!_zd31_PresentDetailView) {
        _zd31_PresentDetailView = [[UIView alloc] initWithFrame:CGRectMake(20, 55, self.blmg_width - 40, self.blmg_height - 75)];
        _zd31_PresentDetailView.layer.cornerRadius = 8;
        _zd31_PresentDetailView.clipsToBounds = true;
        _zd31_PresentDetailView.backgroundColor = [YLAF_Theme_Utils khxl_color_headBgColor];
            
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, _zd31_PresentDetailView.blmg_width, 15)];
        titleLab.font = [YLAF_Theme_Utils khxl_color_LargeFont];
        titleLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        titleLab.text = MUUQYLocalizedString(@"MUUQYKey_PresentName_Text");
        titleLab.tag = 101;
        [_zd31_PresentDetailView addSubview:titleLab];
        
        YLAF_Progress_View *zd31_present_progressView = [[YLAF_Progress_View alloc] initWithFrame:CGRectMake(15, titleLab.blmg_bottom + 10, 150, 6)];
        zd31_present_progressView.progress = 0.5;
        zd31_present_progressView.tag = 102;
        [_zd31_PresentDetailView addSubview:zd31_present_progressView];
        
        UILabel *zd31_present_surplusLab = [[UILabel alloc] initWithFrame:CGRectMake(_zd31_PresentDetailView.blmg_width-165, zd31_present_progressView.blmg_top - 7, 150, 20)];
        zd31_present_surplusLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        zd31_present_surplusLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_present_surplusLab.textAlignment = NSTextAlignmentRight;
        zd31_present_surplusLab.tag = 103;
        [_zd31_PresentDetailView addSubview:zd31_present_surplusLab];
        
        UILabel *zd31_present_contentLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, _zd31_PresentDetailView.blmg_width - 30, 60)];
        zd31_present_contentLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        zd31_present_contentLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_present_contentLab.numberOfLines = 0;
        zd31_present_contentLab.tag = 104;
        [_zd31_PresentDetailView addSubview:zd31_present_contentLab];
        
        UILabel *zd31_present_conditionLab = [[UILabel alloc] initWithFrame:CGRectMake(15, zd31_present_contentLab.blmg_bottom + 5, _zd31_PresentDetailView.blmg_width - 30, 25)];
        zd31_present_conditionLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        zd31_present_conditionLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_present_conditionLab.numberOfLines = 0;
        zd31_present_conditionLab.tag = 105;
        [_zd31_PresentDetailView addSubview:zd31_present_conditionLab];
        
        UILabel *expirationLab = [[UILabel alloc] initWithFrame:CGRectMake(15, zd31_present_conditionLab.blmg_bottom + 5, _zd31_PresentDetailView.blmg_width - 30, 25)];
        expirationLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        expirationLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        expirationLab.tag = 106;
        [_zd31_PresentDetailView addSubview:expirationLab];
            
        UIButton *zd33_present_GetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zd33_present_GetBtn.frame = CGRectMake(0, expirationLab.blmg_bottom + 15, 120, 34);
        zd33_present_GetBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        zd33_present_GetBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
        zd33_present_GetBtn.layer.cornerRadius = 17.0;
        zd33_present_GetBtn.layer.masksToBounds = YES;
        [zd33_present_GetBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_GetPresent_Text") forState:UIControlStateNormal];
        [zd33_present_GetBtn addTarget:self action:@selector(zd31_HandleClickedGetPresentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_zd31_PresentDetailView addSubview:zd33_present_GetBtn];
        
        [zd33_present_GetBtn sizeToFit];
        zd33_present_GetBtn.blmg_size = CGSizeMake(MAX(zd33_present_GetBtn.blmg_width + 30, 127), 35);
        zd33_present_GetBtn.blmg_centerX = _zd31_PresentDetailView.blmg_width / 2.0;
    }
    return _zd31_PresentDetailView;
}

- (UIView *)zd31_GetPresentSuccessView {
    if (!_zd31_GetPresentSuccessView) {
        _zd31_GetPresentSuccessView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.blmg_width - 70, self.blmg_height - 55 - 20)];
        _zd31_GetPresentSuccessView.backgroundColor = [YLAF_Theme_Utils khxl_color_headBgColor];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _zd31_GetPresentSuccessView.blmg_width, 110)];
        titleLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        titleLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        titleLab.numberOfLines = 0;
        titleLab.tag = 202;
        [_zd31_GetPresentSuccessView addSubview:titleLab];
        
        UILabel *zd31_LBMCodeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, _zd31_GetPresentSuccessView.blmg_width, 30)];
        zd31_LBMCodeLab.font = [YLAF_Theme_Utils khxl_color_SmallFont];
        zd31_LBMCodeLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_LBMCodeLab.userInteractionEnabled = YES;
        zd31_LBMCodeLab.tag = 201;
        [_zd31_GetPresentSuccessView addSubview:zd31_LBMCodeLab];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(zd31_HandleLongPressAction:)];
        [zd31_LBMCodeLab addGestureRecognizer:longPress];
        
        UILabel *zd31_CopyDescLab = [[UILabel alloc] initWithFrame:CGRectMake(0, zd31_LBMCodeLab.blmg_top, _zd31_GetPresentSuccessView.blmg_width, 30)];
        zd31_CopyDescLab.font = [YLAF_Theme_Utils khxl_color_SmallFont];
        zd31_CopyDescLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_CopyDescLab.textAlignment = NSTextAlignmentRight;
        zd31_CopyDescLab.text = MUUQYLocalizedString(@"MUUQYKey_Longpress2Copy_Text");;
        [_zd31_GetPresentSuccessView addSubview:zd31_CopyDescLab];
        [zd31_CopyDescLab sizeToFit];
        zd31_CopyDescLab.blmg_centerY = zd31_LBMCodeLab.blmg_centerY;
        zd31_CopyDescLab.blmg_right = _zd31_GetPresentSuccessView.blmg_width;
        
        NSMutableAttributedString *finalString = [[NSMutableAttributedString alloc] init];
        [finalString appendAttributedString:[[NSAttributedString alloc] initWithString:MUUQYLocalizedString(@"MUUQYKey_GetPresentSuccess_Pre_Text") attributes:@{NSFontAttributeName: [YLAF_Theme_Utils khxl_color_NormalFont], NSForegroundColorAttributeName: [YLAF_Theme_Utils khxl_color_LightColor]}]];
        
        [finalString appendAttributedString:[[NSAttributedString alloc] initWithString:MUUQYLocalizedString(@"MUUQYKey_MyPresent_Text") attributes:@{NSFontAttributeName: [YLAF_Theme_Utils khxl_color_NormalFont], NSForegroundColorAttributeName: [YLAF_Theme_Utils zd32_colorWithHexString:@"#FC2323"]}]];
        
        [finalString appendAttributedString:[[NSAttributedString alloc] initWithString:MUUQYLocalizedString(@"MUUQYKey_GetPresentSuccess_Suf_Text") attributes:@{NSFontAttributeName: [YLAF_Theme_Utils khxl_color_NormalFont], NSForegroundColorAttributeName: [YLAF_Theme_Utils khxl_color_LightColor]}]];
        
        UILabel *expirationLab = [[UILabel alloc] initWithFrame:CGRectMake(0, zd31_LBMCodeLab.blmg_bottom + 8, _zd31_GetPresentSuccessView.blmg_width, 25)];
        expirationLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        expirationLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        expirationLab.textAlignment = NSTextAlignmentRight;
        expirationLab.attributedText = finalString;
        [_zd31_GetPresentSuccessView addSubview:expirationLab];
            
        UIButton *zd31_ConfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zd31_ConfirmBtn.frame = CGRectMake(0, expirationLab.blmg_bottom + 10, 127, 34);
        zd31_ConfirmBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_LargeFont];
        zd31_ConfirmBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
        zd31_ConfirmBtn.layer.cornerRadius = 17.0;
        zd31_ConfirmBtn.layer.masksToBounds = YES;
        [zd31_ConfirmBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_ConfirmButton_Text") forState:UIControlStateNormal];
        [zd31_ConfirmBtn addTarget:self action:@selector(zd31_HandleClickedSuccessConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_zd31_GetPresentSuccessView addSubview:zd31_ConfirmBtn];
        
        [zd31_ConfirmBtn sizeToFit];
        zd31_ConfirmBtn.blmg_size = CGSizeMake(MAX(zd31_ConfirmBtn.blmg_width + 30, 127), 35);
        zd31_ConfirmBtn.blmg_centerX = _zd31_GetPresentSuccessView.blmg_width / 2.0;
    }
    
    return _zd31_GetPresentSuccessView;
}

- (void)zd31_RefreshDetailForPresent:(NSDictionary *)dict {
    if (dict) {
        NSInteger surplus = [dict[[NSString stringWithFormat:@"%@",@"surplus_quantity"]] integerValue];
        
        UILabel *titleLab = [_zd31_PresentDetailView viewWithTag:101];
        titleLab.text = dict[[NSString stringWithFormat:@"%@%@%@%@",@"gi",@"f",@"t_n",@"ame"]];
        
        YLAF_Progress_View *zd31_present_progressView = [_zd31_PresentDetailView viewWithTag:102];
        zd31_present_progressView.progress = surplus / 100.0;;
        
        UILabel *zd31_present_surplusLab = [_zd31_PresentDetailView viewWithTag:103];
        zd31_present_surplusLab.text = [NSString stringWithFormat:@"%@%ld%%",MUUQYLocalizedString(@"MUUQYKey_Surplus_Text"), (long)surplus];
        
        UILabel *zd31_present_contentLab = [_zd31_PresentDetailView viewWithTag:104];
        zd31_present_contentLab.text = dict[[NSString stringWithFormat:@"%@%@%@%@",@"gi",@"ft_des",@"cri",@"ption"]];
        
        UILabel *zd31_present_conditionLab = [_zd31_PresentDetailView viewWithTag:105];
        zd31_present_conditionLab.text = [NSString stringWithFormat:@"%@：%@",MUUQYLocalizedString(@"MUUQYKey_GetCondition_Text"), dict[@"get_condition"]?:@"无"];
        
        UILabel *expirationLab = [_zd31_PresentDetailView viewWithTag:106];
        expirationLab.text = [NSString stringWithFormat:@"%@：%@",MUUQYLocalizedString(@"MUUQYKey_TermOfValidity_Text"), dict[@"end_time"]?:@""];
    }
}

- (void)zd31_RefreshGetPresentSuccessViewForPresent:(NSDictionary *)dict {
    if (dict) {
        NSString *labelText = [NSString stringWithFormat:@"%@%@%@",MUUQYLocalizedString(@"MUUQYKey_GetPresentSuccess_Pre_Tips_Text"),dict[[NSString stringWithFormat:@"%@%@%@",@"gi",@"ft_n",@"ame"]]?:@"",MUUQYLocalizedString(@"MUUQYKey_GetPresentSuccess_Suf_Tips_Text")];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[YLAF_Theme_Utils khxl_color_NormalFont]}];
        
        UILabel *titleLab = [_zd31_GetPresentSuccessView viewWithTag:202];
        titleLab.attributedText = attributedString;
        
        UILabel *zd31_LBMCodeLab = [_zd31_GetPresentSuccessView viewWithTag:201];
        zd31_LBMCodeLab.text = [NSString stringWithFormat:@"%@：%@",MUUQYLocalizedString(@"MUUQYKey_PresentNum_Text"), dict[@"lbm"]?:@""];
    }
}

- (UIImageView *)zd31_NodataView {
    if (!_zd31_NodataView) {
        _zd31_NodataView = [[UIImageView alloc] init];
        _zd31_NodataView.contentMode = UIViewContentModeScaleAspectFit;
        [_zd31_PresentListView addSubview:_zd31_NodataView];
    }
    return _zd31_NodataView;
}


- (void)zd32_HandleClickedCloseBtn:(id)sender {
    if (_zd31_GetPresentSuccessView && _zd31_GetPresentSuccessView.hidden == NO) {
        self.zd31_GetPresentSuccessView.hidden = YES;
        return;
    }
    
    if (_zd31_PresentDetailView && _zd31_PresentDetailView.hidden == NO) {
        self.zd31_PresentDetailView.hidden = YES;
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(zd31_HandleClosePresentPackageView_Delegate:)]) {
        [_delegate zd31_HandleClosePresentPackageView_Delegate:self];
    }
}


- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            self.zd31_all_Present_tableView.hidden = NO;
            self.zd31_my_present_tableView.hidden = YES;
            [self zd31_GetAllPresentList];
        }
            break;
        default:
        {
            self.zd31_all_Present_tableView.hidden = YES;
            self.zd31_my_present_tableView.hidden = NO;
            [self zd31_GetMyPresentList];
        }
            break;
    }
}

- (void)zd31_HandleClickedGetPresentBtn:(id)sender {
    if ([self.subviews containsObject:self.zd31_GetPresentSuccessView] == NO) {
        [self addSubview:self.zd31_GetPresentSuccessView];
    }
    
    __weak typeof(self) weakSelf = self;
    NSInteger zd31_present_id = [self.zd31_select_present[[NSString stringWithFormat:@"%@%@%@%@",@"g",@"if",@"t_i",@"d"]] integerValue];
    [MBProgressHUD zd32_ShowLoadingHUD];
    [self.zd31_AccountServer zd31_GetPresent:zd31_present_id responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd31_GetPresentSuccessView.hidden = NO;
            [weakSelf zd31_RefreshGetPresentSuccessViewForPresent:result.zd32_responeResult];
        } else {
            weakSelf.zd31_GetPresentSuccessView.hidden = YES;
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd31_HandleClickedSuccessConfirmBtn:(id)sender {
    self.zd31_GetPresentSuccessView.hidden = YES;
    if (_zd31_PresentDetailView && _zd31_PresentDetailView.hidden == NO) {
        self.zd31_PresentDetailView.hidden = YES;
    }
    
    UISegmentedControl *segment = [_zd31_PresentListView viewWithTag:100];
    [segment setSelectedSegmentIndex:1];
    [self zd31_SegmentedControlValueChanged:segment];
}

- (void)zd31_HandleLongPressAction:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UILabel *zd31_LBMCodeLab = [_zd31_GetPresentSuccessView viewWithTag:201];
        NSString *khxl_present_numbercode = zd31_LBMCodeLab.text;
        if (khxl_present_numbercode.length > MUUQYLocalizedString(@"MUUQYKey_PresentNum_Text").length+1) {
            khxl_present_numbercode = [zd31_LBMCodeLab.text substringFromIndex:MUUQYLocalizedString(@"MUUQYKey_PresentNum_Text").length+1];
        }

        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:khxl_present_numbercode?:@""];
        
        [MBProgressHUD zd32_showSuccess_Toast:[NSString stringWithFormat:@"%@ %@", MUUQYLocalizedString(@"MUUQYKey_CopyPresentNumSuccess_Tips_Text"), khxl_present_numbercode]];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.zd31_all_Present_tableView) {
        return 95.0;
    } else {
        return 160.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.zd31_all_Present_tableView) {
        if ([self.subviews containsObject:self.zd31_PresentDetailView] == NO) {
            [self addSubview:self.zd31_PresentDetailView];
        }
        self.zd31_PresentDetailView.hidden = NO;
        self.zd31_select_present = self.zd31_all_Presents[indexPath.row];
        [self zd31_RefreshDetailForPresent:self.zd31_select_present];
    } else {
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.zd31_all_Present_tableView) {
        return self.zd31_all_Presents.count;
    } else {
        return self.zd31_my_Presents.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.zd31_all_Present_tableView) {
        ZhenD3AllPresentListCell_View *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZhenD3AllPresentListCell_View class]) forIndexPath:indexPath];
        
        NSDictionary *khxl_presentDict = self.zd31_all_Presents[indexPath.row];
        NSInteger surplus = [khxl_presentDict[[NSString stringWithFormat:@"%@",@"surplus_quantity"]] integerValue];
        BOOL hasGet = [khxl_presentDict[[NSString stringWithFormat:@"%@",@"status"]] boolValue];
        cell.zd31_present_nameLab.text = khxl_presentDict[[NSString stringWithFormat:@"%@%@%@",@"g",@"ift_n",@"ame"]];
        cell.zd31_present_surplusLab.text = hasGet?MUUQYLocalizedString(@"MUUQYKey_HasGetPresent_Text"):[NSString stringWithFormat:@"%@%ld%%",MUUQYLocalizedString(@"MUUQYKey_Surplus_Text"), (long)surplus];
        cell.zd31_present_expirationLab.text = khxl_presentDict[@"end_time"];
        cell.zd31_present_progressView.progress = surplus/100.0;
        if (hasGet || surplus <= 0) {
            cell.contentView.alpha = 0.3;
            cell.userInteractionEnabled = NO;
        } else {
            cell.contentView.alpha = 1.0;
            cell.userInteractionEnabled = YES;
        }
         
        return cell;
    } else {
        ZhenD3MyPresentCell_View *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZhenD3MyPresentCell_View class]) forIndexPath:indexPath];
        
        NSDictionary *khxl_presentDict = self.zd31_my_Presents[indexPath.row];
        cell.zd31_NameLab.text =  khxl_presentDict[[NSString stringWithFormat:@"%@%@%@%@",@"g",@"i",@"f",@"t_name"]];
        cell.zd31_ExpirationLab.text =  khxl_presentDict[@"end_time"];
        cell.zd31_CodeLab.text = [NSString stringWithFormat:@"%@：%@",MUUQYLocalizedString(@"MUUQYKey_PresentLBM_Text"), khxl_presentDict[@"lbm"]?:@""];
        
        NSString *contentText = [NSString stringWithFormat:@"%@：\n%@",MUUQYLocalizedString(@"MUUQYKey_PresentContent_Text"), khxl_presentDict[[NSString stringWithFormat:@"%@%@%@%@",@"gi",@"ft_",@"desc",@"ription"]]?:@""];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentText attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:cell.zd31_ContentLab.font?:[YLAF_Theme_Utils khxl_color_NormalFont]}];
        
        cell.zd31_ContentLab.attributedText = attributedString;
        
        return cell;
    }
}

@end
