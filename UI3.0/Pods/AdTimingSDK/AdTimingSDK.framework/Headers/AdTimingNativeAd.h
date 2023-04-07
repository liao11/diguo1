//
//  AdTimingNativeAd.h
//  AdTiming SDK
//
//  Copyright 2017 AdTiming Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// The AdTimingNative represents ad metadata to allow you to construct custom ad views.
@interface AdTimingNativeAd : NSObject

/// Typed access to the ad title.
@property (nonatomic, copy) NSString *title;

/// Typed access to the body text, usually a longer description of the ad.
@property (nonatomic, copy) NSString *body;

/// Typed access to the ad icon.
@property (nonatomic, copy) NSString *iconUrl;

/// Typed access to the call to action phrase of the ad.
@property (nonatomic, copy) NSString *callToAction;

/// Typed access to the ad star rating.
@property (nonatomic, assign) double rating;

@end

NS_ASSUME_NONNULL_END
