//
//  PZTransformView.m
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZTransferView.h"
#import "UIImage+MS.h"
/**
 *  @author fanyuepan, 16-03-15 22:03:25
 *
 *  转账详情View
 */

@interface PZTransferView()

@property(nonatomic,strong) UIImageView *mainView;
@property(nonatomic,strong) UIImageView *transferIconView;
@property(nonatomic,strong) UILabel *detailLabel;
@property(nonatomic,strong) UILabel *moneyLabel;

@end

const CGFloat kPZTransformWidth = 200.0f;
const CGFloat kPZTransformHeight = 80.0f;

@implementation PZTransferView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.mainView];
    }
    return self;
}

#pragma mark layout

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 0, kPZTransformWidth, kPZTransformHeight);
    self.transferIconView.frame = CGRectMake(20, 15, 30, 30);
    
    CGRect detailFrame = self.detailLabel.frame;
    detailFrame.origin.x = CGRectGetMaxX(self.transferIconView.frame) + 5;
    detailFrame.origin.y = 20;
    self.detailLabel.frame = detailFrame;
    
    CGRect moneyLabelFrame = self.moneyLabel.frame;
    moneyLabelFrame.origin.x = detailFrame.origin.x;
    moneyLabelFrame.origin.y = CGRectGetMaxY(self.detailLabel.frame) + 10;
    self.moneyLabel.frame = moneyLabelFrame;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = kPZTransformWidth;
    frame.size.height = kPZTransformHeight;
    [super setFrame:frame];
}



#pragma mark getter
- (UIImageView *)mainView
{
    if (_mainView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //imageView.image = [UIImage resizedImage:@"chat_from_bg" xPos:0.2 yPos:0.9];
        imageView.image = [UIImage resizedImage:@"chat_to_bg" xPos:0.2 yPos:0.9];
        
        [imageView addSubview:self.transferIconView];
        [imageView addSubview:self.detailLabel];
        [imageView addSubview:self.moneyLabel];
        _mainView = imageView;
    }
   
    return _mainView;
}

-(UIImageView *)transferIconView
{
    if (_transferIconView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"09999988"];
        _transferIconView = imageView;
    }
    return _transferIconView;
}

-(UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"已收到对方转账";
        [label sizeToFit];
        _detailLabel = label;
    }
    return _detailLabel;
}

-(UILabel *)moneyLabel
{
    
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"15.00元";
        [label sizeToFit];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

-(CGSize)size
{
    return CGSizeMake(kPZTransformWidth, kPZTransformHeight);
}

-(void)setMoney:(CGFloat)money
{
    _money = money;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f 元",money];
    [self.moneyLabel sizeToFit];
}

-(void)setIsSelf:(BOOL)isSelf
{
    _isSelf = isSelf;
    NSString *image = isSelf ? @"chat_to_bg" : @"chat_from_bg";
    self.mainView.image = [UIImage resizedImage:image xPos:0.2 yPos:0.9];
    if (isSelf) {
        self.detailLabel.text = @"对方已收到转账";
        self.detailLabel.textColor = [UIColor whiteColor];
        self.moneyLabel.textColor = [UIColor whiteColor];
    }
}
@end
