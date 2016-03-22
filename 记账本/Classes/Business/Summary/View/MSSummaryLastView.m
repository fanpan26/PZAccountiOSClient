//
//  MSSummaryLastView.m
//  记账本
//
//  Created by FanYuepan on 16/2/19.
//  Copyright © 2016年 fyp. All rights reserved.
// 累计存款View

#import "MSSummaryLastView.h"
#import "MSPhotoView.h"
#import "Masonry.h"
#import "NSString+MS.h"
#import "MSCommon.h"
#import "UIImage+MS.h"


@interface MSSummaryLastView()
{
    UILabel *_totalLabel;
}

@end

@implementation MSSummaryLastView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return  self;
}

- (void)buildUI
{
    self.image = [UIImage resizeImage:@"common_card_background.png"];
    
    UILabel *topText = [UILabel new];
    CGSize size = [@"text" sizeSingleLineWithFont:kMSFont(30)];
    topText.textColor = [UIColor orangeColor];
    topText.font = kMSFont(30);
    [self addSubview:topText];
    [topText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kMSTableViewContentPaddingVertical);
        make.left.mas_equalTo(self).with.offset(10);
        make.right.mas_equalTo(self).with.offset(-10);
        make.height.mas_equalTo(size.height);
    }];
    topText.text = @"累计金额";
    topText.textAlignment = NSTextAlignmentCenter;
    
    UILabel *moneyText = [[UILabel alloc] init];
    CGSize sizeMoney = [@"1000" sizeSingleLineWithFont:kMSFont(40)];
    moneyText.textAlignment = NSTextAlignmentCenter;
    moneyText.text = @"￥0.00";
    moneyText.textColor = [UIColor orangeColor];
    moneyText.font = kMSFont(40);
    [self addSubview:moneyText];
    _totalLabel = moneyText;
    
    [moneyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topText.mas_bottom).offset(10);
        make.left.mas_equalTo(self).with.offset(10);
        make.right.mas_equalTo(self).with.offset(-10);
        make.height.mas_equalTo(sizeMoney.height);

    }];
}

-(void)setTotal:(double)total
{
    NSString *totalText = [NSString stringWithFormat:@"￥%.2f",total];
    _totalLabel.text = totalText;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = 150;
    [super setFrame:frame];
}


@end
