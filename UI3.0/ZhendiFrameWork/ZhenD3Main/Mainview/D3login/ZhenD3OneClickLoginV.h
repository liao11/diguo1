//
//  ZhenD3OneClickLoginV.h
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3OneClickLoginV;

@protocol YLAH_OneClickLoginVDelegate <NSObject>

- (void)zd31_HandlePopToLastV:(ZhenD3OneClickLoginV *)registerView;
- (void)zd31_HandleDidOneClickEmailSuccess:(ZhenD3OneClickLoginV *)registerView;
- (void)zd33_PresentFromOneClickToLogin:(ZhenD3OneClickLoginV *)registerView;

@end

@interface ZhenD3OneClickLoginV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_OneClickLoginVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
