
#import "ZhenD3AllPresentListCell_View.h"
#import "UIView+GrossExtension.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_Helper_Utils.h"

@interface ZhenD3AllPresentListCell_View ()

@property (nonatomic, strong) UIView *zd32_rangeView;
@end

@implementation ZhenD3AllPresentListCell_View

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.zd32_rangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, self.blmg_width, self.blmg_height - 15)];
        self.zd32_rangeView.backgroundColor = [YLAF_Theme_Utils khxl_color_headBgColor];
        self.zd32_rangeView.layer.cornerRadius = 7.0;
        [self.contentView addSubview:self.zd32_rangeView];
        
        UIFont *contFont = [YLAF_Theme_Utils khxl_FontSize13];
        
        self.zd32_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 120, 15)];
        self.zd32_TitleLab.font = [YLAF_Theme_Utils khxl_FontSize13];
        self.zd32_TitleLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd32_TitleLab.text = MUUQYLocalizedString(@"MUUQYKey_PresentName_Text");;
        [self.zd32_rangeView addSubview:self.zd32_TitleLab];
        
        self.zd31_ExpirationDateLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, 100, 15)];
        self.zd31_ExpirationDateLab.font = [YLAF_Theme_Utils khxl_FontSize13];
        self.zd31_ExpirationDateLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_ExpirationDateLab.textAlignment = NSTextAlignmentRight;
        self.zd31_ExpirationDateLab.text = MUUQYLocalizedString(@"MUUQYKey_Deadline_Text");;
        [self.zd32_rangeView addSubview:self.zd31_ExpirationDateLab];
        
        self.zd31_present_nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.zd32_TitleLab.blmg_bottom + 7, 120, 13)];
        self.zd31_present_nameLab.font = contFont;
        self.zd31_present_nameLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        [self.zd32_rangeView addSubview:self.zd31_present_nameLab];
        
        self.zd31_present_expirationLab = [[UILabel alloc] initWithFrame:CGRectMake(120, self.zd32_TitleLab.blmg_bottom + 7, 100, 13)];
        self.zd31_present_expirationLab.font = contFont;
        self.zd31_present_expirationLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_present_expirationLab.textAlignment = NSTextAlignmentRight;
        [self.zd32_rangeView addSubview:self.zd31_present_expirationLab];
        
        self.zd31_present_surplusLab = [[UILabel alloc] initWithFrame:CGRectMake(120, self.zd31_present_expirationLab.blmg_bottom + 7, 100, 13)];
        self.zd31_present_surplusLab.font = contFont;
        self.zd31_present_surplusLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_present_surplusLab.textAlignment = NSTextAlignmentRight;
        [self.zd32_rangeView addSubview:self.zd31_present_surplusLab];
        
        self.zd31_present_progressView = [[YLAF_Progress_View alloc] initWithFrame:CGRectMake(15, self.zd31_present_expirationLab.blmg_bottom + 7, 120, 6)];
        self.zd31_present_progressView.progress = 0.5;
        [self.zd32_rangeView addSubview:self.zd31_present_progressView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.zd32_rangeView.frame = CGRectMake(0, 15, self.blmg_width, self.blmg_height - 15);
    
    _zd31_ExpirationDateLab.blmg_right = self.blmg_width-15;
    _zd31_present_expirationLab.blmg_right = self.blmg_width-15;
    _zd31_present_surplusLab.blmg_right = self.blmg_width-15;
    _zd31_present_progressView.blmg_centerY = _zd31_present_surplusLab.blmg_centerY;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
