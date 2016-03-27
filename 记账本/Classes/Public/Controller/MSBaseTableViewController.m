//
//  MSBaseTableViewController.m
//  记账本
//
//  Created by FanYuepan on 16/2/18.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSBaseTableViewController.h"
#import "MBProgressHUD.h"
#import "MSCommon.h"

#import "PZLoadingNavigationTitle.h"

@interface MSBaseTableViewController()
{
    MBProgressHUD *_hud;
}

@property(nonatomic,strong) PZLoadingNavigationTitle *loadingTitleView;

@end

@implementation MSBaseTableViewController

-(void)viewDidLoad;
{
    [super viewDidLoad];
    [self buildUI];
}

/*
 下拉刷新要运行的方法
 */
-(void)startHeaderRefreshing
{
    NSLog(@"开始加载数据");
    __unsafe_unretained UITableView *_unretain_tableView = self.tableView;
    [_unretain_tableView.mj_header beginRefreshing];
}
/*
 上拉刷新要运行的方法
 */
-(void)startFooterRefreshing
{
    //开始上拉刷新
    NSLog(@"上拉刷新");
    __unsafe_unretained UITableView *_unretain_tableView = self.tableView;
    [_unretain_tableView.mj_footer beginRefreshing];
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

-(void)didHeaderStartedRefresh
{
    [self endHeaderRefreshing];
}

-(void)didFooterStartedRefresh
{
    [self endFooterRefreshing];
}

-(void)buildUI
{
    //默认带上
    _needHeaderRefresh = YES;
    _needFooterRefresh = YES;
    
    self.edgesForExtendedLayout = NO;
    self.tableView.backgroundColor = kMSColor(248, 248, 248);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __unsafe_unretained UITableView *_unretain_tableView = self.tableView;
    __weak __typeof(self)_weakSelf = self;
    if (self.isNeedHeaderRefresh) {
        // 下拉刷新
        _unretain_tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 结束刷新
            [_weakSelf didHeaderStartedRefresh];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _unretain_tableView.mj_header.automaticallyChangeAlpha = YES;
    }
   
    if (self.isNeedFooterRefresh) {
        // 上拉刷新
        _unretain_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            // 结束刷新
            [_weakSelf didFooterStartedRefresh];
        }];
    }
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

-(void)showTitleLoading
{
    if (!self.navigationItem.titleView) {
        self.navigationItem.titleView = self.loadingTitleView;
    }
    [self.loadingTitleView startAnimation];
}

-(void)hideTitleLoading
{
    [self hideTitleLoadingWithTitle:nil];
}

-(void)hideTitleLoadingWithTitle:(NSString *)title
{
    [self.loadingTitleView stopAnimation];
    if (title) {
        self.title = title;
    }
    if (self.navigationItem.titleView) {
        [self.navigationItem.titleView removeFromSuperview];
        self.navigationItem.titleView = nil;
    }
}

#pragma  mark getter setter

-(void)setNeedHeaderRefresh:(BOOL)needHeaderRefresh
{
    _needHeaderRefresh = needHeaderRefresh;
    if (self.tableView.mj_header) {
        self.tableView.mj_header.hidden = !needHeaderRefresh;
    }
}

-(void)setNeedFooterRefresh:(BOOL)needFooterRefresh
{
    _needFooterRefresh = needFooterRefresh;
    if (self.tableView.mj_footer) {
        self.tableView.mj_footer.hidden = !needFooterRefresh;
    }
}

-(PZLoadingNavigationTitle *)loadingTitleView
{
    if (_loadingTitleView == nil) {
        _loadingTitleView =[[PZLoadingNavigationTitle alloc] initWithTitle:@"加载中..."];
    }
    return _loadingTitleView;
}

@end
