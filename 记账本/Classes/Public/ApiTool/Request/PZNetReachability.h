//
//  PZNetReachability.h
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PZNetReachability : NSObject

+(instancetype)sharedInstance;

-(BOOL)netReachable;

-(void)beginNetReach;

@end
