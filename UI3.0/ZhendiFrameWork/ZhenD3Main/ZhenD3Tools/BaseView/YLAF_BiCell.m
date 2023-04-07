//
//  YLAF_BiCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BiCell.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"

@implementation YLAF_BiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        BiTableViewCellBackgroundView *backgroundView = [[BiTableViewCellBackgroundView alloc] initWithFrame:CGRectZero];
        
        [self setBackgroundView:backgroundView];
        
        
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LeastFont];
        self.zd31_date = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.blmg_width/3, 42)];
        self.zd31_date.font = contFont;
        self.zd31_date.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_date.text = @"";
        self.zd31_date.textAlignment = NSTextAlignmentCenter;
        self.zd31_date.numberOfLines = 0;
        [self.contentView addSubview:self.zd31_date];
        
        self.zd33_cost = [[UILabel alloc] initWithFrame:CGRectMake(self.zd31_date.blmg_right, 0, self.blmg_width/3, 42)];
        self.zd33_cost.font = contFont;
        self.zd33_cost.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd33_cost.text = @"";
        self.zd33_cost.adjustsFontSizeToFitWidth = true;
        self.zd33_cost.textAlignment = NSTextAlignmentCenter;
        self.zd33_cost.numberOfLines = 0;
        [self.contentView addSubview:self.zd33_cost];
        
        self.zd31_channel = [[UILabel alloc] initWithFrame:CGRectMake(self.zd33_cost.blmg_right, 0, self.blmg_width/3, 42)];
        self.zd31_channel.font = contFont;
        self.zd31_channel.textColor = [YLAF_Theme_Utils khxl_redColor];
        self.zd31_channel.text = @"";
        self.zd31_channel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.zd31_channel];
        
        
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

@implementation BiTableViewCellBackgroundView

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
    CGContextSetStrokeColorWithColor(cont, [YLAF_Theme_Utils khxl_color_LightColor].CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(cont, 0, lengths, 2);  //画虚线
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 0.0, rect.size.height - 1);    //开始画线
    CGContextAddLineToPoint(cont, 320.0, rect.size.height - 1);
    CGContextStrokePath(cont);
}

@end
