//
//  PZCostItemCell.m
//  记账本
//
//  Created by FanYuepan on 16/3/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZCostItemCell.h"

const CGFloat kPzCostItemCellHeight = 50.0f;

@implementation PZCostItemCell

#pragma mark life cycle

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

#pragma  mark getter setter

-(void)setFrame:(CGRect)frame
{
    frame.size.height = kPzCostItemCellHeight;
    [super setFrame:frame];
}

@end
