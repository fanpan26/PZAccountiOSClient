//
//  PZUser.h
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PZUser : NSObject

@property(nonatomic,assign) NSInteger user_id;
@property(nonatomic,strong) NSString *user_name;
@property(nonatomic,strong) NSString *user_photo;

@end

