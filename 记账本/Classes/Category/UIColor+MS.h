//
//  UIColor+MS.h
//  MSProduct
//
//  Created by FanYuepan on 16/2/4.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MS)

+ (UIColor *)colorWithHexString: (NSString *)hexString;

+ (UIColor *)graduallyColor:(CGFloat)changeHeight r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

+ (UIColor *)graduallyColor:(CGFloat)changeHeight hexString:(NSString *)hexString;
@end
