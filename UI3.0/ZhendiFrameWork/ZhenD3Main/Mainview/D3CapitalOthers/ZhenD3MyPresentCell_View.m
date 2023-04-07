
#import "ZhenD3MyPresentCell_View.h"
#import "UIView+GrossExtension.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_Helper_Utils.h"
#import "MBProgressHUD+GrossExtension.h"

@interface ZhenD3MyPresentCell_View ()

@property (nonatomic, strong) UIView *zd31_rangeView;
@end

@implementation ZhenD3MyPresentCell_View

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.zd31_rangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, self.blmg_width, self.blmg_height - 15)];
        self.zd31_rangeView.backgroundColor = [YLAF_Theme_Utils khxl_color_headBgColor];
        self.zd31_rangeView.layer.cornerRadius = 7.0;
        [self.contentView addSubview:self.zd31_rangeView];
        
        self.zd32_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 25)];
        self.zd32_TitleLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        self.zd32_TitleLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd32_TitleLab.text = MUUQYLocalizedString(@"MUUQYKey_PresentName_Text");;
        [self.zd31_rangeView addSubview:self.zd32_TitleLab];
        
        self.zd31_ExpirationDateLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 120, 25)];
        self.zd31_ExpirationDateLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        self.zd31_ExpirationDateLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_ExpirationDateLab.textAlignment = NSTextAlignmentRight;
        self.zd31_ExpirationDateLab.text = MUUQYLocalizedString(@"MUUQYKey_ExpirationDate_Text");
        [self.zd31_rangeView addSubview:self.zd31_ExpirationDateLab];
        
        self.zd31_NameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.zd32_TitleLab.blmg_bottom, 120, 25)];
        self.zd31_NameLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        self.zd31_NameLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        [self.zd31_rangeView addSubview:self.zd31_NameLab];
        
        self.zd31_ExpirationLab = [[UILabel alloc] initWithFrame:CGRectMake(120, self.zd32_TitleLab.blmg_bottom, 100, 25)];
        self.zd31_ExpirationLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        self.zd31_ExpirationLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_ExpirationLab.textAlignment = NSTextAlignmentRight;
        [self.zd31_rangeView addSubview:self.zd31_ExpirationLab];
        
        self.zd31_CodeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.zd31_ExpirationLab.blmg_bottom, 100, 40)];
        self.zd31_CodeLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        self.zd31_CodeLab.numberOfLines = 0;
        self.zd31_CodeLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        [self.zd31_rangeView addSubview:self.zd31_CodeLab];
        
        self.zd31_CopyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.zd31_CopyCodeBtn.frame = CGRectMake(0, self.zd31_ExpirationLab.blmg_bottom + 2, 50, 26);
        self.zd31_CopyCodeBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_SmallFont];
        self.zd31_CopyCodeBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
        self.zd31_CopyCodeBtn.layer.cornerRadius = 13.0;
        self.zd31_CopyCodeBtn.layer.masksToBounds = YES;
        [self.zd31_CopyCodeBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_CopyButton_Text") forState:UIControlStateNormal];
        [self.zd31_CopyCodeBtn addTarget:self action:@selector(zd31_HandleClickedCopyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.zd31_rangeView addSubview:self.zd31_CopyCodeBtn];
        
        self.zd31_ContentLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.zd31_CodeLab.blmg_bottom, self.contentView.blmg_width, 50)];
        self.zd31_ContentLab.font = [YLAF_Theme_Utils khxl_color_NormalFont];
        self.zd31_ContentLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_ContentLab.numberOfLines = 0;
        [self.zd31_rangeView addSubview:self.zd31_ContentLab];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _zd31_rangeView.frame = CGRectMake(0, 15, self.blmg_width, self.blmg_height-15);
    
    _zd31_ExpirationDateLab.blmg_right = self.blmg_width-15;
    _zd31_CodeLab.blmg_width = self.blmg_width - 70 - 10;
    _zd31_ExpirationLab.blmg_right = self.blmg_width-15;
    _zd31_CopyCodeBtn.blmg_right = self.blmg_width-15;
    _zd31_CopyCodeBtn.blmg_centerY = _zd31_CodeLab.blmg_centerY;
    _zd31_ContentLab.blmg_width = self.blmg_width-15;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)zd31_HandleClickedCopyBtn:(id)sender {
    NSString *lhxy_present_numbercode = self.zd31_CodeLab.text;
    if (lhxy_present_numbercode.length > MUUQYLocalizedString(@"MUUQYKey_PresentLBM_Text").length+1) {
        lhxy_present_numbercode = [lhxy_present_numbercode substringFromIndex:MUUQYLocalizedString(@"MUUQYKey_PresentLBM_Text").length+1];
    }
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:lhxy_present_numbercode?:@""];
    
    [MBProgressHUD zd32_showSuccess_Toast:[NSString stringWithFormat:@"%@ %@", MUUQYLocalizedString(@"MUUQYKey_CopyPresentNumSuccess_Tips_Text"), lhxy_present_numbercode]];
}

@end
