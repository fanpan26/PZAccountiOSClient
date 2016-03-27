//
//  MSAccount.m
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSAccount.h"

@implementation MSAccount

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.user = [[MSCurrentUser alloc] initWithUserId:[dict[@"userid"] longValue]];
        self.addtime = dict[@"addtime"];
        self.other = dict[@"costother"];
        self.date = dict[@"costdate"];
        self.category = [dict[@"costcategory"] longValue];
        self.money = [NSString stringWithFormat:@"%@",dict[@"costmoney"]];
    }
    return  self;
}

+(NSArray *)accountsWithArray:(NSArray *)array
{
    NSMutableArray *accounts = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary  *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        MSAccount *account = [[MSAccount alloc] initWithDictionary:dict];
        [accounts addObject:account];
    }];
    return [accounts copy];//不知道copy有什么用处，或者需不需要用
}

-(NSString *)moneyDetail
{
    return [NSString stringWithFormat:@"消费了%@ ￥%@ 元",self.other,self.money];
}

-(NSString *)addtime
{
    NSString *time = [_addtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSArray *timeArrayByDot = [time componentsSeparatedByString:@"."];
    time = timeArrayByDot[0];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:time];
    
   
    fmt.dateFormat = @"MM-dd HH:mm";
    return [fmt stringFromDate:date];
//    // 2.获得当前时间
//    NSDate *now = [NSDate date];
//    
//    // 3.获得当前时间和微博发送时间的间隔（差多少秒）
//    NSTimeInterval delta = [now timeIntervalSinceDate:date];
//    
//    // 4.根据时间间隔算出合理的字符串
//    if (delta < 60) { // 1分钟内
//        return @"刚刚";
//    } else if (delta < 60 * 60) { // 1小时内
//        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
//    } else if (delta < 60 * 60 * 24) { // 1天内
//        return [NSString stringWithFormat:@"%.f小时前", delta/60/60];
//    } else {
//        fmt.dateFormat = @"yyyy-MM-dd";
//        return [fmt stringFromDate:date];
//    }
}

@end
