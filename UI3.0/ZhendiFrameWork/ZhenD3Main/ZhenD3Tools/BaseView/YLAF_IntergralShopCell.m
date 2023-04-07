//
//  YLAF_IntergralShopCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2022/4/20.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "YLAF_IntergralShopCell.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"

@implementation YLAF_IntergralShopCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [YLAF_Theme_Utils khxl_color_LineColor].CGColor;
        self.layer.borderWidth = 1;
        [self.contentView addSubview:self.blmg_icon];
        [self.contentView addSubview:self.zd31_name];
        [self.contentView addSubview:self.zd33_accInter];
        [self.contentView addSubview:self.zd32_lastNum];
    }
    return self;
}

- (UIImageView *)blmg_icon{
    if (!_blmg_icon) {
        _blmg_icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.blmg_width - 20, 60)];
        _blmg_icon.layer.cornerRadius = 4;
    }
    return _blmg_icon;
}

- (UILabel *)zd31_name{
    if (!_zd31_name) {
        _zd31_name = [[UILabel alloc] initWithFrame:CGRectMake(10, self.blmg_icon.blmg_bottom + 6, self.blmg_width - 20, 15)];
        _zd31_name.textAlignment = NSTextAlignmentLeft;
        _zd31_name.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        _zd31_name.font = [YLAF_Theme_Utils khxl_color_SmallFont];
    }
    return _zd31_name;
}

- (UILabel *)zd33_accInter{
    if (!_zd33_accInter) {
        _zd33_accInter = [[UILabel alloc] initWithFrame:CGRectMake(0, self.zd31_name.blmg_bottom + 10, self.blmg_width - 10, 13)];
        _zd33_accInter.textAlignment = NSTextAlignmentRight;
        _zd33_accInter.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        _zd33_accInter.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    }
    return _zd33_accInter;
}


- (UILabel *)zd32_lastNum{
    if (!_zd32_lastNum) {
        _zd32_lastNum = [[UILabel alloc] initWithFrame:CGRectMake(0, self.zd33_accInter.blmg_bottom + 5, self.blmg_width - 10, 13)];
        _zd32_lastNum.textAlignment = NSTextAlignmentRight;
        _zd32_lastNum.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        _zd32_lastNum.font = [YLAF_Theme_Utils khxl_color_LeastFont];
    }
    return _zd32_lastNum;
}



@end
