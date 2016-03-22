//
//  MSAddView.m
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 ;;. All rights reserved.
//

#import "MSAddView.h"
#import "MSCommon.h"

@implementation MSAddView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    NSArray *titles = @[@"+工资",@"+余额",@"+消费"];
    CGFloat margin = kMSTableViewContentPaddingHorizontal;
    CGFloat width = (kMSScreenWidth - 4 * margin) / 3;
    for (int i = 0; i < 3 ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(margin * (i + 1) + i * width, 0, width, 100);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn.layer setCornerRadius:10];
        btn.clipsToBounds = YES;
        btn.tag = i + 100; //100 101 102
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)button
{
    NSInteger tag = button.tag;
    MSAddViewType type = MSAddViewTypeEveryDay;
    switch (tag) {
        case 100:
            type = MSAddViewTypeSalary;
            break;
        case 101:
            type = MSAddViewTypeLast;
            break;
        case 102:
            type = MSAddViewTypeEveryDay;
            break;
    }
    if ([_delegate respondsToSelector:@selector(addView:btnClickedWithType:)]) {
        [_delegate addView:self btnClickedWithType:type];
    }
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = kMSScreenWidth;
    frame.size.height = 100;
    [super setFrame:frame];
}

@end
