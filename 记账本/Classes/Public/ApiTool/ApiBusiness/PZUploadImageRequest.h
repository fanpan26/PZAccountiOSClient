//
//  PZUploadImageRequest.h
//  记账本
//
//  Created by FanYuepan on 16/3/30.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAccountRequest.h"

@interface PZUploadImageRequest : PZAccountRequest

-(instancetype)initWithBase64:(NSString *)base64;

@end
