//
//  YLAF_RecentNewsV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class YLAF_RecentNewsV;
@protocol YLAF_RecentNewsVDelegate <NSObject>

- (void)zd31_handleCloseRecentNewsV:(YLAF_RecentNewsV *)recentNewsV;

@end

@interface YLAF_RecentNewsV : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAF_RecentNewsVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
