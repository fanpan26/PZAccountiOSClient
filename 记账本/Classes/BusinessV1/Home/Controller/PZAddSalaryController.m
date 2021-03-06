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
@property(nonatomic,strong) PZInputView *otherText;
@property(nonatomic,copy) NSString *typeString;

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
    self.title = [NSString stringWithFormat:@"添加%@",self.typeString];
    self.view.backgroundColor = kMSColor(248, 248, 248);
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.salaryText];
    [self.view addSubview:self.otherText];
    
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
    
    [self.otherText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.salaryText.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.width.mas_equalTo(kMSScreenWidth);
        make.height.mas_equalTo(44);
    }];
}


-(void)rightClicked:(UIBarButtonItem *)item
{
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    float money = [self.salaryText.inputText floatValue];
    if (money <= 0) {
        [self back:nil];
        return;
    }
    PZAddDataRequest *request ;
    if (self.addType == PZAddTypeSalary) {
        request = [[PZAddDataRequest alloc] initSalaryTypeWithSalary:money];
    }else if(self.addType == PZAddTypeLast){
        request = [[PZAddDataRequest alloc] initLastTypeWithLast:money];
    }else{
        NSString *other = self.otherText.inputText;
        request = [[PZAddDataRequest alloc] initCostTypeWithCost:money category:2 other:other];
    }
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
    [self hideTitleLoadingWithTitle:[NSString stringWithFormat:@"添加%@",self.typeString]];
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
        _timeLabel.isTextReadOnly = YES;
    }
    return _timeLabel;
}

-(PZInputView *)salaryText
{
    if (_salaryText == nil) {
        _salaryText = [[PZInputView alloc] init];
        _salaryText.leftTitleText = self.typeString;
    }
    return _salaryText;
}

-(PZInputView *)otherText
{
    if (_otherText == nil) {
        _otherText = [[PZInputView alloc] init];
        _otherText.leftTitleText = @"备注";
        _otherText.keyboardType = PZInputViewKeyboardTypeText;
        _otherText.hidden = YES;
    }
    return  _otherText;
}
-(NSString *)getDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}

-(void)setAddType:(PZAddType)addType
{
    _addType = addType;
    switch (addType) {
        case PZAddTypeCost:
            self.typeString = @"消费";
            self.otherText.hidden = NO;
            break;
        case PZAddTypeLast:
            self.typeString = @"余额";
            break;
        case PZAddTypeSalary:
            self.typeString = @"工资";
            break;
            
        default:
            break;
    }
}

@end
