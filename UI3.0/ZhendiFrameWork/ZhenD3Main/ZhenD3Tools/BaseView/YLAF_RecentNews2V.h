//
//  YLAF_RecentNews2V.h
//  GiguoFrameWork
//
//  Created by Admin on 2022/11/14.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "YLAF_BaseWindow_View.h"


NS_ASSUME_NONNULL_BEGIN



@class YLAF_RecentNews2V;
@protocol YLAF_RecentNews2VDelegate <NSObject>

- (void)zd31_handleCloseRecentNews2V:(YLAF_RecentNews2V *)recentNewsV;

@end

@interface YLAF_RecentNews2V : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAF_RecentNews2VDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
