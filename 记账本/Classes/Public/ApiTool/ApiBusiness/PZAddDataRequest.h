//
//  PZAddDataRequest.h
//  记账本
//
//  Created by FanYuepan on 16/3/28.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAccountRequest.h"

@interface PZAddDataRequest : PZAccountRequest

-(instancetype)initSalaryTypeWithSalary:(float)money;
-(instancetype)initLastTypeWithLast:(float)money;
-(instancetype)initCostTypeWithCost:(float)money category:(NSUInteger)category other:(NSString *)other;

@end
