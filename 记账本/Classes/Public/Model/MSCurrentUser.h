//
//  MSCurrentUser.h
//  记账本
//
//  Created by FanYuepan on 16/2/18.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSCurrentUser : NSObject<NSCoding>

@property(nonatomic,copy,readonly) NSString *userPhoto;
@property(nonatomic,copy,readonly) NSString *userName;
@property(nonatomic,assign) NSInteger userId;
@property(nonatomic,readonly) NSString *userToken;
@property(nonatomic,readonly) BOOL isLoginIMServer;

-(void)setLogin:(BOOL)islogin;

-(instancetype) initWithUserId:(NSInteger)userid;
@end
