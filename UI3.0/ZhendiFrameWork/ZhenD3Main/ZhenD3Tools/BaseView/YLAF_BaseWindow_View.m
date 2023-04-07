
#import "YLAF_BaseWindow_View.h"

@interface YLAF_BaseWindow_View ()

@property (nonatomic, strong) UILabel *zd32_TitleLab;
@property (nonatomic, strong) UIImageView *zd32_TitleImgV;
@property (nonatomic, strong) UIButton *zd32_BackBtn;
@property (nonatomic, strong) UIButton *zd32_CloseBtn;
@end

@implementation YLAF_BaseWindow_View

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)initWithCurType:(NSString *)curType {
    self = [super init];
    if (self) {
        [self zd32_SetupWindowDefaultsWithCurType:curType];
    }
    return self;
}


- (void)zd32_SetupWindowDefaultsWithCurType:(NSString *)curType {
    if ([curType isEqualToString:@"1"]) {
        self.frame = CGRectMake(0, 0, 320, 300);
    }else if ([curType isEqualToString:@"2"]) {
        self.frame = CGRectMake(0, 0, 320, 140);
    }else{
        self.frame = CGRectMake(0, 0, 320, 360);
    }
    
    self.layer.cornerRadius = 14;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [YLAF_Theme_Utils khxl_color_BackgroundColor];
    
    self.zd32_TitleImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 40, 30)];
    self.zd32_TitleImgV.blmg_centerX = self.blmg_width/2;
    self.zd32_TitleImgV.image = [YLAF_Helper_Utils imageName:@"zdimagelogo"];
    [self addSubview:self.zd32_TitleImgV];
    
    self.zd32_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, self.blmg_width, 36)];
    self.zd32_TitleLab.hidden = !self.zd32_TitleImgV.hidden;
    self.zd32_TitleLab.font = [YLAF_Theme_Utils khxl_color_LargestFont];
//    self.zd32_TitleLab.textColor = [YLAF_Theme_Utils khxl_color_LightColor];
    self.zd32_TitleLab.textColor = [YLAF_Theme_Utils khxl_SmallGrayColor];
    self.zd32_TitleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.zd32_TitleLab];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.zd32_TitleImgV.hidden = (title != nil);
    self.zd32_TitleLab.hidden = !self.zd32_TitleImgV.hidden;
    self.zd32_TitleLab.text = title;
}

- (void)zd32_ShowBackBtn:(BOOL)show {
    if (show) {
        if (_zd32_BackBtn == nil) {
            _zd32_BackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _zd32_BackBtn.frame = CGRectMake(5, 13, 35, 35);
            _zd32_BackBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
            [_zd32_BackBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageback"] forState:UIControlStateNormal];
            [_zd32_BackBtn addTarget:self action:@selector(zd32_HandleClickedBackBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_zd32_BackBtn];
        }
        _zd32_BackBtn.hidden = NO;
    } else {
        _zd32_BackBtn.hidden = YES;
    }
}

- (void)zd32_ShowCloseBtn:(BOOL)show {
    if (show) {
        if (_zd32_CloseBtn == nil) {
            _zd32_CloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _zd32_CloseBtn.frame = CGRectMake(self.blmg_width-35-5, 8, 35, 35);
            _zd32_CloseBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
            [_zd32_CloseBtn setImage:[YLAF_Helper_Utils imageName:@"zdimageclose"] forState:UIControlStateNormal];
            [_zd32_CloseBtn addTarget:self action:@selector(zd32_HandleClickedCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_zd32_CloseBtn];
        }
        _zd32_CloseBtn.hidden = NO;
    } else {
        _zd32_CloseBtn.hidden = YES;
    }
}

- (void)zd32_HandleClickedBackBtn:(id)sender {
    
}

- (void)zd32_HandleClickedCloseBtn:(id)sender {
    
}

@end
