
#import <UIKit/UIKit.h>
#import "UIView+GrossExtension.h"
#import "MBProgressHUD+GrossExtension.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_Helper_Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLAF_BaseWindow_View : UIView

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithCurType:(NSString *)curType;

- (void)zd32_ShowBackBtn:(BOOL)show;
- (void)zd32_ShowCloseBtn:(BOOL)show;
- (void)zd32_HandleClickedBackBtn:(id)sender;
- (void)zd32_HandleClickedCloseBtn:(id)sender;
@end

NS_ASSUME_NONNULL_END
