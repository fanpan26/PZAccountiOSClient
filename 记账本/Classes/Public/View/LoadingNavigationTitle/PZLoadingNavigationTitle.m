//
//  PZLoadingNavigationTitle.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZLoadingNavigationTitle.h"

@interface PZLoadingNavigationTitle()

@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic,strong) UILabel *loadingTitle;

@end

@implementation PZLoadingNavigationTitle

-(instancetype)initWithTitle:(NSString *)title
{
    
    if (self = [self initWithFrame:CGRectZero]) {
        self.title = title;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.indicatorView];
        [self addSubview:self.loadingTitle];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.loadingTitle.frame = CGRectMake(44, 0,self.frame.size.width - 44,44);
    self.indicatorView.frame = CGRectMake(0, 0, 44, 44);
}


-(void)setFrame:(CGRect)frame
{
    frame.size.width = 150;
    frame.size.height = 44;
    [super setFrame:frame];
}

-(UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

-(UILabel *)loadingTitle
{
    if (_loadingTitle == nil) {
        _loadingTitle = [[UILabel alloc] init];
        _loadingTitle.font = [UIFont systemFontOfSize:15];
    }
    return _loadingTitle;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.loadingTitle.text = title;
    [self.loadingTitle sizeToFit];
}

-(void)startAnimation
{
    [self.indicatorView startAnimating];
}


-(void)stopAnimation
{
    [self.indicatorView stopAnimating];
}

@end
