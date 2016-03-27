//
//  MSDatePickerView.h
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSDatePickerView : UIView
@property(nonatomic,copy,readonly) NSString *dateString;

@property(nonatomic,copy) void(^confirmSelectCallBack)(NSString *selectedDate);
@end
