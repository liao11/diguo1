//
//  YLAF_ChongCell.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface TableViewCellBackgroundView : UIView
 
@end

@interface YLAF_ChongCell : UITableViewCell

@property (nonatomic, strong) UILabel *zd31_chongTime;
@property (nonatomic, strong) UILabel *zd33_orderNum;
@property (nonatomic, strong) UILabel *zd31_orderMoney;
@property (nonatomic, strong) UIImageView *lhxy_statues;
@property (nonatomic, strong) UILabel *zd32_orderRole;
@property (nonatomic, strong) UILabel *lhxy_orderServe;

@end

NS_ASSUME_NONNULL_END
