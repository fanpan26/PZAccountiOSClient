//
//  PZAccountItemCell.m
//  记账本
//
//  Created by FanYuepan on 16/3/14.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAccountItemCell.h"
#import "PZIconButton.h"

@interface PZAccountItemCell()
{
    PZIconButton *_btn;
}

@end

@implementation PZAccountItemCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    PZIconButton *btn = [PZIconButton buttonWithType:UIButtonTypeCustom];

    [self.contentView addSubview:btn];
    _btn = btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    
    _btn.frame = self.contentView.bounds;
    
}

//设置图标和标题
-(void)setIcon:(NSString *)icon andTitle:(NSString *)title
{
    NSLog(@"%@",icon);
    NSLog(@"%@",title);
    [_btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [_btn setTitle:title forState:UIControlStateNormal];
    
}




@end
