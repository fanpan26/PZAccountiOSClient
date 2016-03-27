//
//  UIButton+MS.m
//  MSProduct
//
//  Created by FanYuepan on 16/2/11.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import "UIButton+MS.h"

@implementation UIButton (MS)

+(instancetype)rectRoundButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.layer setCornerRadius:5.0];
    [btn.layer setMasksToBounds:YES];
    return btn;
}
@end
