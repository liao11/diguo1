
#import "YLAF_TimerButton_View.h"
#import "UIView+GrossExtension.h"
#import "YLAF_Theme_Utils.h"
#import "YLAF_Helper_Utils.h"
#import "YLAF_WeakProxy_Utils.h"

@interface YLAF_TimerButton_View ()

@property (nonatomic, strong) UIButton *zd32_Button;
@property (nonatomic, strong) NSTimer *zd32_Timer;
@property (nonatomic, assign) NSInteger zd32_TimeNumber;

@end

@implementation YLAF_TimerButton_View

- (void)dealloc {
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _zd32_Button.blmg_centerY = self.blmg_centerY;
}

- (void)zd32_SetupDefaultViews {
    self.zd32_TimeInterval = 60.0f;
    
    self.zd32_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zd32_Button.frame = CGRectMake(0, 0, 77, 30);
    self.zd32_Button.blmg_right = self.blmg_width;
    self.zd32_Button.titleLabel.font = [YLAF_Theme_Utils khxl_color_NormalFont];
    self.zd32_Button.layer.cornerRadius = 5.0;
    self.zd32_Button.layer.masksToBounds = YES;
    [self.zd32_Button setTitle:MUUQYLocalizedString(@"MUUQYKey_SendButton_Text") forState:UIControlStateNormal];
    [self.zd32_Button setTitleColor:[YLAF_Theme_Utils khxl_SmallGrayColor] forState:UIControlStateNormal];
    [self.zd32_Button addTarget:self action:@selector(zd32_HandleClickedSendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.zd32_Button];
}


- (NSTimer *)zd32_Timer {
    if (!_zd32_Timer) {
        _zd32_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[YLAF_WeakProxy_Utils proxyWithTarget:self] selector:@selector(zd32_RefreshTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_zd32_Timer forMode:NSRunLoopCommonModes];
    }
    return _zd32_Timer;
}


- (void)zd32_RefreshTimer:(NSTimer *)timer {
    if (_zd32_TimeNumber <= 0) {
        [self zd32_u_StopTimer];
    } else {
        [self.zd32_Button setTitle:[NSString stringWithFormat:@"%ziS", self.zd32_TimeNumber] forState:UIControlStateNormal];
    }
    self.zd32_TimeNumber--;
}

- (void)zd32_ResetNormalSendStates {
    [self zd32_u_StopTimer];
}

- (void)zd32_u_StarTimer {
    self.zd32_TimeNumber = self.zd32_TimeInterval;
    [self.zd32_Timer fire];

    self.zd32_Button.enabled = NO;
    self.zd32_Button.backgroundColor = [YLAF_Theme_Utils khxl_color_DisableColor];
}

- (void)zd32_u_StopTimer {
    if (_zd32_Timer != nil) {
        if (_zd32_Timer.isValid) {
            [_zd32_Timer invalidate];
        }
        _zd32_Timer = nil;
    }
    
    self.zd32_Button.enabled = YES;
    [self.zd32_Button setTitle:self.zd32_BtnTitle forState:(UIControlStateNormal)];
    self.zd32_Button.backgroundColor = [YLAF_Theme_Utils khxl_color_ButtonColor];
    [self.zd32_Button setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
}

- (void)zd32_HandleClickedSendBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(zd32_ClickedTimerButtonView:)]) {
        if ([_delegate zd32_ClickedTimerButtonView:self]) {
            [self zd32_u_StarTimer];
        }
    } else {
        [self zd32_u_StarTimer];
    }
}

@end
