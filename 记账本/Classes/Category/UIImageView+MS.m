//
//  UIImageView+Extension.m
//  SinaWeiBoV20151217
//
//  Created by FanYuepan on 16/1/12.
//  Copyright © 2016年 FanYuepan. All rights reserved.
//

#import "UIImageView+MS.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (MS)

-(void)setImageWithUrl:(NSString *)imageUrl placeHolder:(NSString *)holder
{
    if(self){
        NSURL *url = [NSURL URLWithString:imageUrl];
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:holder] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    }else{
        NSLog(@"自己为nil，不能执行分类的方法");
    }
}


@end
