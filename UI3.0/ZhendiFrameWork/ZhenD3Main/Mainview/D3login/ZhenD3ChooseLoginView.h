//
//  ZhenD3ChooseLoginView.h
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3ChooseLoginView;

@protocol YLAH_ChooseLoginViewDelegate <NSObject>

- (void)zd33_CloseChooseLoginView:(ZhenD3ChooseLoginView *)loginView loginSucess:(BOOL)success;
- (void)zd33_PresentAccountLoginAndRegisterView:(ZhenD3ChooseLoginView *)loginView;

@end

@interface ZhenD3ChooseLoginView : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_ChooseLoginViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
