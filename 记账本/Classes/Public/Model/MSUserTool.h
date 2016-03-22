//
//  MSUserTool.h
//  记账本
//
//  Created by FanYuepan on 16/2/18.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSingleton.h"
#import "MSCurrentUser.h"

@interface MSUserTool : NSObject
single_interface(MSUserTool)

@property(nonatomic,strong,readonly) MSCurrentUser *currentUser;

- (void)saveCurrentUser:(MSCurrentUser *)currentUser;

-(void)setUserDefaultsValue:(NSInteger)value forKey:(NSString *)key;

-(NSInteger)getUserDefaultsValueForKey:(NSString *)key;


-(BOOL)shouldRefreshSummary;

-(void)resetSummary;

-(NSArray *)getAllUsers;

-(void)loginIMServer;
-(void)resetLoginIMServer;
-(BOOL)isLoginIMServer;
@end
