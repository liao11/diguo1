//
//  ZhenD3OutConfirmV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/10/8.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenD3OutConfirmV.h"
#import "ZhenD3SDKMainView_Controller.h"
@interface ZhenD3OutConfirmV ()

@property (nonatomic, strong) UIView *zd33_bgV;


@end

@implementation ZhenD3OutConfirmV

- (instancetype)init {
    if (self = [super initWithCurType:@"2"]) {
        [self zd32_setupViews];
    }
    return self;
}

- (void)zd32_setupViews {
    
    [self zd32_ShowCloseBtn:false];
    
    [self setTitle:MUUQYLocalizedString(@"MUUQYKey_quietNotice")];
    
    [self addSubview:self.zd33_bgV];
    

    UIButton *zd32_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zd32_cancelBtn.frame = CGRectMake(30, 15, self.zd33_bgV.blmg_width/2 - 45, 45);
    zd32_cancelBtn.backgroundColor = UIColor.whiteColor;
    zd32_cancelBtn.layer.cornerRadius = 22.5f;
    zd32_cancelBtn.layer.borderColor = [YLAF_Theme_Utils khxl_color_LightGrayColor].CGColor;
    zd32_cancelBtn.layer.borderWidth = 0.5;
    zd32_cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [zd32_cancelBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_nowCancel") forState:UIControlStateNormal];
    [zd32_cancelBtn setTitleColor:[YLAF_Theme_Utils khxl_color_LightGrayColor] forState:UIControlStateNormal];
    [zd32_cancelBtn addTarget:self action:@selector(zd33_cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:zd32_cancelBtn];
    
    UIButton *zd31_outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zd31_outBtn.frame = CGRectMake(self.zd33_bgV.blmg_width/2 + 30, 15, self.zd33_bgV.blmg_width/2 - 45, 45);
    zd31_outBtn.backgroundColor = [YLAF_Theme_Utils khxl_color_FBBlueColor];
    zd31_outBtn.layer.cornerRadius = 22.5f;
    zd31_outBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [zd31_outBtn setTitle:MUUQYLocalizedString(@"MUUQYKey_nowQuiet") forState:UIControlStateNormal];
    [zd31_outBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [zd31_outBtn addTarget:self action:@selector(blmg_outClick) forControlEvents:UIControlEventTouchUpInside];
    [self.zd33_bgV addSubview:zd31_outBtn];
}

- (void)zd33_cancelClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zd31_handleCloseOutConfirmV:)]) {
        [self.delegate zd31_handleCloseOutConfirmV:self];
    }
}

- (void)blmg_outClick{
    [ZhenD3SDKMainView_Controller zd31_logoutAction];
}


- (UIView *)zd33_bgV{
    if (!_zd33_bgV) {
        _zd33_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.blmg_width, self.blmg_height - 55 - 25)];
        
    }
    return _zd33_bgV;
}

@end
