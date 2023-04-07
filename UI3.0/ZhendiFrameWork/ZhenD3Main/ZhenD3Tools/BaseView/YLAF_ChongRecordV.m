//
//  YLAF_ChongRecordV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_ChongRecordV.h"
#import "YLAF_ChongCell.h"
#import "ZhenD3Account_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_BiCell.h"
@interface YLAF_ChongRecordV ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) UIView *zd33_bgV;
@property (nonatomic, strong) UITableView *zd32_recordTable;
@property (nonatomic, strong) UITableView *zd31_biTable;
@property (nonatomic, strong) NSArray *zd31_chongArr;
@property (nonatomic, strong) NSArray *zd32_biArr;
@property (nonatomic, strong) UIImageView *zd31_NodataView;

@end

@implementation YLAF_ChongRecordV

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:YES];
    
    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_chongCord")];
    
    [self addSubview:self.zd33_bgV];
    
    [self zd31_getChongListData];

}

- (void)zd32_HandleClickedCloseBtn:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseChongRecordV:)]) {
        [self.delegate zd31_handleCloseChongRecordV:self];
    }
}

- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            self.zd32_recordTable.hidden = NO;
            self.zd31_biTable.hidden = YES;
            [self zd31_getChongListData];
            [self setTitle:MUUQYLocalizedString(@"MUUQYKey_chongCord")];
        }
            break;
        default:
        {
            self.zd32_recordTable.hidden = YES;
            self.zd31_biTable.hidden = NO;
            [self zd31_getBiListData];
//            [self setTitle:MUUQYLocalizedString(@"MUUQYKey_chongCord")];
        }
            break;
    }
}

- (void)zd31_getChongListData{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_GetOrderListRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd31_chongArr = (NSArray *)result.zd32_responeResult;
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
        [weakSelf.zd32_recordTable reloadData];
        weakSelf.zd31_NodataView.hidden = weakSelf.zd31_chongArr.count > 0;
    }];
}

- (void)zd31_getBiListData{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd3_getKionDetailRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd32_biArr = (NSArray *)result.zd32_responeResult;
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
        [weakSelf.zd31_biTable reloadData];
        weakSelf.zd31_NodataView.hidden = weakSelf.zd32_biArr.count > 0;
    }];
}

#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.zd32_recordTable) {
        return self.zd31_chongArr.count;
    }else{
        return self.zd32_biArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.zd32_recordTable) {
        YLAF_ChongCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLAF_ChongCell class]) forIndexPath:indexPath];
        if (self.zd31_chongArr.count > 0) {
            NSDictionary *khxl_chongDict = self.zd31_chongArr[indexPath.row];
            cell.zd31_chongTime.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"add_time"]];
            cell.zd33_orderNum.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"order_no"]];
//            cell.zd33_orderNum.text =@"fgghfdghfhgfssrdhgfgsfdgfsdgdsfgsfdgfdsgfdsgfdsgsfdgfsdgfdsgfgfgfgfgfsgsfgfsgfgfgfgsfgggsgggsfdgfsdgfggfdgdfsfdg";
            cell.zd31_orderMoney.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"order_amt"]];
    //        cell.zd32_orderRole.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"role_name"]];
    //        cell.lhxy_orderServe.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"server_name"]];
            //0待付款 1 已付款 2 已发货 3 发货失败
            NSString *klxl_chongStatues = khxl_chongDict[@"pay_status"];
            if ([klxl_chongStatues isEqualToString:@"0"]) {
                cell.lhxy_statues.image = [YLAF_Helper_Utils imageName:@"zdimageunChong"];
            }else if ([klxl_chongStatues isEqualToString:@"1"]) {
                cell.lhxy_statues.image = [YLAF_Helper_Utils imageName:@"zdimagehasChong"];
            }else if ([klxl_chongStatues isEqualToString:@"2"]) {
                cell.lhxy_statues.image = [YLAF_Helper_Utils imageName:@"zdimagesend"];
            }else if ([klxl_chongStatues isEqualToString:@"3"]) {
                cell.lhxy_statues.image = [YLAF_Helper_Utils imageName:@"zdimagesendFail"];
            }
        }
        return cell;
    } else {
        YLAF_BiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLAF_BiCell class]) forIndexPath:indexPath];
        if (self.zd32_biArr.count > 0) {
            NSDictionary *khxl_biDict = self.zd32_biArr[indexPath.row];
            cell.zd31_date.text = [NSString stringWithFormat:@"%@",khxl_biDict[@"add_time"]];
            cell.zd33_cost.text = [NSString stringWithFormat:@"%@",khxl_biDict[@"coin"]];
            cell.zd31_channel.text = [NSString stringWithFormat:@"%@",khxl_biDict[@"type"]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.zd32_recordTable) {
        return 55;
    }else{
        return 42;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.zd32_recordTable) {
        UIView *zd32_headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.blmg_width, 42)];
        zd32_headV.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LargeFont];
        UILabel *zd31_chongTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.blmg_width/4, zd32_headV.blmg_height)];
        zd31_chongTime.font = contFont;
        zd31_chongTime.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_chongTime.text = MUUQYLocalizedString(@"MUUQYKey_chongTime");
        zd31_chongTime.textAlignment = NSTextAlignmentCenter;
        zd31_chongTime.adjustsFontSizeToFitWidth = true;
        zd31_chongTime.numberOfLines = 0;
        [zd32_headV addSubview:zd31_chongTime];
        
        UILabel *zd33_orderNum = [[UILabel alloc] initWithFrame:CGRectMake(zd31_chongTime.blmg_right, 0, self.blmg_width/4, zd32_headV.blmg_height)];
        zd33_orderNum.font = contFont;
        zd33_orderNum.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd33_orderNum.text = MUUQYLocalizedString(@"MUUQYKey_chongNum");
        zd33_orderNum.textAlignment = NSTextAlignmentCenter;
        zd33_orderNum.adjustsFontSizeToFitWidth = true;
        [zd32_headV addSubview:zd33_orderNum];
        
        UILabel *zd31_orderMoney = [[UILabel alloc] initWithFrame:CGRectMake(zd33_orderNum.blmg_right, 0, self.blmg_width/4, zd32_headV.blmg_height)];
        zd31_orderMoney.font = contFont;
        zd31_orderMoney.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_orderMoney.text = MUUQYLocalizedString(@"MUUQYKey_chongMon");
        zd31_orderMoney.textAlignment = NSTextAlignmentCenter;
        [zd32_headV addSubview:zd31_orderMoney];
        
        UILabel *zd32_statues = [[UILabel alloc] initWithFrame:CGRectMake(zd31_orderMoney.blmg_right, 0, self.blmg_width/4, zd32_headV.blmg_height)];
        zd32_statues.font = contFont;
        zd32_statues.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd32_statues.text = MUUQYLocalizedString(@"MUUQYKey_chongStatus");
        zd32_statues.textAlignment = NSTextAlignmentCenter;
        [zd32_headV addSubview:zd32_statues];
        
        /*
        UILabel *zd32_orderRole = [[UILabel alloc] initWithFrame:CGRectMake(zd31_orderMoney.blmg_right, 0, self.blmg_width/5, zd32_headV.blmg_height)];
        zd32_orderRole.font = contFont;
        zd32_orderRole.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd32_orderRole.text = @"角色";
        zd32_orderRole.textAlignment = NSTextAlignmentCenter;
        [zd32_headV addSubview:zd32_orderRole];
        
        UILabel *lhxy_orderServe = [[UILabel alloc] initWithFrame:CGRectMake(zd32_orderRole.blmg_right, 0, self.blmg_width/5, zd32_headV.blmg_height)];
        lhxy_orderServe.font = contFont;
        lhxy_orderServe.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        lhxy_orderServe.text = @"区服";
        lhxy_orderServe.textAlignment = NSTextAlignmentCenter;
        [zd32_headV addSubview:lhxy_orderServe];
         */
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.blmg_width, 0.5)];
        [zd32_headV addSubview:line1];
        [YLAF_ChongRecordV drawDashLine:line1 lineLength:2 lineSpacing:2 lineColor:[YLAF_Theme_Utils khxl_color_LightColor]];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 41.5, self.blmg_width, 0.5)];
        [zd32_headV addSubview:line2];
        [YLAF_ChongRecordV drawDashLine:line2 lineLength:2 lineSpacing:2 lineColor:[YLAF_Theme_Utils khxl_color_LightColor]];
        
        return zd32_headV;
    }else{
        UIView *zd32_headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.blmg_width, 42)];
        zd32_headV.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
        UIFont *contFont = [YLAF_Theme_Utils khxl_color_LargeFont];
        UILabel *zd31_data = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.blmg_width/3, zd32_headV.blmg_height)];
        zd31_data.font = contFont;
        zd31_data.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_data.text = MUUQYLocalizedString(@"MUUQYKey_nowData");
        zd31_data.textAlignment = NSTextAlignmentCenter;
        zd31_data.adjustsFontSizeToFitWidth = true;
        zd31_data.numberOfLines = 0;
        [zd32_headV addSubview:zd31_data];
        
        UILabel *zd33_cost = [[UILabel alloc] initWithFrame:CGRectMake(zd31_data.blmg_right, 0, self.blmg_width/3, zd32_headV.blmg_height)];
        zd33_cost.font = contFont;
        zd33_cost.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd33_cost.text = MUUQYLocalizedString(@"MUUQYKey_nowMuch");
        zd33_cost.textAlignment = NSTextAlignmentCenter;
        zd33_cost.adjustsFontSizeToFitWidth = true;
        [zd32_headV addSubview:zd33_cost];
        
        UILabel *zd31_channel = [[UILabel alloc] initWithFrame:CGRectMake(zd33_cost.blmg_right, 0, self.blmg_width/3, zd32_headV.blmg_height)];
        zd31_channel.font = contFont;
        zd31_channel.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
        zd31_channel.text = MUUQYLocalizedString(@"MUUQYKey_nowChan");
        zd31_channel.textAlignment = NSTextAlignmentCenter;
        [zd32_headV addSubview:zd31_channel];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.blmg_width, 0.5)];
        [zd32_headV addSubview:line1];
        [YLAF_ChongRecordV drawDashLine:line1 lineLength:2 lineSpacing:2 lineColor:[YLAF_Theme_Utils khxl_color_LightColor]];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 41.5, self.blmg_width, 0.5)];
        [zd32_headV addSubview:line2];
        [YLAF_ChongRecordV drawDashLine:line2 lineLength:2 lineSpacing:2 lineColor:[YLAF_Theme_Utils khxl_color_LightColor]];
        
        return zd32_headV;
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
#pragma  mark lazy load

- (UIView *)zd33_bgV{
    if (!_zd33_bgV) {
        _zd33_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.blmg_width, self.blmg_height - 55 - 25)];
        
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[MUUQYLocalizedString(@"MUUQYKey_chongCord"), MUUQYLocalizedString(@"MUUQYKey_deskRecord")]];
        segment.tintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
        [segment setBackgroundColor:[YLAF_Theme_Utils khxl_color_headBgColor]];
        NSDictionary *zd32_atru = [NSDictionary dictionaryWithObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
        [segment setTitleTextAttributes:zd32_atru forState:UIControlStateNormal];
        if (@available(iOS 13.0, *)) {
            segment.selectedSegmentTintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
        } else {
            
        }
        
        segment.frame = CGRectMake(0, 0, _zd33_bgV.blmg_width, 30);
        [segment addTarget:self action:@selector(zd31_SegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        segment.selectedSegmentIndex = 0;
        segment.tag = 100;
        [_zd33_bgV addSubview:segment];
        
        self.zd32_recordTable = [[UITableView alloc] initWithFrame:CGRectMake(0, segment.blmg_bottom, _zd33_bgV.blmg_width, _zd33_bgV.blmg_height - segment.blmg_bottom) style:UITableViewStylePlain];
        self.zd32_recordTable.backgroundColor = [UIColor clearColor];
        
        self.zd32_recordTable.delegate = self;
        self.zd32_recordTable.dataSource = self;
        self.zd32_recordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.zd32_recordTable.tableFooterView = [UIView new];
        [self.zd32_recordTable registerClass:[YLAF_ChongCell class] forCellReuseIdentifier:NSStringFromClass([YLAF_ChongCell class])];
        [_zd33_bgV addSubview:self.zd32_recordTable];
        
        self.zd31_biTable = [[UITableView alloc] initWithFrame:self.zd32_recordTable.frame style:UITableViewStylePlain];
        self.zd31_biTable.backgroundColor = [UIColor clearColor];
        self.zd31_biTable.hidden = YES;
        self.zd31_biTable.delegate = self;
        self.zd31_biTable.dataSource = self;
        self.zd31_biTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.zd31_biTable.tableFooterView = [UIView new];
        [self.zd31_biTable registerClass:[YLAF_BiCell class] forCellReuseIdentifier:NSStringFromClass([YLAF_BiCell class])];
        [_zd33_bgV addSubview:self.zd31_biTable];
        
        self.zd31_NodataView.frame = self.zd32_recordTable.frame;
    }
    return _zd33_bgV;
}


- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

- (UIImageView *)zd31_NodataView {
    if (!_zd31_NodataView) {
        _zd31_NodataView = [[UIImageView alloc] init];
        _zd31_NodataView.contentMode = UIViewContentModeScaleAspectFit;
        [_zd33_bgV addSubview:_zd31_NodataView];
    }
    return _zd31_NodataView;
}

@end
