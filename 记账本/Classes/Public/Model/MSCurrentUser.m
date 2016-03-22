//
//  MSCurrentUser.m
//  记账本
//
//  Created by FanYuepan on 16/2/18.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSCurrentUser.h"

@interface MSCurrentUser()
{
    BOOL __islogin;
}

@end

@implementation MSCurrentUser

-(instancetype)initWithUserId:(NSInteger)userid
{
    if (self = [super init]) {
        self.userId = userid;
    }
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    NSString *uid = [NSString stringWithFormat:@"%ld",_userId];
    [encoder encodeObject:uid forKey:@"userid"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        NSString *val = [decoder decodeObjectForKey:@"userid"];
        self.userId = [val integerValue];
    }
    return self;
}

-(void)setUserId:(NSInteger)userId
{
    NSArray *userNames = [NSArray arrayWithObjects:@"",@"月盘",@"月祥",@"月成", nil];
    NSArray *userPhotos = [NSArray arrayWithObjects:@"",@"http://qlogo3.store.qq.com/qzone/645857874/645857874/100?1440900705",@"http://qlogo4.store.qq.com/qzone/1027889043/1027889043/100?1375434080",@"http://qlogo2.store.qq.com/qzone/694220741/694220741/100?1448534077", nil];
//0tfJTvMhf+mP+XhFQFTGkoobtSl1qdAdVvGgirB4KDleS3zMmzJuCiaE5nXd2a/Hr5RH3Dk5rEkIa87kRnrXxA==
    ///WDTk8lMUVyufQMLrmxeFxT9OeakPdJZLWYnhKQzLB2XsHhZteMPc0WJzlsudJkkVQ2DySd5Jh/LE8/xLgTc4A==
    NSArray *userTokens = [NSArray arrayWithObjects:@"",@"d7NaHIbzS+RQhli1KPbWsYobtSl1qdAdVvGgirB4KDleS3zMmzJuCodXdQ2dcemEQ665BR0oEKsIa87kRnrXxA==",@"/+UwfjLH9R0TWvd5c1tLRxT9OeakPdJZLWYnhKQzLB2XsHhZteMPc3cUcpLTRSKW8UtcjZo6JvHLE8/xLgTc4A==",@"chA4WaEA2D+VubSaifNll2EveTY5ac9b7yrlbcowWFcICEdGXIG+8s9njUa0fBdjvVkpEoGqGQ8/mWmJlXFIHg==", nil];
    _userId = userId;
    _userName = userNames[userId];
    _userPhoto = userPhotos[userId];
    _userToken = userTokens[userId];
}

-(void)setLogin:(BOOL)islogin
{
    __islogin = islogin;
}

-(BOOL)isLoginIMServer
{
    return  __islogin;
}

@end
