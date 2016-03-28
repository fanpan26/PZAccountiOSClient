//
//  PZAddSalaryController.m
//  记账本
//
//  Created by FanYuepan on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAddSalaryController.h"
#import "Masonry.h"
#import "PZInputView.h"
#import "MSCommon.h"
#import "UIBarButtonItem+MJ.h"

#import "PZNetWorkAgent.h"
#import "PZAddDataRequest.h"

@interface PZAddSalaryController()<PZBaseRequestDelegate>

@property(nonatomic,strong) PZInputView *timeLabel;
@property(nonatomic,strong) PZInputView *salaryText;


@end

@implementation PZAddSalaryController

#pragma mark life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}

#pragma  mark private methods

-(void)buildUI
{
    self.edgesForExtendedLayout = NO;
    self.title = @"添加工资";
    self.view.backgroundColor = kMSColor(248, 248, 248);
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.salaryText];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"iconfont-baocun" highlightedIcon:@"iconfont-baocun-selected" target:self action:@selector(rightClicked:)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" highlightedIcon:@"navigationbar_back_highlighted" target:self action:@selector(back:)];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.width.mas_equalTo(kMSScreenWidth);
        make.height.mas_equalTo(44);
    }];
    
    [self.salaryText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.width.mas_equalTo(kMSScreenWidth);
        make.height.mas_equalTo(44);
    }];
}


-(void)rightClicked:(UIBarButtonItem *)item
{
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    float money = 1000.0f;
    PZAddDataRequest *request = [[PZAddDataRequest alloc] initSalaryTypeWithSalary:money];
    request.delegate = self;
    [self showTitleLoadingWithTitle:@"保存中..."];
    [agent startWithBaseRequest:request];
}

-(void)back:(UIBarButtonItem *)item
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark delegate

-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
    [self hideTitleLoadingWithTitle:@"添加工资"];
    [self back:nil];
}

-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request
{
    
}
#pragma mark getter setter
-(PZInputView *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[PZInputView alloc] init];
        _timeLabel.leftTitleText = @"日期";
        _timeLabel.rightContentText = [self getDate];
    }
    return _timeLabel;
}

-(PZInputView *)salaryText
{
    if (_salaryText == nil) {
        _salaryText = [[PZInputView alloc] init];
        _salaryText.leftTitleText = @"工资";
    }
    return _salaryText;
}
-(NSString *)getDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}

@end
