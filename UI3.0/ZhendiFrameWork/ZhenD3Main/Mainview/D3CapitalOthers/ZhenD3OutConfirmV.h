//
//  ZhenD3OutConfirmV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/10/8.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3OutConfirmV;

@protocol YLAH_OutConfirmVDelegate <NSObject>

- (void)zd31_handleCloseOutConfirmV:(ZhenD3OutConfirmV *)confirmV;

@end

@interface ZhenD3OutConfirmV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_OutConfirmVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
