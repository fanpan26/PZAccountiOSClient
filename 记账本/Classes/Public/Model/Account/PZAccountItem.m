//
//  PZAccountItem.m
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAccountItem.h"

@implementation PZAccountItem

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.userid = [dict[@"operate_user"] integerValue];
        self.username = dict[@"username"];
        self.userphoto = dict[@"userphoto"];
        self.addtime = dict[@"addtime"];
        self.category = [dict[@"category"] integerValue];
        self.unionId = [dict[@"id"] integerValue];
        self.money = [dict[@"money"] floatValue];
        self.categoryname = dict[@"name"];
        self.other = dict[@"other"];
        self.t = [dict[@"t"] integerValue];
        self.tname = dict[@"tname"];
    }
    return self;
}

-(NSString *)detail
{
    return [NSString stringWithFormat:@"[%@]%@￥%.2f 元", self.tname,self.other,self.money];
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
    //return [fmt stringFromDate:date];
    //    // 2.获得当前时间
        NSDate *now = [NSDate date];
    
        // 3.获得当前时间和微博发送时间的间隔（差多少秒）
        NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
        // 4.根据时间间隔算出合理的字符串
//        if (delta < 60) { // 1分钟内
//            return @"刚刚";
//        } else if (delta < 60 * 60) { // 1小时内
//            return [NSString stringWithFormat:@"%.f分钟前", delta/60];
//        } else if (delta < 60 * 60 * 24) { // 1天内
//            return [NSString stringWithFormat:@"%.f小时前", delta/60/60];
//        } else {
//            fmt.dateFormat = @"yyyy-MM-dd";
//            return [fmt stringFromDate:date];
//        }
    //一天内
    if (delta < 60 * 60 * 24) {
        return  @"今天";
    }
    //一周内
    NSUInteger todayIndex = [self weekdayOfIndexFromDate:now];
    NSUInteger dayCount = todayIndex - 1;

    if (delta < 60 * 60 * 24 * dayCount) {
        return [self weekdayStringFromDate:date];
    }
    
   // fmt.dateFormat = @"yyyy-MM-dd";
    return [fmt stringFromDate:date];
}


/*
    日期处理方法以后再整理
 */
 -(NSString *)weekdayStringFromDate:(NSDate *)inputDate {
     NSArray *weekdays = @[ @"",@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
     NSUInteger index = [self weekdayOfIndexFromDate:inputDate];
     return [weekdays objectAtIndex:index];
     
}

-(NSInteger)weekdayOfIndexFromDate:(NSDate *)date
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return theComponents.weekday;
   
}


@end
