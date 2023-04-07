//
//  YLAF_canGetCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_canGetCell.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"
#import "YLAF_Helper_Utils.h"
@implementation YLAF_canGetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.blmg_bgV = [[UIView alloc] initWithFrame:CGRectMake(15, 10, self.blmg_width - 30,70)];
        self.blmg_bgV.layer.cornerRadius = 6;
        self.blmg_bgV.layer.borderColor = UIColor.whiteColor.CGColor;
        self.blmg_bgV.layer.borderWidth = 0.5;
        [self.contentView addSubview:self.blmg_bgV];
        
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LargeFont];
        self.zd31_name = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, self.blmg_bgV.blmg_width/2, 15)];
        self.zd31_name.font = contFont;
        self.zd31_name.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd31_name.text = @"";
        self.zd31_name.textAlignment = NSTextAlignmentLeft;
        self.zd31_name.numberOfLines = 0;
        [self.blmg_bgV addSubview:self.zd31_name];
        
        self.zd33_info = [[UILabel alloc] initWithFrame:CGRectMake(10, self.zd31_name.blmg_bottom + 7, self.blmg_bgV.blmg_width/2, 12)];
        self.zd33_info.font = [YLAF_Theme_Utils khxl_color_SmallFont];
        self.zd33_info.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.zd33_info.text = @"";
        self.zd33_info.adjustsFontSizeToFitWidth = true;
        self.zd33_info.textAlignment = NSTextAlignmentLeft;
        self.zd33_info.numberOfLines = 0;
        [self.blmg_bgV addSubview:self.zd33_info];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.blmg_width - 30, 0.5)];
        [self.blmg_bgV addSubview:line1];
        [YLAF_canGetCell drawDashLine:line1 lineLength:2 lineSpacing:2 lineColor:[YLAF_Theme_Utils khxl_color_LightColor]];
        
        self.limitTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, self.blmg_bgV.blmg_width/2, 20)];
        self.limitTime.font = [YLAF_Theme_Utils khxl_FontSize13];
        self.limitTime.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        self.limitTime.text = @"";
        self.limitTime.adjustsFontSizeToFitWidth = true;
        self.limitTime.textAlignment = NSTextAlignmentLeft;
        self.limitTime.numberOfLines = 0;
        [self.blmg_bgV addSubview:self.limitTime];
        
        self.zd32_getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.zd32_getBtn.frame =  CGRectMake(self.blmg_bgV.blmg_width - 70, 15, 60, 20);
        self.zd32_getBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_FBBlueColor];
        self.zd32_getBtn.layer.cornerRadius = 10;
        self.zd32_getBtn.titleLabel.font = [YLAF_Theme_Utils khxl_color_SmallFont];
        [self.zd32_getBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_nowObtain") forState:UIControlStateNormal];
        [self.zd32_getBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.zd32_getBtn addTarget:self action:@selector(zd32_getAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.blmg_bgV addSubview:self.zd32_getBtn];
        
    }
    return self;
}

- (void)zd32_getAction:(UIButton *)zd32_getBtn{
    if (self.zd31_getBtnBlock) {
        self.zd31_getBtnBlock();
    }
}

/**
 ** lineView:      需要绘制成虚线的view
 ** lineLength:    虚线的宽度 //2
 ** lineSpacing:        虚线的间距//1
 ** lineColor:    虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:0.5];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
    
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
