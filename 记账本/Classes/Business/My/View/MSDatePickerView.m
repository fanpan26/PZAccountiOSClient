//
//  MSDatePickerView.m
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSDatePickerView.h"
#import "MSCommon.h"

@implementation MSDatePickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.frame = CGRectMake(0, 0, kMSScreenWidth, 200);
    [datePicker addTarget:self action:@selector(datePickClicked:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePicker];
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(0, 200, kMSScreenWidth, 44);
    [confirmButton setTitle:@"确 定" forState:UIControlStateNormal];
    confirmButton.backgroundColor = [UIColor orangeColor];
    [confirmButton addTarget:self action:@selector(confirmSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
}

-(void)confirmSelect:(UIButton *)button
{
    _confirmSelectCallBack(_dateString);
}

-(void)datePickClicked:(UIDatePicker *)datePicker
{
    NSDate *selectedDate = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:selectedDate];
    
    _dateString = dateAndTime;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = kMSScreenWidth;
    frame.size.height = 244;
    [super setFrame:frame];
}
@end
