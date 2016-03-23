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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)buildUI
{
    [super buildUI];
    self.title = @"首页";
     //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"iconfont-leimu" highlightedIcon:@"iconfont-leimu-selected" target:self action:@selector(leftClicked:)];
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
    for(int i = 0;i<100;i++)
    {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"time"] = @"2016-3-14";
    dict[@"detail"] = @"[转账]消费的详细信息";
    dict[@"photo"] = @"http://qlogo3.store.qq.com/qzone/645857874/645857874/100?1440900705";
    dict[@"name"] = @"范月盘";
    [self.arrayCostList addObject:dict];
    }
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
    cell.dict = self.arrayCostList[indexPath.row];
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
    if ([identifier isEqualToString:kPZAddCostTypeCodeCost]) {
        MSAddController *controller = [[MSAddController alloc] init];
        controller.type = MSAddViewTypeEveryDay;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
    if ([identifier isEqualToString:kPZAddCostTypeCodeLast]) {
        PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
        PZGetAccountListRequest *request = [[PZGetAccountListRequest alloc] initWithUserId:3];
        request.delegate = self;
        [agent startWithBaseRequest:request];
    }
}


-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
    NSDictionary *dict = [request fetchDataWithReformer:self.getAccountListReformer];
    NSLog(@"%@",dict);
}

-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request{
  
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
