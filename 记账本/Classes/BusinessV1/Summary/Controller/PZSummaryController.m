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

@implementation PZSummaryController


-(void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)buildUI
{
    [super buildUI];
    
    self.title = @"汇总";
    UIView *summaryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWidth, 200)];
    summaryView.backgroundColor = [UIColor graduallyColor:200 r:238 g:86 b:29];//238 86 29
    [self.view addSubview:summaryView];
}

@end
