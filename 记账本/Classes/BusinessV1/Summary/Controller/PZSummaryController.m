//
//  PZSummaryController.m
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZSummaryController.h"
#import "MSCommon.h"
#import "UIColor+MS.h"

#import "PZNetWorkAgent.h"
#import "PZUserSummaryRequest.h"

#import "PZRequestResult.h"
#import "PZSummaryReformer.h"

#import "PZSummaryView.h"
#import "Masonry.h"
#import "MJRefresh.h"
@interface PZSummaryController()<PZBaseRequestDelegate>

@property(nonatomic,strong) PZSummaryReformer *reformer;
@property(nonatomic,strong) PZSummaryView *summaryView;
@property(nonatomic,strong) UIScrollView *backView;

@end

@implementation PZSummaryController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showTitleLoading];
    [self loadData];
}
-(void)buildUI
{
    [super buildUI];
    
    self.title = @"汇总";
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.summaryView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.size.equalTo(self.view);
    }];
    
    [self.summaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top);
        make.size.mas_equalTo(self.summaryView.viewSize);
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)loadData
{
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    PZUserSummaryRequest *request = [[PZUserSummaryRequest alloc] init];
    request.delegate  = self;
    
    [agent startWithBaseRequest:request];
}

#pragma mark  newwork delegate

-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
    PZRequestResult *result = [request fetchDataWithReformer:self.reformer];
    _summaryView.data = result.data;
    
    [self hideTitleLoadingWithTitle:@"汇总"];
    [self.backView.mj_header endRefreshing];
}

-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request
{
    NSLog(@"哎呀，网络请求出错了呢");
    [self hideTitleLoadingWithTitle:@"加载失败"];
    [self.backView.mj_header endRefreshing];

}

-(void)requestFailedWithNetworkUnConnected
{
    NSLog(@"没有网络哦");
    [self hideTitleLoadingWithTitle:@"加载失败"];
    [self.backView.mj_header endRefreshing];
}

-(void)refresh
{
    [self loadData];
}

#pragma mark getter setter

-(PZSummaryReformer *)reformer

{
    if(_reformer == nil)
    {
        _reformer = [[PZSummaryReformer alloc] init];
    }
    return _reformer;
}

-(PZSummaryView *)summaryView
{
    if (_summaryView == nil) {
         _summaryView = [[PZSummaryView alloc] initWithFrame:CGRectMake(0,0, 0, 0)];
    }
    return _summaryView;
}

-(UIScrollView *)backView
{
    if (_backView == nil) {
        _backView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _backView.bounces = YES;
        _backView.contentSize = self.view.bounds.size;
        _backView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _backView.mj_header.automaticallyChangeAlpha = YES;

    }
    return _backView;
}





@end
