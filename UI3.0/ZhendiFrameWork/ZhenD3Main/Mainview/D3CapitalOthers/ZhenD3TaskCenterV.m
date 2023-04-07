//
//  ZhenD3TaskCenterV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenD3TaskCenterV.h"
#import "ZhenD3TaskCell.h"
#import "ZhenD3Account_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "YLAF_Helper_Utils.h"

@interface ZhenD3TaskCenterV ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) UITableView *zd32_table;
@property (nonatomic, strong) NSArray *zd31_secArr;

@end

@implementation ZhenD3TaskCenterV

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:YES];
    
//    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_chongCord")];
    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_taskCenter")];
    
    [self addSubview:self.zd32_table];

    [self zd31_getTaskCenterData];
}

- (void)zd32_HandleClickedCloseBtn:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseTaskV:)]) {
        [self.delegate zd31_handleCloseTaskV:self];
    }
}

- (void)zd31_getTaskCenterData{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer lhxy_getTaskLsitRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd31_secArr = (NSArray *)result.zd32_responeResult;
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
        [weakSelf.zd32_table reloadData];
    }];
}

#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.zd31_secArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier= @"YLAH_TaskCellId";
    ZhenD3TaskCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[ZhenD3TaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    
    if (self.zd31_secArr.count > 0) {
        NSDictionary *khxl_taskDict = self.zd31_secArr[indexPath.row];
        cell.zd31_taskName.text = [NSString stringWithFormat:@"%@",khxl_taskDict[@"title"]];
        cell.zd33_taskDetail.text = [NSString stringWithFormat:@"%@",khxl_taskDict[@"describe"]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *zd32_headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.blmg_width, 0.01)];
    zd32_headV.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
    return zd32_headV;
}


#pragma  mark lazy load

- (UITableView *)zd32_table{
    if (!_zd32_table) {
        _zd32_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.blmg_width, self.blmg_height - 70) style:UITableViewStylePlain];
        _zd32_table.delegate = self;
        _zd32_table.dataSource = self;
        _zd32_table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _zd32_table.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
        UIView *view = [UIView new];
        _zd32_table.tableFooterView = view;
    }
    return _zd32_table;
}

- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

@end
