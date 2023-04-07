
#import "YLAF_Progress_View.h"
#import "YLAF_Theme_Utils.h"
#import "UIView+GrossExtension.h"

@interface YLAF_Progress_View ()

@property(nonatomic, strong, nullable) UIView* zd32_ProgressView;
@end

@implementation YLAF_Progress_View

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zd32_SetupDefaultViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self zd32_SetupDefaultViews];
    }
    return self;
}

- (void)zd32_SetupDefaultViews {
    self.layer.borderColor =  [YLAF_Theme_Utils khxl_color_MainColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = self.blmg_height / 2.0;
    self.layer.masksToBounds = YES;
    
    self.zd32_ProgressView = [[UIView alloc] initWithFrame:self.bounds];
    self.zd32_ProgressView.layer.masksToBounds = YES;
    self.zd32_ProgressView.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    [self addSubview:self.zd32_ProgressView];
}

- (void)setProgress:(float)progress {
    _progress = progress;
    self.zd32_ProgressView.blmg_width = self.blmg_width * progress;
}

@end
