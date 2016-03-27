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

    return  [self compareDate:date] ;
}


/*
    日期处理方法以后再整理
 */
 -(NSString *)weekdayStringFromDate:(NSDate *)inputDate {
     NSArray *weekdays = @[ @"",@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
     NSUInteger index = [self dateComponentsFromDate:inputDate].weekday ;
     return [weekdays objectAtIndex:index];
     
}

-(NSDateComponents *)dateComponentsFromDate:(NSDate *)date
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return theComponents;
   
}

-(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    static dispatch_once_t onceToken;
    static NSDateFormatter *_formatter;
    dispatch_once(&onceToken, ^{
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyy-MM-dd";
    });
    NSString * todayString = [_formatter stringFromDate:today];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    NSString * yesterdayString = [_formatter stringFromDate:yesterday];
    
    NSString * dateString = [_formatter stringFromDate:date];
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }
    else
    {
        NSTimeInterval detla = [today timeIntervalSinceDate:date];
        if (detla < 4 * 24 * 60 * 60) {
             return [self weekdayStringFromDate:date];
        }
        return dateString;
       
    }
}


@end
