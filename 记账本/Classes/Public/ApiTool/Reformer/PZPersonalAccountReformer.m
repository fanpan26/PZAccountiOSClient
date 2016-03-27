//
//  PZPersonalAccountReformer.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZPersonalAccountReformer.h"
#import "PZPersonalAccountDetailModel.h"

@implementation PZPersonalAccountReformer
-(PZRequestResult *)reformData:(id)originData fromRequest:(PZBaseRequest *)request
{
    id data;
    if ([self isSuccessData:originData]) {
        NSDictionary *dict = originData[@"data"];
        PZPersonalAccountDetailModel *model = [[PZPersonalAccountDetailModel alloc] initWithDictionary:dict];
        data = model;
    }else{
        data = originData[@"data"];
    }
    PZRequestResult *result = [[PZRequestResult alloc] initWithCode:[self codeWithData:originData] data:data];
    return result;
}
@end
