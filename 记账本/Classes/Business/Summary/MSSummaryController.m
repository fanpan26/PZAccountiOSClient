//
//  MSSummaryController.m
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSSummaryController.h"
#import "MSSummaryLastView.h"
#import "MSSummaryBottomView.h"
#import "MSCommon.h"
#import "Masonry.h"
#import "MSHttpFactory.h"
#import "MSUserTool.h"
#import "MSSummaryAll.h"

@interface MSSummaryController()
{
    MSSummaryLastView *_lastView;
    MSSummaryBottomView *_bottomView;
}

@end

@implementation MSSummaryController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BOOL shouldUpdate = [[MSUserTool sharedMSUserTool] getUserDefaultsValueForKey:@"SUMMARYLIST"] == 1;
    if (shouldUpdate) {
        [self loadData];
        [[MSUserTool sharedMSUserTool] setUserDefaultsValue:0 forKey:@"SUMMARYLIST"];
    }
}
-(void)buildUI
{
    self.view.backgroundColor = kMSColor(246, 246, 246);
    //添加头部
    MSSummaryLastView *lastView = [[MSSummaryLastView alloc] initWithFrame:CGRectMake(0, 74, kMSScreenWidth, 0)];
    [self.view addSubview:lastView];
    _lastView = lastView;
    
    MSSummaryBottomView *bottomView = [[MSSummaryBottomView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWidth, 150)];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    _bottomView = bottomView;
}

-(void)loadData
{
    [[MSHttpFactory sharedMSHttpFactory] getUserSummarySuccess:^(id JSON) {
        NSArray *data = JSON;
      __block MSSummaryAll *summary = [[MSSummaryAll alloc] init];
        [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger userid = [dict[@"userid"] longValue];
            switch (userid) {
                case 0:
                    summary.allDetail.allMoney = [dict[@"allmoney"] floatValue];
                    break;
                case 1:
                    summary.userDetail1.allMoney = [dict[@"allmoney"] floatValue];
                    break;
                case 2:
                    summary.userDetail2.allMoney = [dict[@"allmoney"] floatValue];
                    break;
                case 3:
                    summary.userDetail3.allMoney = [dict[@"allmoney"] floatValue];
                    break;
                default:
                    break;
            }
        }];
        _lastView.total = summary.allDetail.allMoney;
        _bottomView.all = summary;
    }];
}
@end
