//
//  YLAF_MyAccV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/18.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class YLAF_MyAccV;
@protocol YLAF_MyAccVDelegate <NSObject>

- (void)zd31_handleCloseChongMyAccV:(YLAF_MyAccV *)accV;

@end

@interface YLAF_MyAccV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAF_MyAccVDelegate> delegate;
@property (nonatomic, copy, nullable) void(^zd31_HandleBeforeClosedView)(void);

@end

NS_ASSUME_NONNULL_END
