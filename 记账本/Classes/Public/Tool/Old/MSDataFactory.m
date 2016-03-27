//
//  MSDataFactory.m
//  MSProduct
//
//  Created by FanYuepan on 16/2/5.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import "MSDataFactory.h"

//{"result":10000,"msg":"成功","data":""}
static NSString *const MSRequestSuccessResultCodeForResult = @"result";
static NSString *const MSRequestSuccessResultCodeForMsg = @"msg";
static NSString *const MSRequestSuccessResultCodeForData = @"data";

@implementation MSDataFactory

single_implementation(MSDataFactory)

-(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure
{
    NSString *platUrl = kMSSysURL;//平台url  gurucv、ruc等
    NSString *fullPath = [NSString stringWithFormat:@"%@%@%@",kMSBaseApiDomain,platUrl,url];
    
    MSHttpManager *manager = [MSHttpManager sharedMSHttpManager];
    [manager getWithURL:fullPath params:params success:^(id JSON) {
        
        [self handleJSON:JSON success:success failure:failure];
        
    } failure:^(NSError *error) {
        
        NSLog(@"请求失败:%@",error);
        
    }];
}

-(void)getStringWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure
{
    NSString *platUrl = kMSSysURL;//平台url  gurucv、ruc等
    NSString *fullPath = [NSString stringWithFormat:@"%@%@%@",kMSBaseApiDomain,platUrl,url];
    
    MSHttpManager *manager = [MSHttpManager sharedMSHttpManager];
    [manager getStringWithURL:fullPath params:params success:^(id JSON) {
        
        [self handleString:JSON success:success failure:failure];
        
    } failure:^(NSError *error) {
        
        NSLog(@"请求失败:%@",error);
        
    }];
}

-(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure
{
    NSString *platUrl = kMSSysURL;//平台url  gurucv、ruc等
    NSString *fullPath = [NSString stringWithFormat:@"%@%@%@",kMSBaseApiDomain,platUrl,url];
    
    MSHttpManager *manager = [MSHttpManager sharedMSHttpManager];
    
    [manager postWithURL:fullPath params:params success:^(id JSON) {
        
        [self handleJSON:JSON success:success failure:failure];
        
    } failure:^(NSError *error) {
        
         NSLog(@"请求失败:%@",error);
        
    }];
}

/*private*/
-(void)handleJSON:(id) JSON success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure
{
    NSInteger result = [JSON[MSRequestSuccessResultCodeForResult] longLongValue];
    if (result == kMSApiCodeSuccess) {
        if (success) {
            NSDictionary *data = JSON[MSRequestSuccessResultCodeForData];
            success(data);
        }
    }else{
        if (failure) {
            NSString *msg = JSON[MSRequestSuccessResultCodeForMsg];
            failure(msg);
        }
    }

}

-(void)handleString:(id)String success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure
{
    
    NSString *jsonString = [[NSString alloc]initWithData:String encoding:NSUTF8StringEncoding];
    if (jsonString == nil) {
        if (failure) {
            failure(@"error");
        }
        return;
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""].lowercaseString;
    //去掉两遍的引号
    NSRange range;
    range.location = 1;
    range.length = jsonString.length - 2;
    jsonString  = [jsonString substringWithRange:range];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                   error:&err];
    if(err) {
        if (failure) {
            failure(@"error");
        }
        return;
    }
    if (success) {
        success(result);
    }
}
@end
