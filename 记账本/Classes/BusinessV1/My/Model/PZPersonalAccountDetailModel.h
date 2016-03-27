//
//  PZPersonalAccountDetailModel.h
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZBaseModel.h"

@interface PZPersonalAccountDetailModel : PZBaseModel

@property(nonatomic,assign) float cost;
@property(nonatomic,assign) float last;
@property(nonatomic,assign) float salary;
@property(nonatomic,assign) float transin;
@property(nonatomic,assign) float transout;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@property(nonatomic,strong,readonly) NSArray *values;
@end
