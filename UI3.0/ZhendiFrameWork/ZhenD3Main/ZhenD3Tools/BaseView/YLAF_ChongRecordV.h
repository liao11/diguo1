//
//  YLAF_ChongRecordV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class YLAF_ChongRecordV;
@protocol YLAF_ChongRecordVDelegate <NSObject>

- (void)zd31_handleCloseChongRecordV:(YLAF_ChongRecordV *)memberV;

@end

@interface YLAF_ChongRecordV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAF_ChongRecordVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
