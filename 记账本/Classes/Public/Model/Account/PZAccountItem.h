//
//  PZAccountItem.h
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZBaseModel.h"
/*
 addtime = "2016-03-24T10:19:48.217";
 category = 2;
 id = 180;
 money = 1300;
 name = "\U98df";
 other = "\U82f1\U8bed\U8fd8\U6b3e";
 t = 1;
 tname = "\U6d88\U8d39"; */

@interface PZAccountItem : PZBaseModel

@property(nonatomic,assign) NSUInteger unionId;
@property(nonatomic,copy) NSString *addtime;
@property(nonatomic,assign) NSUInteger category;
@property(nonatomic,assign) float money;
@property(nonatomic,copy) NSString *categoryname;
@property(nonatomic,copy) NSString *other;
@property(nonatomic,assign) NSUInteger t;
@property(nonatomic,copy) NSString *tname;
@property(nonatomic,strong,readonly) NSString *detail;

-(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
