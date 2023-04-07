//
//  ZhenD3BindTelView.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

@class ZhenD3BindTelView;

NS_ASSUME_NONNULL_BEGIN

@protocol YLAH_BindTelViewDelegate <NSObject>

- (void)zd31_handleClosedBindTelView_Delegate:(ZhenD3BindTelView *)bindTelView;
- (void)zd31_handleBindTelSuccess_Delegate:(ZhenD3BindTelView *)bindTelView;

@end

@interface ZhenD3BindTelView : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_BindTelViewDelegate> delegate;
@property (nonatomic, assign) NSInteger zd31_fromFlags;
@property (nonatomic, assign) BOOL blmg_needTiePresent;
@property (nonatomic, copy) NSString *zd31_gameId;
@property (nonatomic, copy) NSString *zd32_roleId;
@property (nonatomic, copy, nullable) void(^zd31_HandleBeforeClosedView)(void);

@end

NS_ASSUME_NONNULL_END
