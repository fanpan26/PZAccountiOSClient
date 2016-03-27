//
//  PZAllSummary.h
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PZAllSummary : NSObject

@property(nonatomic,assign) float cost;
@property(nonatomic,assign) float last;
@property(nonatomic,assign) float salary;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
