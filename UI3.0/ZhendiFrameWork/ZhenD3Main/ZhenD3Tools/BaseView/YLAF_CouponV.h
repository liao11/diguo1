//
//  YLAF_CouponV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class YLAF_CouponV;
@protocol YLAF_CouponVDelegate <NSObject>

- (void)zd31_handleCloseChongCouponV:(YLAF_CouponV *)zd33_couponV;

@end

@interface YLAF_CouponV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAF_CouponVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
