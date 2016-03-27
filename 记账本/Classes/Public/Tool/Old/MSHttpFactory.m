//
//  MSHttpFactory.m
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSHttpFactory.h"
#import "MSCommon.h"
#import "MSUserTool.h"

@implementation MSHttpFactory

single_implementation(MSHttpFactory)

-(void)postUserDataWithType:(MSPostType)type userid:(NSUInteger)userid month:(NSString *)month cate:(MSCostType)cate money:(double)money other:(NSString *)other issuccess:(MSBusinessSuccessCallBack)success
{
    /* {t:t,uid:2,month:'2016-2-16',cate:1,money:5000}*/
    
    userid = [MSUserTool sharedMSUserTool].currentUser.userId;
    
    NSString *t = [self getTypeStringWithType:type];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:t,@"t",@(userid),@"uid",month,@"month",@(cate),@"cate",@(money),@"money",other,@"other",nil];
    NSString *url = kMSAPIAddData;
    [[MSHttpManager sharedMSHttpManager] postWithURL:url params:params success:^(id JSON) {
        NSString *status = JSON[@"status"];
        if (success) {
            success([status isEqualToString:@"ok"]);
        }
    } failure:^(NSError *error) {
        if(success){
            success(NO);
        }
    }];
}

-(void)postUserEveryDayWithUserid:(NSUInteger)userid month:(NSString *)month cate:(MSCostType)cate  money:(double)money other:(NSString *)other issuccess:(MSBusinessSuccessCallBack)success
{
    [self postUserDataWithType:MSPostTypeEveryDay userid:userid month:month cate:cate money:money other:other issuccess:success];
}
-(void)postUserLastWithUserid:(NSUInteger)userid month:(NSString *)month money:(double)money issuccess:(MSBusinessSuccessCallBack)success
{
    [self postUserDataWithType:MSPostTypeLast userid:userid month:month cate:MSCostTypeBuilding money:money other:nil issuccess:success];
}
-(void)postUserSalaryWithUserid:(NSUInteger)userid month:(NSString *)month money:(double)money issuccess:(MSBusinessSuccessCallBack)success
{
    [self postUserDataWithType:MSPostTypeSalary userid:userid month:month cate:MSCostTypeBuilding money:money other:nil issuccess:success];
}

-(void)getUserEveryDayWithUserId:(NSInteger)userid index:(NSInteger)index success:(MSRequestSuccessCallBack)success
{
     [self getUserDatasWithUserId:userid type:@"everyday" index:index success:success];
}

-(void)getUserLastWithUserId:(NSInteger)userid index:(NSInteger)index success:(MSRequestSuccessCallBack)success
{
    [self getUserDatasWithUserId:userid type:@"last" index:index success:success];
}

-(void)getUserSalaryWithUserId:(NSInteger)userid index:(NSInteger)index success:(MSRequestSuccessCallBack)success
{
    [self getUserDatasWithUserId:userid type:@"salary" index:index success:success];
}

-(void)getUserDatasWithUserId:(NSInteger)userid type:(NSString *)type index:(NSInteger)index success:(MSRequestSuccessCallBack)success{
    
    userid = userid == -1 ? 0 : [MSUserTool sharedMSUserTool].currentUser.userId;
    
    NSString *baseApi = kMSAPIGetUserDatas;
    NSMutableString *url = [NSMutableString stringWithString:baseApi];
    [url appendFormat:@"?t=%@&uid=%ld&index=%ld",type,userid,index];
    
    [[MSHttpManager sharedMSHttpManager]getWithURL:url params:nil success:^(id JSON) {
        if (success) {
            success(JSON[@"data"]);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(nil);
        }
        success(nil);
    }];
}

-(void)getUserSummarySuccess:(MSRequestSuccessCallBack)success
{
    [self getUserDatasWithUserId:0 type:@"summary" index:1 success:success];
}

-(void)getUserAllDetails:(MSRequestResultSuccessCallBack)success
{
    [self getUserDatasWithUserId:0 type:@"userdetail" index:0 success:success];
}

-(void)saveCostWithMoney:(double)money userid:(NSUInteger)userid other:(NSString *)other success:(MSRequestSuccessCallBack)success
{
    //operate_userinttrue操作人idtypeinttrue操作类型 1 消费 2 余额 3 薪资 4 转账categoryintfalse消费类别（消费必须）moneydecimaltrue交易金额other
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    userid = [MSUserTool sharedMSUserTool].currentUser.userId;
    dict[@"operate_user"] = @(userid);
    dict[@"other"] = other;
    dict[@"money"] = @(money);
    dict[@"type"] = @1;
    dict[@"category"] = @2;
    
    dict[@"token"] = @123123;
    
    [[MSHttpManager sharedMSHttpManager] postWithURL:@"http://imfyp.com/api/account.ashx?op=add" params:dict success:^(id JSON) {
        NSLog(@"%@",JSON);
        success(JSON);
    } failure:^(NSError *error) {
        
    }];
}


-(NSString *)getTypeStringWithType:(MSPostType)type
{
    switch (type) {
        case MSPostTypeEveryDay:
            return @"everyday";
        case MSPostTypeLast:
            return @"last";
        case MSPostTypeSalary:
            return @"salary";
        default:
            return nil;
    }
}

@end
