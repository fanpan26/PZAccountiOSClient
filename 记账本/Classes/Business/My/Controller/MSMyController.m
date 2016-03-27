//
//  MSMyController.m
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSMyController.h"
#import "MSAddView.h"
#import "MSAddController.h"
#import "MSCommon.h"
#import "MSUserTool.h"
#import "MSPhotoView.h"
#import "MJRefresh.h"
#import "MSHttpFactory.h"

@interface MSMyController()<MSAddViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *cellArray ;
    NSMutableArray *myMoneys;
    UITableView *_tableView;
}

@end

@implementation MSMyController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
    [self reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[MSUserTool sharedMSUserTool] shouldRefreshSummary]){
        [self reloadData];
        //重新设置
        [[MSUserTool sharedMSUserTool] resetSummary];
    }
    
}

-(void)reloadData
{
    NSLog(@"正在刷新");
    [[MSHttpFactory sharedMSHttpFactory] getUserAllDetails:^(id JSON) {
        /*
         "all_everyday" = 172;
         "all_last" = 1;
         "all_salary" = 0;
         */
        NSString *everyday = [NSString stringWithFormat:@"￥%.2f",[JSON[@"all_everyday"] doubleValue]];
        NSString *last = [NSString stringWithFormat:@"￥%.2f",[JSON[@"all_last"] doubleValue]];
        NSString *salary = [NSString stringWithFormat:@"￥%.2f",[JSON[@"all_salary"] doubleValue]];
        myMoneys = [NSMutableArray arrayWithObjects:salary,everyday,last, nil];
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    }];
    
   
}

-(void)buildUI
{
    cellArray  = [NSArray arrayWithObjects:@"我的工资",@"我的消费",@"我的余额", nil];
    myMoneys = [NSMutableArray arrayWithObjects:@"￥0.00",@"￥0.00",@"￥0.00", nil];
    self.title = @"我的";
    //添加头像和详细
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWidth, kMSScreenHeight) style:UITableViewStylePlain];
    
    __weak __typeof(self) weakSelf = self;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //添加最后三个
    MSAddView  *addView = [[MSAddView alloc] initWithFrame:CGRectMake(0,0, 0, 0)];
    addView.delegate = self;
    tableView.tableFooterView = addView;
    [self.view addSubview:tableView];
    
    _tableView = tableView;
}

//
-(void)addView:(MSAddView *)addView btnClickedWithType:(MSAddViewType)type
{
    
    MSAddController *controller = [[MSAddController alloc] init];
    controller.type = type;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGSize photoSize = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeBig];
    return photoSize.height + 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGSize photoSize = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeBig];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWidth, photoSize.height)];
    NSString *photo = [MSUserTool sharedMSUserTool].currentUser.userPhoto;
    MSPhotoView *photoView = [[MSPhotoView alloc] initWithPhoto:photo size:MSPhotoViewSizeBig];
    photoView.photoType = MSPhotoViewTypeRound;
    photoView.frame = CGRectMake(kMSScreenWidth * 0.5 - photoSize.width * 0.5, 10, 0, 0);
    [view addSubview:photoView];
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MS_USER_DETAIL_CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        cell.textLabel.text = cellArray[indexPath.row];
        cell.textLabel.font = kMSFont(13);
        
        cell.detailTextLabel.text = myMoneys[indexPath.row];
        cell.detailTextLabel.font = kMSFont(13);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
}

@end
