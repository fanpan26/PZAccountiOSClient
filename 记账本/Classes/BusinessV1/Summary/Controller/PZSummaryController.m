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
@interface PZSummaryController()<PZBaseRequestDelegate>

@property(nonatomic,strong) PZSummaryReformer *reformer;

@end

@implementation PZSummaryController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
}
-(void)buildUI
{
    [super buildUI];
    
    self.title = @"汇总";
    UIView *summaryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWidth, 200)];
    summaryView.backgroundColor = [UIColor graduallyColor:200 r:238 g:86 b:29];//238 86 29
    [self.view addSubview:summaryView];
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
    NSLog(@"%@",result.data);
}

-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request
{
    
}

-(void)requestFailedWithNetworkUnConnected
{
    NSLog(@"没有网络哦");
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





@end
