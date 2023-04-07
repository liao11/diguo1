
#ifndef YLAF_Macro_Define_h
#define YLAF_Macro_Define_h

#import "ZhenD3SDKGlobalInfo_Entity.h"

#define zd32_decodeString(zd32_Content) [YLAF_Helper_Utils zd32_normalDecodeString:zd32_Content]

#define iOS9Later               ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS11Later              ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define IPHONE6_RETINAPX(px)    (px * (kScreenWidth / 375.0f))
#define IS_IPhoneX              (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))
#define MYMGLog(...)         if (MYMGSDKGlobalInfo.iszd3_openDevLog) { NSLog(__VA_ARGS__);}
#define YLAF_1_PIXEL_SIZE                1

#define YLAFWIDTH [UIScreen mainScreen].bounds.size.width
#define YLAFHEIGHT [UIScreen mainScreen].bounds.size.height

#define WeakSelf __weak typeof(self) weakSelf = self;

static inline void YLAF_RunInMainQueue(dispatch_block_t block){
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

static inline void YLAF_RunInBackgroudQueue(dispatch_block_t block){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            if(block) {
                block();
            }
        }
    });
}

static inline void YLAF_RunAfterInMainQueue(float time, dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(),block);
}

#endif 
