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

@interface PZAddSalaryController()

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
    self.view.backgroundColor = kMSColor(248, 248, 248);
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.salaryText];
    
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

#pragma mark delegate

#pragma mark getter setter
-(PZInputView *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[PZInputView alloc] init];
        _timeLabel.leftTitleText = @"日期";
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
