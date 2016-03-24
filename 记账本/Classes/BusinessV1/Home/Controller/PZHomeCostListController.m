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

static NSString *kPZCostListCellID = @"kPZCostListCellID";

@interface PZHomeCostListController()<PZAddCostViewDelegate,PZBaseRequestDelegate>
{
    PZAddCostView *_costView;
}
@property(nonatomic,strong) NSMutableArray *arrayCostList;
@property(nonatomic,strong) PZGetAccountListReformer *getAccountListReformer;

@end

@implementation PZHomeCostListController

#pragma  mark life cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[PZCostListCell class] forCellReuseIdentifier:kPZCostListCellID];
    self.tableView.rowHeight = 70;
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark private methods
-(void)buildUI
{
    [super buildUI];
    self.title = @"消费支出";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"iconfont-jia" highlightedIcon:@"iconfont-jia-selected" target:self action:@selector(rightClicked:)];
   
}

-(void)rightClicked:(UIBarButtonItem *)item
{
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (_costView == nil) {
        PZAddCostView *costView = [[PZAddCostView alloc] initWithFrame:CGRectZero];
        costView.delegate = self;
        [window addSubview:costView];
        _costView = costView;
    }else{
        _costView.hidden = !_costView.hidden;
    }
    
    CGSize size = _costView.frame.size;
    [_costView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(window.mas_right).with.offset(-20);
        make.top.equalTo(window.mas_top).with.offset(64);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];

}


-(void)loadData
{
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    //内部根据requestId做识别码（待优化）
    PZGetAccountListRequest *request = [[PZGetAccountListRequest alloc] init];
    request.delegate = self;
    [agent startWithBaseRequest:request];
    
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
    _costView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_costView setHidden:YES];
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


-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
   PZRequestResult *result = [request fetchDataWithReformer:self.getAccountListReformer];
    if (result.isSuccessData) {
        self.arrayCostList = result.data;
        [self.tableView reloadData];
    }else{
        NSLog(@"%@",result.data);
    }

}

-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request{
   
}

-(void)requestFailedWithNetworkUnConnected
{
    NSLog(@"对不起，没有网络");
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

@end
