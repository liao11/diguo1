//
//  YLAF_BiCell.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BiTableViewCellBackgroundView : UIView
 
@end

@interface YLAF_BiCell : UITableViewCell

@property (nonatomic, strong) UILabel *zd31_date;
@property (nonatomic, strong) UILabel *zd33_cost;
@property (nonatomic, strong) UILabel *zd31_channel;

@end

NS_ASSUME_NONNULL_END
