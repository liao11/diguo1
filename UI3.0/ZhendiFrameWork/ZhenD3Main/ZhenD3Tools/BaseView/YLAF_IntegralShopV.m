//
//  YLAF_IntegralShopV.m
//  GiguoFrameWork
//
//  Created by Admin on 2022/4/20.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "YLAF_IntegralShopV.h"
#import "ZhenD3Account_Server.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_IntergralShopCell.h"
#import "UIImageView+WebCache.h"
#import "ZhenD3SDKGlobalInfo_Entity.h"
#import "NSString+GrossExtension.h"
@interface YLAF_IntegralShopV ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) ZhenD3Account_Server *zd31_AccountServer;
@property (nonatomic, strong) UIView *zd33_bgV;
@property (nonatomic, strong) UICollectionView *blmg_collect;
@property (nonatomic, strong) UISegmentedControl *zd32_segment;
@property (nonatomic, strong) NSArray *zd31_typeArr;
@property (nonatomic, strong) NSMutableArray *zd3_itemArr;

@end

@implementation YLAF_IntegralShopV

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:YES];
    
    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_countShip")];
    
    [self zd32_getGoodType];
    
    [self addSubview:self.zd33_bgV];
        
}

- (void)zd32_getGoodType{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_getGoodTypeRequest:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd31_typeArr = (NSArray *)result.zd32_responeResult;
            if (weakSelf.zd31_typeArr.count > 0) {
                [weakSelf zd31_buildSegmentWithzd3_arr:(NSArray *)result.zd32_responeResult];
            }
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd32_getGoodWithblmg_goodType:(NSString *)blmg_goodType{
    [MBProgressHUD zd32_ShowLoadingHUD];
    self.zd3_itemArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [self.zd31_AccountServer zd31_getGoodListWithblmg_goodType:blmg_goodType responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD zd32_DismissLoadingHUD];
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            weakSelf.zd3_itemArr = [NSMutableArray arrayWithArray:(NSArray *)result.zd32_responeResult];
            [weakSelf.blmg_collect reloadData];
        } else {
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
        }
    }];
}

- (void)zd31_buildSegmentWithzd3_arr:(NSArray *)zd3_arr{
    
    NSMutableArray *zd32_namesArr = [NSMutableArray array];
    for (NSDictionary *dict in zd3_arr) {
        [zd32_namesArr addObject:dict[@"name"]];
    }
    
    self.zd32_segment = [[UISegmentedControl alloc] initWithItems:zd32_namesArr];
    self.zd32_segment.tintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    [self.zd32_segment setBackgroundColor:[YLAF_Theme_Utils khxl_color_headBgColor]];
    NSDictionary *zd32_atru = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:10]};
    //[NSDictionary dictionaryWithObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];

    [self.zd32_segment setTitleTextAttributes:zd32_atru forState:UIControlStateNormal];
    if (@available(iOS 13.0, *)) {
        self.zd32_segment.selectedSegmentTintColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    } else {
        
    }
    
    self.zd32_segment.frame = CGRectMake(0, 0, self.blmg_width, 30);
    [self.zd32_segment addTarget:self action:@selector(zd31_SegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.zd32_segment.selectedSegmentIndex = 0;
    self.zd32_segment.tag = 200;
    [self.zd33_bgV addSubview:self.zd32_segment];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (self.blmg_width - 40) / 2;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView *blmg_collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.zd32_segment.blmg_bottom + 10, self.zd33_bgV.blmg_width, self.zd33_bgV.blmg_height - 40) collectionViewLayout:layout];
    [blmg_collect registerClass:[YLAF_IntergralShopCell class] forCellWithReuseIdentifier:@"YLAF_IntergralShopCellID"];
    blmg_collect.dataSource = self;
    blmg_collect.delegate = self;
    blmg_collect.backgroundColor = [UIColor whiteColor];
    self.blmg_collect = blmg_collect;
    
    [self.zd33_bgV addSubview:blmg_collect];
    
    [self zd32_getGoodWithblmg_goodType:zd3_arr[0][@"type"]];
}

- (void)zd31_SegmentedControlValueChanged:(UISegmentedControl *)seg {
    [self zd32_getGoodWithblmg_goodType:self.zd31_typeArr[seg.selectedSegmentIndex][@"type"]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.zd3_itemArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YLAF_IntergralShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YLAF_IntergralShopCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (self.zd3_itemArr.count > 0) {
        [cell.blmg_icon sd_setImageWithURL:[NSURL URLWithString:self.zd3_itemArr[indexPath.row][@"img"]] placeholderImage:nil];
        cell.zd31_name.text = [NSString stringWithFormat:@"%@",self.zd3_itemArr[indexPath.row][@"name"]];
        cell.zd33_accInter.text = [NSString stringWithFormat:@"%@ Điểm +  %@ VND",self.zd3_itemArr[indexPath.row][@"point"],self.zd3_itemArr[indexPath.row][@"amount"]];
        cell.zd32_lastNum.text = [NSString stringWithFormat:@"Còn dư %@/%@",self.zd3_itemArr[indexPath.row][@"used"],self.zd3_itemArr[indexPath.row][@"total"]];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : MYMGSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[MYMGSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [MYMGSDKGlobalInfo.userInfo.token hash_base64Encode]?:@"",@"redirect_type":@"go_point_shop"};
    BOOL zd31_GvCheck = MYMGSDKGlobalInfo.zd31_GvCheck;
    NSString *url = [ZhenD3RemoteData_Server zd32_BuildFinalUrl:zd31_GvCheck?MYMGUrlConfig.zd32_httpsdomain.zd32_returnupsBaseUrl:MYMGUrlConfig.zd32_httpsdomain.zd32_backupsBaseUrl WithPath:MYMGUrlConfig.zd32_rcppathconfig.zd32_rcpAutoLoginPath andParams:params];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


- (void)zd32_HandleClickedCloseBtn:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseIntegralShopV:)]) {
        [self.delegate zd31_handleCloseIntegralShopV:self];
    }
}

- (UIView *)zd33_bgV{
    if (!_zd33_bgV) {
        _zd33_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.blmg_width, self.blmg_height - 55 - 25)];
    }
    return _zd33_bgV;
}


- (ZhenD3Account_Server *)zd31_AccountServer {
    if (!_zd31_AccountServer) {
        _zd31_AccountServer = [[ZhenD3Account_Server alloc] init];
    }
    return _zd31_AccountServer;
}

@end
