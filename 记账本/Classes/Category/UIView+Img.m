//
//  UIView+Img.m
//  MSProduct
//
//  Created by FanYuepan on 16/2/4.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import "UIView+Img.h"
#import "UIImage+MS.h"

@implementation UIView (Img)

-(UIView *)initWithImage:(NSString *)image frame:(CGRect)frame
{
    UIView *backView = [self initWithFrame:frame];
    UIImage *imageView = [UIImage resizeImage:image];
    backView.layer.contents = (id)imageView.CGImage;
    return backView;
}
@end
