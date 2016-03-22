//
//  MSAccount.h
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCurrentUser.h"

/*
 addtime = "2016-02-18T17:05:53.033";
 costcategory = 0;
 costdate = "2016-02-18";
 costmoney = 13;
 costother = "\U714e\U8c46\U8150";
 id = 3;
 rowId = 1;
 userid = 1;
 */
@interface MSAccount : NSObject

@property(nonatomic,strong) MSCurrentUser *user;
@property(nonatomic,copy,readonly) NSString *moneyDetail;
@property(nonatomic,copy) NSString *addtime;
@property(nonatomic,assign)NSInteger category;
@property(nonatomic,copy) NSString *other;
@property(nonatomic,copy) NSString *date;
@property(nonatomic,copy) NSString *money;

-(instancetype)initWithDictionary:(NSDictionary *)dict;


+(NSArray *)accountsWithArray:(NSArray *)array;
@end
