//
//  YLAF_CouponV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_CouponV.h"
#import "YLAF_canGetCell.h"
#import "ZhenD3Account_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_canUseCell.h"
@interface YLAF_CouponV ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) UIView *zd33_bgV;
@property (nonatomic, strong) UITableView *zd32_getTable;
@property (nonatomic, strong) UITableView *zd32_useTable;
@property (nonatomic, strong) NSArray *zd31_getArr;
@property (nonatomic, strong) NSArray *zd31_userArr;
@property (nonatomic, strong) UIImageView *zd31_NodataView;

@end

@implementation YLAF_CouponV

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:YES];
    
    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_OffCount")];
    
    [self addSubview:self.zd33_bgV];
    
    [self zd31_loadGetCouponListWithStr:2];

}

- (void)zd32_HandleClickedCloseBtn:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseChongCouponV:)]) {
        [self.delegate zd31_handleCloseChongCouponV:self];
    }
}

- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            self.zd32_getTable.hidden = NO;
            self.zd32_useTable.hidden = YES;
            [self zd31_loadGetCouponListWithStr:2];
        }
            break;
        default:
        {
            self.zd32_getTable.hidden = YES;
            self.zd32_useTable.hidden = NO;
            [self zd31_loadGetCouponListWithStr:3];
        }
            break;
    }
}

- (void)zd31_loadGetCouponListWithStr:(NSInteger)zd32_type{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer khxl_obtainCouponLsitWithzd3_lt:zd32_type responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            if (zd32_type == 2) {
                weakSelf.zd31_getArr = (NSArray *)result.zd32_responeResult;
                [weakSelf.zd32_getTable reloadData];
            }else if (zd32_type == 3) {
                weakSelf.zd31_userArr = (NSArray *)result.zd32_responeResult;
                [weakSelf.zd32_useTable reloadData];
            }
            
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
        
        if (zd32_type == 2) {
            weakSelf.zd31_NodataView.hidden = weakSelf.zd31_getArr.count > 0;
        }else if (zd32_type == 3) {
            weakSelf.zd31_NodataView.hidden = weakSelf.zd31_userArr.count > 0;
        }
    }];
}

- (void)zd32_getCouponAskWithzd32_couponId:(NSInteger)zd32_couponId {
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd3_saveCouponLsitWithblmg_couponId:zd32_couponId responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            [weakSelf zd31_loadGetCouponListWithStr:2];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}


#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.zd32_getTable) {
        return self.zd31_getArr.count;
    }else{
        return self.zd31_userArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.zd32_getTable) {
        YLAF_canGetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLAF_canGetCell class]) forIndexPath:indexPath];
        
        if (self.zd31_getArr.count > 0) {
            NSDictionary *khxl_getDict = self.zd31_getArr[indexPath.row];
            cell.zd31_name.text = [NSString stringWithFormat:@"%@",khxl_getDict[@"title"]];
            cell.zd33_info.text = [NSString stringWithFormat:@"满%@赠%@",khxl_getDict[@"order_coin"],khxl_getDict[@"give_coin"]];
            cell.limitTime.text = [NSString stringWithFormat:@"%@",khxl_getDict[@"limit_time"]];
            
            __weak typeof(self) weakSelf = self;
            cell.zd31_getBtnBlock = ^{
                [weakSelf zd32_getCouponAskWithzd32_couponId:[khxl_getDict[@"coupon_id"] integerValue]];
            };
 
        }
        
        return cell;
    } else {
        YLAF_canUseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLAF_canUseCell class]) forIndexPath:indexPath];
        if (self.zd31_userArr.count > 0) {
            NSDictionary *khxl_useDict = self.zd31_userArr[indexPath.row];
            cell.zd31_name.text = [NSString stringWithFormat:@"%@",khxl_useDict[@"title"]];
            cell.zd33_info.text = [NSString stringWithFormat:@"满%@赠%@",khxl_useDict[@"order_coin"],khxl_useDict[@"give_coin"]];
            cell.limitTime.text = [NSString stringWithFormat:@"%@",khxl_useDict[@"limit_time"]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

#pragma  mark lazy load

- (UIView *)zd33_bgV{
    if (!_zd33_bgV) {
        _zd33_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.blmg_width, self.blmg_height - 55 - 25)];
        
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[MUUQYLocalizedString(@"MUUQYKey_canObtain"), MUUQYLocalizedString(@"MUUQYKey_canUse")]];
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
        
        self.zd32_getTable = [[UITableView alloc] initWithFrame:CGRectMake(0, segment.blmg_bottom, _zd33_bgV.blmg_width, _zd33_bgV.blmg_height - segment.blmg_bottom) style:UITableViewStylePlain];
        self.zd32_getTable.backgroundColor = [UIColor clearColor];
        
        self.zd32_getTable.delegate = self;
        self.zd32_getTable.dataSource = self;
        self.zd32_getTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.zd32_getTable.tableFooterView = [UIView new];
        [self.zd32_getTable registerClass:[YLAF_canGetCell class] forCellReuseIdentifier:NSStringFromClass([YLAF_canGetCell class])];
        [_zd33_bgV addSubview:self.zd32_getTable];
        
        self.zd32_useTable = [[UITableView alloc] initWithFrame:self.zd32_getTable.frame style:UITableViewStylePlain];
        self.zd32_useTable.backgroundColor = [UIColor clearColor];
        self.zd32_useTable.hidden = YES;
        self.zd32_useTable.delegate = self;
        self.zd32_useTable.dataSource = self;
        self.zd32_useTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.zd32_useTable.tableFooterView = [UIView new];
        [self.zd32_useTable registerClass:[YLAF_canUseCell class] forCellReuseIdentifier:NSStringFromClass([YLAF_canUseCell class])];
        [_zd33_bgV addSubview:self.zd32_useTable];
        
        self.zd31_NodataView.frame = self.zd32_getTable.frame;
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
