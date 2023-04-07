
#import "YLAF_BaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenD3Register_View;
@protocol YLAH_RegisterViewDelegate <NSObject>

- (void)zd31_HandlePopRegisterView:(ZhenD3Register_View *)registerView;
- (void)zd31_HandleDidRegistSuccess:(ZhenD3Register_View *)registerView;

@end

@interface ZhenD3Register_View : YLAF_BaseWindow_View

@property (nonatomic, weak) id<YLAH_RegisterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
