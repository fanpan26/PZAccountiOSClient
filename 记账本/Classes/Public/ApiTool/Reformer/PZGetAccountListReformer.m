//
//  PZGetAccountListReformer.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZGetAccountListReformer.h"
#import "PZGetAccountListRequest.h"
#import "PZAccountItem.h"

@implementation PZGetAccountListReformer


- (PZRequestResult *)reformData:(id)originData fromRequest:(PZBaseRequest *)request
{
    id data;
    if (originData) {
        NSMutableArray *array = [NSMutableArray array];
        if ([self isSuccessData:originData]) {
            NSArray *dictArray =  originData[@"data"];
            [dictArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                PZAccountItem *item = [[PZAccountItem alloc] initWithDictionary:obj];
                [array addObject:item];
            }];
            data = array;
        }else{
             data = originData[@"data"];
        }
        PZRequestResult *result = [[PZRequestResult alloc] initWithCode:[self codeWithData:originData] data:data];
        return  result;
    }
    return  nil;
}

@end
