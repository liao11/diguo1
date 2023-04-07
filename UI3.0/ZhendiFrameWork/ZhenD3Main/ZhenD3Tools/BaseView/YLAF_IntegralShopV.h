//
//  YLAF_IntegralShopV.h
//  GiguoFrameWork
//
//  Created by Admin on 2022/4/20.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class YLAF_IntegralShopV;
@protocol YLAF_IntegralShopVDelegate <NSObject>

- (void)zd31_handleCloseIntegralShopV:(YLAF_IntegralShopV *)zd32_V;

@end

@interface YLAF_IntegralShopV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAF_IntegralShopVDelegate> delegate;
@property (nonatomic, copy, nullable) void(^zd31_HandleBeforeClosedView)(void);

@end

NS_ASSUME_NONNULL_END
