//
//  MSHttpManager.m
//  MSProduct
//
//  Created by FanYuepan on 16/2/5.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import "MSHttpManager.h"
#import "AFNetworking.h"
#import "MSTool.h"
#import "MSChatConfig.h"
@implementation MSHttpManager

single_implementation(MSHttpManager)

-(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestSuccessCallBack)success failure:(MSRequestFailureCallBack)failure
{
    [self requestWithType:@"GET" url:url params:params json:YES success:^(id JSON) {
        if (success) {
            success(JSON);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestSuccessCallBack)success failure:(MSRequestFailureCallBack)failure
{
    [self requestWithType:@"POST" url:url params:params json:YES success:^(id JSON) {
        if (success) {
            success(JSON);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)getStringWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestSuccessCallBack)success failure:(MSRequestFailureCallBack)failure
{
    [self requestWithType:@"GET" url:url params:params json:NO success:^(id JSON) {
        if (success) {
            success(JSON);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)requestWithType:(NSString *)type url:(NSString *)url params:(NSDictionary *)params json:(BOOL)json success:(MSRequestSuccessCallBack)success failure:(MSRequestFailureCallBack)failure
{
    if (params == nil) {
        params = @{@"r":@"macrosage"};
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    NSLog(@"==============%@",dict);
    //[dict setValue:@"other" forKey:@"other"];//添加其他公共参数
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (json == NO) {
        //兼容返回非json格式的字符串
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    if([type isEqualToString:@"GET"]){
        [manager GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"AFN return JSON:%@,%@",[responseObject class],responseObject);
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //NSLog(@"%@",error);
            if (failure) {
                failure(error);
            }
        }];
    }else if([type isEqualToString:@"POST"]){
        [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"AFN return JSON:%@",responseObject);
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else{
        NSLog(@"unsupported http request type");
    }
}


-(void)postWithURL:(NSString *)url headers:(NSDictionary *)headers params:(NSDictionary *)params success:(MSRequestSuccessCallBack)success failure:(MSRequestFailureCallBack)failure
{
     url = @"https://api.cn.ronghub.com/user/getToken.json";
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    
    NSDictionary *dict = @{@"userId":@"1",@"name":@"范月盘",@"portraiUri":@"http://qlogo3.store.qq.com/qzone/645857874/645857874/100?1440900705"};
    
    NSString *appkey = kMSChatAppKey;
    NSString *nonce = [[MSTool sharedMSTool] getRandomNonce];
    NSString *timestamp = [[MSTool sharedMSTool] getTimestamp];
    NSString *signature = [[MSTool  sharedMSTool]getSignatureWithAppKey:kMSChatAppSecret nonce:nonce timestamp:timestamp];
    
    NSLog(@"%@",appkey);
    NSLog(@"%@",nonce);
    NSLog(@"%@",timestamp);
    NSLog(@"%@",signature);
    
    /*
     qf3d5gbj31s5h
     Nonce: 1982419745
     Timestamp: 1456324282
     NSString *signature = [[MSTool  sharedMSTool]getSignatureWithAppKey:appkey nonce:nonce timestamp:timestamp];
     */
    
     [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
      [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
      [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
      [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
/*
 create download task
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 
 NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
 NSURLRequest *request = [NSURLRequest requestWithURL:URL];
 
 NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
 NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
 return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
 } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
 NSLog(@"File downloaded to: %@", filePath);
 }];
 [downloadTask resume];
 
 
 create upload task
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 
 NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
 NSURLRequest *request = [NSURLRequest requestWithURL:URL];
 
 NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
 NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
 if (error) {
 NSLog(@"Error: %@", error);
 } else {
 NSLog(@"Success: %@ %@", response, responseObject);
 }
 }];
 [uploadTask resume];
 */
@end
