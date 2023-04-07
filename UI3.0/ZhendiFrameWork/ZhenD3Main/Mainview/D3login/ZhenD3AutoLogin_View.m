
#import "ZhenD3AutoLogin_View.h"
#import "YLAF_Helper_Utils.h"
#import "ZhenD3Login_Server.h"
#import "NSString+GrossExtension.h"
#import "UIView+GrossExtension.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenD3LocalData_Server.h"
@interface ZhenD3AutoLogin_View ()

@property (strong, nonatomic) UIImageView *zd32_AutoLoginHud;
@property (strong, nonatomic) ZhenD3Login_Server *zd32_LoginServer;
@end

@implementation ZhenD3AutoLogin_View

- (void)dealloc {
    [self zd32_u_StopAutoLoginHudAnimation];
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zd32_setupViews];
    }
    return self;
}


- (ZhenD3Login_Server *)zd32_LoginServer {
    if (!_zd32_LoginServer) {
        _zd32_LoginServer = [[ZhenD3Login_Server alloc] init];
    }
    return _zd32_LoginServer;
}


- (void)zd32_setupViews {
    self.frame = CGRectMake(0, 0, 35, 35);
    
    self.zd32_AutoLoginHud = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    self.zd32_AutoLoginHud.center = self.center;
    self.zd32_AutoLoginHud.image = [YLAF_Helper_Utils imageName:@"zdimageloading"];
    [self addSubview:self.zd32_AutoLoginHud];
    
    [self zd32_u_StarAutoLoginHudAnimation];
}


- (void)zd32_u_StarAutoLoginHudAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"%@",@"transform.rotation.z"]];
    rotationAnimation.toValue = @(-M_PI * 2);
    rotationAnimation.repeatCount = HUGE;
    rotationAnimation.duration = 2.0;
    [self.zd32_AutoLoginHud.layer addAnimation:rotationAnimation forKey:[NSString stringWithFormat:@"%@",@"KCBasicAnimation_Rotation_AutoLoginView"]];
}

- (void)zd32_u_StopAutoLoginHudAnimation {
    [self.zd32_AutoLoginHud.layer removeAllAnimations];
}


- (void)zd31_AutoLoginWithLastLoginUser:(ZhenD3UserInfo_Entity *)lastLoginUser {
    __weak typeof(self) weakSelf = self;
    if (![lastLoginUser.userName isValidateMobile]) {
        [self.zd32_LoginServer lhxy_DeviceActivate:lastLoginUser.userName md5Password:lastLoginUser.password responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
            if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_FastAutLoginView:loginSucess:)]) {
                    [weakSelf.delegate zd33_FastAutLoginView:weakSelf loginSucess:YES];
                } else {
                    [weakSelf removeFromSuperview];
                }
            } else {
                if (result.zd32_responseCode == YLAF_ResponseCodePwdError) {
                     [ZhenD3LocalData_Server zd32_removeLoginedUserInfoFormHistory:lastLoginUser];
                }
                
                [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_FastAutLoginView:loginSucess:)]) {
                    [weakSelf.delegate zd33_FastAutLoginView:weakSelf loginSucess:NO];
                }
            }
        }];
    }else{
        [self blmg_telLoginWithAccount:lastLoginUser.userName password:lastLoginUser.password zd32_telDist:MUUQYLocalizedString(@"MUUQYKey_nowDist") lastLoginUser:lastLoginUser];
    }
    
    
    
}

- (void)blmg_telLoginWithAccount:(NSString *)account password:(NSString *)password zd32_telDist:(NSString *)zd32_telDist lastLoginUser:(ZhenD3UserInfo_Entity *)lastLoginUser
{
    [MBProgressHUD zd32_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.zd32_LoginServer lhxy_telLogin:account md5Password:password zd32_telDist:zd32_telDist responseBlock:^(ZhenD3ResponseObject_Entity * _Nonnull result) {
        
        [MBProgressHUD zd32_DismissLoadingHUD];
        
        if (result.zd32_responseCode == YLAF_ResponseCodeSuccess) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_FastAutLoginView:loginSucess:)]) {
                [weakSelf.delegate zd33_FastAutLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            if (result.zd32_responseCode == YLAF_ResponseCodePwdError) {
                 [ZhenD3LocalData_Server zd32_removeLoginedUserInfoFormHistory:lastLoginUser];
            }
            
            [MBProgressHUD zd32_showError_Toast:result.zd32_responeMsg];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zd33_FastAutLoginView:loginSucess:)]) {
                [weakSelf.delegate zd33_FastAutLoginView:weakSelf loginSucess:NO];
            }
        }
    }];
}

@end
