//
//  NSString+MS.h
//  MSProduct
//
//  Created by FanYuepan on 16/2/8.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MS)

- (CGRect)rectWithFont:(UIFont *)font width:(CGFloat)width;

- (CGSize)sizeSingleLineWithFont:(UIFont *)font;

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;


@end
