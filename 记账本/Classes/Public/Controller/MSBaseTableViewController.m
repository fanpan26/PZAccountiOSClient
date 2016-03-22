//
//  MSBaseTableViewController.m
//  记账本
//
//  Created by FanYuepan on 16/2/18.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSBaseTableViewController.h"
#import "MBProgressHUD.h"

@interface MSBaseTableViewController()
{
    MBProgressHUD *_hud;
}

@end

@implementation MSBaseTableViewController

-(void)viewDidLoad;
{
    [super viewDidLoad];
    [self buildUI];
}

/*
 下拉刷新要运行的方法，子类重写一定要调用super startHeadRefreshing
 */
-(void)startHeaderRefreshing
{
    //开始下拉刷新
    NSLog(@"开始下拉刷新，刷新后执行endRefreshing方法");
    [self endHeaderRefreshing];
}
/*
 上拉刷新要运行的方法，子类重写一定要调用super startHeadRefreshing
 */
-(void)startFooterRefreshing
{
    //开始上拉刷新
    NSLog(@"开始上拉刷新，刷新后执行endRefreshing方法");
    [self endFooterRefreshing];
}

-(void)endHeaderRefreshing
{
        __unsafe_unretained UITableView *_unretain_tableView = self.tableView;
        [_unretain_tableView.mj_header endRefreshing];
}
-(void)endFooterRefreshing
{
    __unsafe_unretained UITableView *_unretain_tableView = self.tableView;
    [_unretain_tableView.mj_footer endRefreshing];
}

-(void)reloadData
{
    __unsafe_unretained UITableView *_unretain_tableView = self.tableView;
    [_unretain_tableView reloadData];
}



-(void)buildUI
{
    self.edgesForExtendedLayout = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __unsafe_unretained UITableView *_unretain_tableView = self.tableView;
    __weak __typeof(self)_weakSelf = self;
    // 下拉刷新
    _unretain_tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 结束刷新
        [_weakSelf startHeaderRefreshing];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _unretain_tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    _unretain_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 结束刷新
        [_weakSelf startFooterRefreshing];
    }];
}

-(void)showLoading
{
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
}

-(void)hideLoading
{
    [_hud hide:YES];
}

-(void)hideLoading:(BOOL)error
{
    if (!error) {
        [self hideLoading];
    }else{
        _hud.labelText = @"数据读取失败,请刷新重试";
        [_hud hide:YES afterDelay:0.5];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}




@end
