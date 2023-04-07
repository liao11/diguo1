//
//  YLAF_BaseTextField.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/7/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "YLAF_BaseTextField.h"
#import <objc/runtime.h>

@implementation YLAF_BaseTextField

-(void)changePlaceholder{
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    placeholderLabel.textColor = _placeholderColor;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self changePlaceholder];
}

-(void)setPlaceholder:(NSString *)placeholder{
    [super setPlaceholder:placeholder];
    [self changePlaceholder];
}


@end
