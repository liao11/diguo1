//
//  ZhenD3TaskCenterV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3TaskCenterV;
@protocol YLAH_TaskCenterVDelegate <NSObject>

- (void)zd31_handleCloseTaskV:(ZhenD3TaskCenterV *)zd32_taskV;

@end

@interface ZhenD3TaskCenterV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_TaskCenterVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
