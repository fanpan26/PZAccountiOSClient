//
//  PZSettingController.m
//  记账本
//
//  Created by FanYuepan on 16/3/30.
//  Copyright © 2016年 ；. All rights reserved.
//

#import "PZSettingController.h"
#import "PZNetWorkAgent.h"
#import "PZUploadImageRequest.h"
#import "UIImage+MS.h"

@interface PZSettingController()<PZBaseRequestDelegate>

@end
//kenan.jpeg
@implementation PZSettingController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)buildUI
{
    [super buildUI];
//    self.title = @"设置";
//    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
//    UIImage *img = [UIImage imageNamed:@"kenan.jpeg"];
//    NSString *base64 = [img base64String];
//    NSLog(@"%@",base64);
//    PZUploadImageRequest *request = [[PZUploadImageRequest alloc] initWithBase64:base64];
//    request.delegate = self;
//    [agent startWithBaseRequest:request];
    
}

-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
    NSLog(@"%@",request.responseObject);
}

@end
