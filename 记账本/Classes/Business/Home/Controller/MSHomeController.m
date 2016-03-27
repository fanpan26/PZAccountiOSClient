//
//  MSHomeController.m
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSHomeController.h"
#import "MSHttpFactory.h"
#import "MSAccount.h"
#import "MSAccountFrame.h"
#import "MSAccountCell.h"
#import "MSCommon.h"
#import "MSTool.h"
#import "MSUserTool.h"
#import "MSHttpManager.h"
#import "MSChatConfig.h"
#import "MSWebViewController.h"

@interface MSHomeController(){
    NSMutableArray *everyDayBills;
    NSInteger currentIndx  ;
}

@end

@implementation MSHomeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self builduI];
    [self loadData];
}

-(void)startHeaderRefreshing
{
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BOOL shouldUpdate = [[MSUserTool sharedMSUserTool] getUserDefaultsValueForKey:@"HOMELIST"] == 1;
    if (shouldUpdate) {
        [self loadData];
        [[MSUserTool sharedMSUserTool] setUserDefaultsValue:0 forKey:@"HOMELIST"];
    }
}

-(void)loadData
{
    currentIndx = 1;
    everyDayBills = [NSMutableArray array];
    [self showLoading];
    __weak __typeof(self)weakSelf = self;
    [[MSHttpFactory sharedMSHttpFactory] getUserEveryDayWithUserId:-1 index:currentIndx success:^(id JSON) {
        
        [weakSelf hideLoading:JSON == nil];
        if (JSON == nil) {
            //出错了
            NSLog(@"请求服务器出错");
        }else{
           
            NSArray *accounts = [MSAccount accountsWithArray:JSON];
            [accounts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MSAccountFrame *frame = [[MSAccountFrame alloc] init];
                frame.account = obj;
                [everyDayBills addObject:frame];
            }];
            [weakSelf reloadData];
           
        }
         [super startHeaderRefreshing];
    }];
}

-(void)startFooterRefreshing
{
    currentIndx ++;
    __weak __typeof(self)weakSelf = self;
    [[MSHttpFactory sharedMSHttpFactory] getUserEveryDayWithUserId:-1 index:currentIndx success:^(id JSON) {
        
        [weakSelf hideLoading:JSON == nil];
        if (JSON == nil) {
            //出错了
            NSLog(@"请求服务器出错");
        }else{
            
            NSArray *accounts = [MSAccount accountsWithArray:JSON];
            [accounts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MSAccountFrame *frame = [[MSAccountFrame alloc] init];
                frame.account = obj;
                [everyDayBills addObject:frame];
            }];
            [weakSelf reloadData];
            
        }
        [super startFooterRefreshing];
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSAccountFrame *frame = everyDayBills[indexPath.row];
    return frame.cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return everyDayBills.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MS_ACCOUNT_CELL"];
    return  cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(MSAccountCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSAccountFrame *frame = everyDayBills[indexPath.row];
    cell.accountFrame = frame;
    cell.myTableView = tableView;
    cell.indexPath = indexPath;
}
-(void)gotoWKView
{
    MSWebViewController *webViewController = [[MSWebViewController alloc] init];
    webViewController.hidesBottomBarWhenPushed =  YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}
-(void)builduI
{
    self.title = @"账单";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"学院记忆" style:UIBarButtonItemStylePlain target:self action:@selector(gotoWKView)];
    [self.tableView registerClass:[MSAccountCell class] forCellReuseIdentifier:@"MS_ACCOUNT_CELL"];
    self.tableView.backgroundColor = kMSColor(246, 246, 246);
}
@end
