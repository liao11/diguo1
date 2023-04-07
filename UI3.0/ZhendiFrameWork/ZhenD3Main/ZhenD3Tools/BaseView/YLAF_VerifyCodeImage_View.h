
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLAF_VerifyCodeImage_View : UIView

@property (nonatomic, strong) NSString *zd32_codeString;
@property (nonatomic, assign) BOOL isRotation;
@property (nonatomic, copy) void(^zd32_ResultCodeBolck)(NSString *codeString);

- (void)zd32_refreshCode;

@end

NS_ASSUME_NONNULL_END
