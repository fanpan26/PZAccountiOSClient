//
//  MSTool.m
//  记账本
//
//  Created by FanYuepan on 16/2/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSTool.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation MSTool
single_implementation(MSTool)

-(NSString *)getRandomNonce
{
    NSInteger randomValue = [self getRandomNumber:100000 to:999999];
    return  [NSString stringWithFormat:@"%ld",randomValue];
}

-(NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval times =  [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",times];
}

-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

-(NSString *)sha1WithKey:(NSString *)key
{
        const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
        NSData *data = [NSData dataWithBytes:cstr length:key.length];
        
        uint8_t digest[CC_SHA1_DIGEST_LENGTH];
        
        CC_SHA1(data.bytes, data.length, digest);
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
        
        for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
            [output appendFormat:@"%02x", digest[i]];
        }
        
        return output;
}

-(NSString *)getSignatureWithAppKey:(NSString *)appKey nonce:(NSString *)nonce timestamp:(NSString *)timestamp
{
    NSString *sha1String = [NSString stringWithFormat:@"%@%@%@",appKey,nonce,timestamp];
    return [self sha1WithKey:sha1String];
}
@end
