//
//  PZAddSalaryController.h
//  记账本
//
//  Created by FanYuepan on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSBaseViewController.h"

typedef NS_ENUM(NSUInteger,PZAddType) {
    PZAddTypeSalary = 0,
    PZAddTypeLast = 1,
    PZAddTypeCost = 2
};

@interface PZAddSalaryController : MSBaseViewController

@property(nonatomic,assign) PZAddType addType;

@end
