//
//  PZHomeCostListController.m
//  记账本
//
//  Created by FanYuepan on 16/3/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZHomeCostListController.h"
#import "PZCostListCell.h"
#import "UIBarButtonItem+MJ.h"
#import "PZAddCostView.h"
#import "Masonry.h"
#import "MSAddController.h"

#import "PZGetAccountListRequest.h"
#import "PZNetWorkAgent.h"

#import "PZGetAccountListReformer.h"

#import "PZAccountItem.h"
#import "PZRequestResult.h"

#import "PZLoadFailedView.h"

static NSString *kPZCostListCellID = @"kPZCostListCellID";

@interface PZHomeCostListController()<PZAddCostViewDelegate,PZBaseRequestDelegate,UIGestureRecognizerDelegate>
{
    PZAddCostView *_costView;
    UIView *_coverView;
}
@property(nonatomic,strong) NSMutableArray *arrayCostList;
@property(nonatomic,strong) PZGetAccountListReformer *getAccountListReformer;
@property(nonatomic,strong) PZGetAccountListRequest *request;

@property(nonatomic,assign) BOOL isRefreshNewData;

@end

@implementation PZHomeCostListController

#pragma  mark life cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[PZCostListCell class] forCellReuseIdentifier:kPZCostListCellID];
    self.tableView.rowHeight = 70;
    
    [self showTitleLoading];
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark private methods

-(void)didHeaderStartedRefresh
{
    [self loadData];
}

-(void)loadData
{
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    self.isRefreshNewData = YES;
    //内部根据requestId做识别码（待优化）
    [self.request prepareRefreshData];
    [agent startWithBaseRequest:self.request];
    
}

//加载下一页
-(void)didFooterStartedRefresh
{
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    self.isRefreshNewData = NO;
    //内部根据requestId做识别码（待优化）
    [self.request prepareLoadNextPage];
    [agent startWithBaseRequest:self.request];}

-(void)buildUI
{
    [super buildUI];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"iconfont-jia" highlightedIcon:@"iconfont-jia-selected" target:self action:@selector(rightClicked:)];
    
}

-(void)rightClicked:(UIBarButtonItem *)item
{
    if (_costView == nil) {
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItems:)];
        recognizer.delegate = self;
        [coverView addGestureRecognizer:recognizer];
        
        _coverView = coverView;
        
        PZAddCostView *costView = [[PZAddCostView alloc] initWithFrame:CGRectZero];
        costView.delegate = self;
        
        [self.navigationController.view addSubview:coverView];
        [coverView addSubview:costView];
        
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationController.view.mas_top);
            make.left.equalTo(self.navigationController.view.mas_left);
            make.size.mas_equalTo(self.navigationController.view.frame.size);
        }];
        _costView = costView;
        CGSize size = _costView.frame.size;
        [_costView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(coverView.mas_right).with.offset(-20);
            make.top.equalTo(coverView.mas_top).with.offset(64);
            make.width.mas_equalTo(size.width);
            make.height.mas_equalTo(size.height);
        }];
    }else{
        _coverView.hidden = !_coverView.hidden;
    }
    
    
}

-(void)tapItems:(UITapGestureRecognizer *)recognizer
{
    _coverView.hidden = YES;
}

#pragma mark gesture delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCostList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PZCostListCell *cell = [tableView dequeueReusableCellWithIdentifier:kPZCostListCellID];
    cell.accountDetail = self.arrayCostList[indexPath.row];
    cell.myTableView = tableView;
    cell.indexPath = indexPath;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //_costView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_coverView setHidden:YES];
}

#pragma mark costview delegate
-(void)costView:(PZAddCostView *)costView didSelectCellWithIdentifier:(NSString *)identifier
{
    //消费信息
    if ([identifier isEqualToString:kPZAddCostTypeCodeCost]) {
        MSAddController *controller = [[MSAddController alloc] init];
        controller.type = MSAddViewTypeEveryDay;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
    //添加余额信息
    if ([identifier isEqualToString:kPZAddCostTypeCodeLast]) {
    }
}

#pragma  mark network delegate

-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
    if(self.isRefreshNewData){
        [self.arrayCostList removeAllObjects];
    }
    PZRequestResult *result = [request fetchDataWithReformer:self.getAccountListReformer];
    if (result.isSuccessData) {
        [self.arrayCostList addObjectsFromArray: result.data];
        [self reloadData];
    }
    [self hideTitleLoadingWithTitle:@"消费支出"];
    [self endHeaderRefreshing];
    [self endFooterRefreshing];
}

-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request{
    [self didReceiveRequestFailed];
}

-(void)requestFailedWithNetworkUnConnected
{
    [self didReceiveRequestFailed];
}

-(void)didReceiveRequestFailed
{
    [self hideTitleLoadingWithTitle:@"加载失败"];
    [self endHeaderRefreshing];
    [self endFooterRefreshing];
}
#pragma  mark  getter setter

-(NSMutableArray *)arrayCostList
{
    if (_arrayCostList == nil) {
        _arrayCostList = [NSMutableArray array];
    }
    return _arrayCostList;
}

-(PZGetAccountListReformer *)getAccountListReformer
{
    if (_getAccountListReformer == nil) {
        _getAccountListReformer = [[PZGetAccountListReformer alloc] init];
    }
    return _getAccountListReformer;
}

-(PZGetAccountListRequest *)request
{
    if (_request == nil) {
        _request = [[PZGetAccountListRequest alloc] init];
        _request.delegate = self;
    }
    return _request;
}

@end
