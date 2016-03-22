//
//  PZTransferModel.m
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZTransferModel.h"
#import "PZUser.h"

@implementation PZTransferModel

-(BOOL)isSelf
{
    return self.to_user.user_id == 1;
}


+(instancetype)transfer
{
    PZTransferModel *model = [[PZTransferModel alloc] init];
    model.from_user = [[PZUser alloc] init];
    model.from_user.user_id = 1;
    model.from_user.user_name = @"范月盘";
    model.from_user.user_photo = @"http://qlogo3.store.qq.com/qzone/645857874/645857874/100?1440900705";
    
    model.to_user = [[PZUser alloc] init];
    model.to_user.user_id = 2;
    model.to_user.user_name = @"范月祥";
    model.to_user.user_photo = @"http://qlogo2.store.qq.com/qzone/694220741/694220741/100?1448534077";
    
    model.money = 100.0f;
    model.addtime = @"";
    return model;
    
}

+(instancetype)transfer1
{
    PZTransferModel *model = [[PZTransferModel alloc] init];
    model.from_user = [[PZUser alloc] init];
    model.from_user.user_id = 2;
    model.from_user.user_name = @"范月祥";
    model.from_user.user_photo = @"http://qlogo2.store.qq.com/qzone/694220741/694220741/100?1448534077";
    
    model.to_user = [[PZUser alloc] init];
    model.to_user.user_id = 1;
    model.to_user.user_name = @"范月盘";
    model.to_user.user_photo = @"http://qlogo3.store.qq.com/qzone/645857874/645857874/100?1440900705";
    
    model.money = 1500.0f;
    model.addtime = @"";
    return model;
    
}

@end
