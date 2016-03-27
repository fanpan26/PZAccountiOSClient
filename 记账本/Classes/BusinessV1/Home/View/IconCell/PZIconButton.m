//
//  PZIconButton.m
//  记账本
//
//  Created by FanYuepan on 16/3/14.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZIconButton.h"

@implementation PZIconButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = contentRect;
    rect.origin.y = 10;
    rect.size.height = (self.frame.size.height  - 20) * 0.5;
    return rect;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = contentRect;
    rect.origin.y = self.frame.size.height * 0.5;
    rect.size.height = (self.frame.size.height  - 20) * 0.5;
    return rect;
}
@end
