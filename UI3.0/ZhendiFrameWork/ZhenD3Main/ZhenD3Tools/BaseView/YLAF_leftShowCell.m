//
//  YLAF_leftShowCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_leftShowCell.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"
@implementation YLAF_leftShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.zd31_showIcon = [[UIImageView alloc]initWithFrame:CGRectMake(30, 27.5, 25, 25)];
        [self.contentView addSubview:self.zd31_showIcon];
        
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LargeFont];
        self.zd31_showName = [[UILabel alloc] initWithFrame:CGRectMake(self.zd31_showIcon.blmg_right + 20, 32.5, 150, 15)];
        self.zd31_showName.font = contFont;
        self.zd31_showName.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        [self.contentView addSubview:self.zd31_showName];
        
       
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
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
