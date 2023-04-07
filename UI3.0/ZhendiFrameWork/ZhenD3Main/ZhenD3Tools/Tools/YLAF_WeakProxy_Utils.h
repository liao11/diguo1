
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLAF_WeakProxy_Utils : NSProxy

@property (nullable, nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
