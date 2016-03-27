//
//  NSString+MS.m
//  MSProduct
//
//  Created by FanYuepan on 16/2/8.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import "NSString+MS.h"

@implementation NSString (MS)


- (CGRect)rectWithFont:(UIFont *)font width:(CGFloat)width{
    //获取字符串显示高度
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return rect;
}

-(CGSize)sizeSingleLineWithFont:(UIFont *)font
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [self sizeWithAttributes:dic];
    return size;
}

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width
{
    CGRect rect = [self rectWithFont:font width:width];
    return rect.size;
}

@end
