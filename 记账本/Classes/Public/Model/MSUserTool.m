//
//  MSUserTool.m
//  记账本
//
//  Created by FanYuepan on 16/2/18.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSUserTool.h"

#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@implementation MSUserTool// 文件路径

single_implementation(MSUserTool)

- (id)init
{
    if (self = [super init]) {
        _currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

- (void)saveCurrentUser:(MSCurrentUser *)currentUser
{
    _currentUser = currentUser;
    [NSKeyedArchiver archiveRootObject:currentUser toFile:kFile];
}

-(void)setUserDefaultsValue:(NSInteger)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:@(value) forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)getUserDefaultsValueForKey:(NSString *)key
{
    id value  = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return [value integerValue];
}

-(BOOL)shouldRefreshSummary
{
    ///HOMELIST SUMMARYLIST SUMMARYSALARY
    NSInteger v1 = [self getUserDefaultsValueForKey:@"HOMELIST"];
    NSInteger v2 = [self getUserDefaultsValueForKey:@"SUMMARYLIST"];
    NSInteger v3 = [self getUserDefaultsValueForKey:@"SUMMARYSALARY"];
    return (v1 == 1) || (v2 == 1) || (v3 == 1);
}

-(void)resetSummary
{
    [self setUserDefaultsValue:0 forKey:@"HOMELIST"];
    [self setUserDefaultsValue:0 forKey:@"SUMMARYLIST"];
    [self setUserDefaultsValue:0 forKey:@"SUMMARYSALARY"];
}

-(NSArray *)getAllUsers
{
    NSMutableArray *users = [NSMutableArray array];
    [users addObject:[[MSCurrentUser alloc]  initWithUserId:1]];
    [users addObject:[[MSCurrentUser alloc]  initWithUserId:2]];
    [users addObject:[[MSCurrentUser alloc]  initWithUserId:3]];
    return [users copy];
}

-(void)loginIMServer
{
    [self setUserDefaultsValue:1 forKey:@"MS_LOGINI_MS_ERVER"];
}

-(void)resetLoginIMServer
{
    [self setUserDefaultsValue:0 forKey:@"MS_LOGINI_MS_ERVER"];
}

-(BOOL)isLoginIMServer
{
    NSInteger islogin = [self getUserDefaultsValueForKey:@"MS_LOGINI_MS_ERVER"];
    return islogin == 1;
}



@end
