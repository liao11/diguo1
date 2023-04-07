//
//  ZhenD3TaskCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenD3TaskCell.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"
#import "NSString+GrossExtension.h"
#import "ZhenD3Account_Server.h"
@implementation ZhenD3TaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.blmg_bgV = [[UIView alloc] initWithFrame:CGRectMake(15, 10, self.blmg_width - 30,50)];
        self.blmg_bgV.layer.cornerRadius = 6;
        self.blmg_bgV.layer.borderColor = [YLAF_Theme_Utils khxl_color_LightColor].CGColor;
        self.blmg_bgV.layer.borderWidth = 0.5;
        [self.contentView addSubview:self.blmg_bgV];
        
                        
        
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LargeFont];
        self.zd31_taskName = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, self.blmg_bgV.blmg_width/2, 15)];
        self.zd31_taskName.font = contFont;
        self.zd31_taskName.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_taskName.text = @"";
        self.zd31_taskName.textAlignment = NSTextAlignmentLeft;
        self.zd31_taskName.numberOfLines = 0;
        [self.blmg_bgV addSubview:self.zd31_taskName];
        
        self.zd33_taskDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, self.zd31_taskName.blmg_bottom + 7, self.blmg_bgV.blmg_width/2, 12)];
        self.zd33_taskDetail.font = [YLAF_Theme_Utils khxl_color_SmallFont];
        self.zd33_taskDetail.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd33_taskDetail.text = @"";
        self.zd33_taskDetail.adjustsFontSizeToFitWidth = true;
        self.zd33_taskDetail.textAlignment = NSTextAlignmentLeft;
        self.zd33_taskDetail.numberOfLines = 0;
        [self.blmg_bgV addSubview:self.zd33_taskDetail];
        
        
        self.zd32_taskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.zd32_taskBtn.frame =  CGRectMake(self.blmg_bgV.blmg_width - 70, 10, 60, 30);
        self.zd32_taskBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_FBBlueColor];
        self.zd32_taskBtn.layer.cornerRadius = 15;
        self.zd32_taskBtn.titleLabel.font = [YLAF_Theme_Utils khxl_FontSize13];
        [self.zd32_taskBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_nowGoen") forState:UIControlStateNormal];
        [self.zd32_taskBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.zd32_taskBtn addTarget:self action:@selector(zd32_taskAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.blmg_bgV addSubview:self.zd32_taskBtn];
    }
    return self;
}

- (void)zd32_taskAction:(UIButton *)zd32_taskBtn{
    
    NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : MYMGSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[MYMGSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [MYMGSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
    NSString *url = [ZhenD3RemoteData_Server zd32_BuildFinalUrl:MYMGUrlConfig.zd32_httpsdomain.zd32_backupsBaseUrl WithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAutoLoginPath andParams:params];
    [MYMGSDKGlobalInfo zd32_PresendWithUrlString:url];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
