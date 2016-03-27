//
//  UIColor+MS.m
//  MSProduct
//
//  Created by FanYuepan on 16/2/4.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import "UIColor+MS.h"

@implementation UIColor (MS)

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorWithHexString: (NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(UIColor *)graduallyColor:(CGFloat)changeHeight hexString:(NSString *)hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [self graduallyColor:changeHeight r:r g:g b:b];
}

+(UIColor *)graduallyColor:(CGFloat)changeHeight r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    //绘制背景渐变
    
    /*
     
     CGCradientCreateWithColorComponents函数需要四个参数：
     
     色彩空间：（Color Space）这是一个色彩范围的容器，类型必须是CGColorSpaceRef.对于这个参数，我们可以传入CGColorSpaceCreateDeviceRGB函数的返回值，它将给我们一个RGB色彩空间。
     
     颜色分量的数组：这个数组必须包含CGFloat类型的红、绿、蓝和alpha值。数组中元素的数量和接下来两个参数密切。从本质来讲，你必须让这个数组包含足够的值，用来指定第四个参数中位置的数量。所以如果你需要两个位置位置（起点和终点），那么你必须为数组提供两种颜色
     
     位置数组，颜色数组中各个颜色的位置：此参数控制该渐变从一种颜色过渡到另一种颜色的速度有多快。
     
     位置的数量：这个参数指明了我们需要多少颜色和位置。
     
     */
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        //两种颜色渐变，第一个是白色，第二个是自定义颜色
       225 / 255.0, 62 / 255.0, 32 / 255.0, 1.00,
        //r * 0.5 / 255.0, g / 255.0, b / 255.0, 1.00,
        r / 255.0, g / 255.0, b / 255.0, 1.00
    };
    
    CGGradientRef myGradient = CGGradientCreateWithColorComponents
    
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    
    // Allocate bitmap context
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, 320, changeHeight, 8, 4 * 320, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
    
    // Draw Gradient Here
    
    /*
     
     创建好线性渐变后，我们将使用CGContextDrawLinearGradient过程在图形上下文中绘制，此过程需要五个参数：
     
     Graphics context 指定用于绘制线性渐变的图形上下文。
     
     Axial gradient 我们使用CGGradientCreateWithColorComponents函数创建的线性渐变对象的句柄
     
     start point 图形上下文中的一个CGPoint类型的点，表示渐变的起点。
     
     End Point表示渐变的终点。
     
     Gradient drawing options 当你的起点或者终点不在图形上下文的边缘内时，指定该如何处理。你可以使用你的开始或结束颜色来填充渐变以外的空间。此参数为以下值之一：KCGGradientDrawsAfterEndLocation扩展整个渐变到渐变的终点之后的所有点 KCGGradientDrawsBeforeStartLocation扩展整个渐变到渐变的起点之前的所有点。0不扩展该渐变。
     
     */
    
    CGContextDrawLinearGradient(bitmapContext, myGradient, CGPointMake(160.0f, 0.0f),CGPointMake(160.0f, changeHeight),  kCGGradientDrawsBeforeStartLocation);
    
    // Create a CGImage from context
    
    CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
    
    // Create a UIImage from CGImage
    
    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
    
    // Release the CGImage
    
    CGImageRelease(cgImage);
    
    // Release the bitmap context
    
    CGContextRelease(bitmapContext);
    
    // Create the patterned UIColor and set as background color
    
    return [UIColor colorWithPatternImage:uiImage];
}


@end
