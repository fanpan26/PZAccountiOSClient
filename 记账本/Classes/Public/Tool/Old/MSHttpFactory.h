//
//  MSHttpFactory.h
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSingleton.h"
#import "MSHttpManager.h"


typedef  void(^MSBusinessSuccessCallBack)(BOOL result);

typedef  NS_ENUM(NSUInteger,MSPostType) {
    MSPostTypeSalary,
    MSPostTypeLast,
    MSPostTypeEveryDay
};

typedef NS_ENUM(NSUInteger,MSCostType) {
    MSCostTypeClothes = 1,//衣
    MSCostTypeFood = 2,   //食
    MSCostTypeBuilding = 3,//住
    MSCostTypeWalking = 4,//行
    MSCostTypeDefault = 0
};

@interface MSHttpFactory : NSObject

single_interface(MSHttpFactory)

/* {t:t,uid:2,month:'2016-2-16',cate:1,money:5000}*/
-(void) postUserDataWithType:(MSPostType)type userid:(NSUInteger)userid month:(NSString *)month cate:(MSCostType)cate money:(double)money other:(NSString *)other issuccess:(MSBusinessSuccessCallBack)success;


-(void)postUserSalaryWithUserid:(NSUInteger)userid month:(NSString *)month money:(double)money issuccess:(MSBusinessSuccessCallBack)success;

-(void)postUserEveryDayWithUserid:(NSUInteger)userid month:(NSString *)month cate:(MSCostType)cate money:(double)money other:(NSString *)other 
issuccess:(MSBusinessSuccessCallBack)success;

-(void)postUserLastWithUserid:(NSUInteger)userid month:(NSString *)month money:(double)money issuccess:(MSBusinessSuccessCallBack)success;


-(void)getUserEveryDayWithUserId:(NSInteger)userid index:(NSInteger)index success:(MSRequestSuccessCallBack)success;

-(void)getUserSalaryWithUserId:(NSInteger)userid index:(NSInteger)index success:(MSRequestSuccessCallBack)success;

-(void)getUserLastWithUserId:(NSInteger)userid index:(NSInteger)index success:(MSRequestSuccessCallBack)success;

-(void)getUserSummarySuccess:(MSRequestSuccessCallBack)success;

-(void)getUserAllDetails:(MSRequestResultSuccessCallBack)success;

/*
 /api/account.ashx?op=add
 operate_userinttrue操作人idtypeinttrue操作类型 1 消费 2 余额 3 薪资 4 转账categoryintfalse消费类别（消费必须）moneydecimaltrue交易金额other
 */
-(void)saveCostWithMoney:(double)money userid:(NSUInteger)userid other:(NSString *)other success:(MSRequestSuccessCallBack)success;

@end
