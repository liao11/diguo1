//
//  YLAF_canGetCell.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLAF_canGetCell : UITableViewCell

@property (nonatomic, strong) UIView *blmg_bgV;
@property (nonatomic, strong) UILabel *zd31_name;
@property (nonatomic, strong) UILabel *zd33_info;
@property (nonatomic, strong) UILabel *limitTime;
@property (nonatomic, strong) UIButton *zd32_getBtn;

@property (nonatomic, copy, nullable) void(^zd31_getBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
