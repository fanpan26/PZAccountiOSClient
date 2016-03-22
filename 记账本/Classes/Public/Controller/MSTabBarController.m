//
//  MSTabBarController.m
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSNavigationController.h"
#import "PZHomeCostListController.h"
#import "PZSummaryController.h"
#import "PZTransformController.h"
#import "MSMyController.h"
#import "MSChatController.h"
#import "MSCommon.h"

@implementation MSTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addControllers];
}

- (void)addControllers
{
    
    NSMutableArray *childControllers = [NSMutableArray array];
    //主页
    PZHomeCostListController *homeChild = [[PZHomeCostListController alloc] initWithStyle:UITableViewStylePlain];
    MSNavigationController *home = [[MSNavigationController alloc] initWithRootViewController:homeChild];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"TabBar_HomeBar"] tag:1];
    [childControllers addObject:home];
    
    //汇总
    PZSummaryController *summaryChild = [[PZSummaryController alloc] init];
    MSNavigationController *summary = [[MSNavigationController alloc] initWithRootViewController:summaryChild];
    summary.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"汇总" image:[UIImage imageNamed:@"TabBar_PublicService"] tag:2];
    [childControllers addObject:summary];
    
    //我的
    PZTransformController *myChild = [[PZTransformController alloc] initWithStyle:UITableViewStylePlain];
    MSNavigationController *my = [[MSNavigationController alloc] initWithRootViewController:myChild];
    my.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"TabBar_Assets"] tag:3];
    [childControllers addObject:my];
    //聊天
    MSChatController *chatChild = [[MSChatController alloc] initWithStyle:UITableViewStylePlain];
    MSNavigationController *chat = [[MSNavigationController alloc] initWithRootViewController:chatChild];
    chat.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"tab_me_nor"] tag:4];
    [childControllers addObject:chat];
    self.viewControllers = childControllers;
    self.tabBar.tintColor = [UIColor orangeColor];
    
}



@end
