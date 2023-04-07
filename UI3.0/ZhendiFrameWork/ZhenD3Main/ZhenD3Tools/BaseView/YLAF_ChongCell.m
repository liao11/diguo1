//
//  YLAF_ChongCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_ChongCell.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"
@implementation YLAF_ChongCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        TableViewCellBackgroundView *backgroundView = [[TableViewCellBackgroundView alloc] initWithFrame:CGRectZero];
        
        [self setBackgroundView:backgroundView];
        
        
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LeastFont];
        self.zd31_chongTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.blmg_width/4, 55)];
        self.zd31_chongTime.font = contFont;
        self.zd31_chongTime.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_chongTime.text = @"";
        self.zd31_chongTime.textAlignment = NSTextAlignmentCenter;
        self.zd31_chongTime.numberOfLines = 0;
        [self.contentView addSubview:self.zd31_chongTime];
        
        self.zd33_orderNum = [[UILabel alloc] initWithFrame:CGRectMake(self.zd31_chongTime.blmg_right, 0, self.blmg_width/4, 55)];
        self.zd33_orderNum.font = contFont;
        self.zd33_orderNum.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd33_orderNum.text = @"";
        self.zd33_orderNum.adjustsFontSizeToFitWidth = true;
        self.zd33_orderNum.textAlignment = NSTextAlignmentCenter;
        self.zd33_orderNum.numberOfLines = 0;
        [self.contentView addSubview:self.zd33_orderNum];
        
        self.zd31_orderMoney = [[UILabel alloc] initWithFrame:CGRectMake(self.zd33_orderNum.blmg_right, 0, self.blmg_width/4, 55)];
        self.zd31_orderMoney.font = contFont;
        self.zd31_orderMoney.textColor = [YLAF_Theme_Utils khxl_redColor];
        self.zd31_orderMoney.text = @"";
        self.zd31_orderMoney.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.zd31_orderMoney];
        
        self.lhxy_statues = [[UIImageView alloc]initWithFrame:CGRectMake(self.zd31_orderMoney.blmg_right + (self.blmg_width/4 - 30)/2, 15, 24, 24)];
        [self.contentView addSubview:self.lhxy_statues];
        /*
        self.zd32_orderRole = [[UILabel alloc] initWithFrame:CGRectMake(self.zd31_orderMoney.blmg_right, 0, self.blmg_width/5, 42)];
        self.zd32_orderRole.font = contFont;
        self.zd32_orderRole.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd32_orderRole.text = @"";
        self.zd32_orderRole.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.zd32_orderRole];
        
        self.lhxy_orderServe = [[UILabel alloc] initWithFrame:CGRectMake(self.zd32_orderRole.blmg_right, 0, self.blmg_width/5, 42)];
        self.lhxy_orderServe.font = contFont;
        self.lhxy_orderServe.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.lhxy_orderServe.text = @"";
        self.lhxy_orderServe.textAlignment = NSTextAlignmentCenter;
        self.lhxy_orderServe.numberOfLines = 0;
        [self.contentView addSubview:self.lhxy_orderServe];
        */
        
    }
    return self;
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

@implementation TableViewCellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[YLAF_Theme_Utils khxl_color_BackgroundColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(cont, 0, lengths, 2);  //画虚线
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 0.0, rect.size.height - 1);    //开始画线
    CGContextAddLineToPoint(cont, 320.0, rect.size.height - 1);
    CGContextStrokePath(cont);
}

@end




