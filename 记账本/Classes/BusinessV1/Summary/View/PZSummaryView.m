//
//  PZSummaryView.m
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZSummaryView.h"
#import "UIColor+MS.h"
#import "MSCommon.h"
#import "Masonry.h"
#import "PZAllSummary.h"

@interface PZSummaryView()

@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *moneyLabel;
@property(nonatomic,strong) UILabel *bottomLeftTitleLabel;
@property(nonatomic,strong) UILabel *bottomLeftMoneyLabel;
@property(nonatomic,strong) UIImageView *middleView;
@property(nonatomic,strong) UILabel *bottomRightTitleLabel;
@property(nonatomic,strong) UILabel *bottomRightMoneyLabel;
@property(nonatomic,strong) UIView *bottomLineView;

@end

@implementation PZSummaryView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    [self.mainView addSubview:self.titleLabel];
    [self.mainView addSubview:self.moneyLabel];
    [self addSubview:self.mainView];
    
    [self addSubview:self.bottomLeftTitleLabel];
    [self addSubview:self.bottomLeftMoneyLabel];
    [self addSubview:self.middleView];
    [self addSubview:self.bottomRightTitleLabel];
    [self addSubview:self.bottomRightMoneyLabel];
    [self addSubview:self.bottomLineView];
    
}

-(void)layoutSubviews
{
    const NSUInteger bottomLeftMargin = 20;
    [super layoutSubviews];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(kMSScreenWidth,200));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_top).with.offset(30);
        make.centerX.equalTo(self.mainView.mas_centerX);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.mainView.mas_centerX);
    }];
    
    //bottom
    [self.bottomLeftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).offset(bottomLeftMargin);
    }];
    [self.bottomLeftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLeftTitleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).offset(bottomLeftMargin);
    }];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mainView.mas_bottom).with.offset(20);
    }];
    [self.bottomRightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView.mas_right).with.offset(bottomLeftMargin);
        make.top.equalTo(self.mainView.mas_bottom).with.offset(10);
    }];
    [self.bottomRightMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomRightTitleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.middleView.mas_right).with.offset(bottomLeftMargin);
    }];
    //
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(kMSScreenWidth, 1));
    }];
    
}


#pragma mark getter setter

-(void)setData:(PZAllSummary *)data
{
    _data = data;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",data.last];
    self.bottomLeftMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",data.cost];
    self.bottomRightMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",data.salary];
    [self setNeedsLayout];
}

-(UIView *)mainView
{
    if (_mainView == nil) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWidth, 200)];
        _mainView.backgroundColor = [UIColor graduallyColor:200 r:238 g:86 b:29];//238 86 29
    }
    return _mainView;
}

-(UILabel *)titleLabel
{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"资金总额(元)";
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UILabel *)moneyLabel
{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:50];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.text = @"0.00";
        [_moneyLabel sizeToFit];
    }
    return _moneyLabel;
}

-(UILabel *)bottomLeftMoneyLabel
{
    if (_bottomLeftMoneyLabel == nil) {
        _bottomLeftMoneyLabel = [[UILabel alloc] init];
        _bottomLeftMoneyLabel.textColor = kMSColor(251, 77, 13);
        _bottomLeftMoneyLabel.text = @"0.00";
        [_bottomLeftMoneyLabel sizeToFit];
    }
    return _bottomLeftMoneyLabel;
}

-(UILabel *)bottomLeftTitleLabel
{
    if (_bottomLeftTitleLabel == nil) {
        _bottomLeftTitleLabel = [[UILabel alloc] init];
        _bottomLeftTitleLabel.font  = [UIFont systemFontOfSize:14];
        _bottomLeftTitleLabel.textColor = kMSColor(139, 149, 163);
        _bottomLeftTitleLabel.text = @"消费总额";
        [_bottomLeftTitleLabel sizeToFit];
    }
    return _bottomLeftTitleLabel;
}

-(UILabel *)bottomRightMoneyLabel
{
    if (_bottomRightMoneyLabel == nil) {
        _bottomRightMoneyLabel = [[UILabel alloc] init];
        _bottomRightMoneyLabel.textColor = kMSColor(251, 77, 13);
        _bottomRightMoneyLabel.text = @"0.00";
        [_bottomRightMoneyLabel sizeToFit];
    }
    return _bottomRightMoneyLabel;
}

-(UILabel *)bottomRightTitleLabel
{
    if (_bottomRightTitleLabel == nil) {
        _bottomRightTitleLabel = [[UILabel alloc] init];
        _bottomRightTitleLabel.font  = [UIFont systemFontOfSize:14];
        _bottomRightTitleLabel.textColor = kMSColor(139, 149, 163);
        _bottomRightTitleLabel.text = @"工资总额";
        [_bottomRightTitleLabel sizeToFit];
    }
    return _bottomRightTitleLabel;
}

-(UIImageView *)middleView
{
    if (_middleView == nil) {
        _middleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusdetail_comment_top_rule"]];
    }
    return _middleView;
}

-(UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.layer.contents = (id)[UIImage imageNamed:@"cell_separator_line"].CGImage;
    }
    return _bottomLineView;
}


-(CGSize)viewSize
{
    return CGSizeMake(kMSScreenWidth, 260);
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = kMSScreenWidth;
    frame.size.height = 200 + 60;
    [super setFrame:frame];
}
@end
