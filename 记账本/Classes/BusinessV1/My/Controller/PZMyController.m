//
//  PZMyController.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZMyController.h"
#import "PZMyHeaderView.h"

#import "MSUserTool.h"
#import "MSCurrentUser.h"

#import "PZAccountDetailCell.h"

#import "PZNetWorkAgent.h"
#import "PZPersonalSummaryRequest.h"
#import "PZPersonalAccountReformer.h"
#import "PZPersonalAccountDetailModel.h"

@interface PZMyController()<PZBaseRequestDelegate>

@property(nonatomic,strong,readonly) NSArray *accountTypes;
@property(nonatomic,strong) NSArray *accountMoneys;

@property(nonatomic,strong) PZPersonalAccountReformer *reformer;

@end

@implementation PZMyController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showTitleLoading];
    [self loadData];
}

-(void)didHeaderStartedRefresh
{
    [self loadData];
}

-(void)loadData
{
    
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    PZPersonalSummaryRequest *request = [[PZPersonalSummaryRequest alloc] init];
    request.delegate = self;
    [agent startWithBaseRequest:request];
}

#pragma mark network delegate

-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
    PZRequestResult *result = [request fetchDataWithReformer:self.reformer];
    if(result.isSuccessData){
        PZPersonalAccountDetailModel *model = result.data;
        self.accountMoneys = model.values;
        [self reloadData];
    }
    [self hideTitleLoadingWithTitle:@"我的"];
    [self endHeaderRefreshing];
}
-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request
{
    [self hideTitleLoadingWithTitle:@"加载失败..."];
    [self endHeaderRefreshing];
}

-(void)requestFailedWithNetworkUnConnected
{
    NSLog(@"没有网络");
    [self hideTitleLoadingWithTitle:@"加载失败..."];
    [self endHeaderRefreshing];
}

#pragma  mark private methods

-(void)buildUI
{
    [super buildUI];
    
    self.needFooterRefresh = NO;//不需要下拉刷新
    MSCurrentUser *user = [MSUserTool sharedMSUserTool].currentUser;
    PZMyHeaderView *headerView = [[PZMyHeaderView alloc] initWithPhoto:user.userPhoto name:user.userName];
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accountTypes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PZAccountDetailType type = [self.accountTypes[indexPath.row] integerValue];
    float money = [self.accountMoneys[indexPath.row] floatValue];
    PZAccountDetailCell *cell = [PZAccountDetailCell cellWithType:type money:money inTableView:tableView atIndexPath:indexPath];
    return cell;
}


#pragma mark getter setter
-(NSArray *)accountTypes
{
    return [NSArray arrayWithObjects:@(PZAccountDetailTypeCost),@(PZAccountDetailTypeLast),@(PZAccountDetailTypeSalary),@(PZAccountDetailTypeTransIn),@(PZAccountDetailTypeTransOut), nil];
}

-(NSArray *)accountMoneys
{
    if (_accountMoneys == nil) {
        _accountMoneys = [NSArray arrayWithObjects:@(0.00),@(0.00),@(0.00),@(0.00),@(0.00), nil];
    }
    return _accountMoneys;
}

-(PZPersonalAccountReformer *)reformer
{
    if (_reformer == nil) {
        _reformer = [[PZPersonalAccountReformer alloc] init];
    }
    return _reformer;
}
@end
