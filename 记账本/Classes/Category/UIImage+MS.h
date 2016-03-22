//
//  UIImage+Extension.h
//  SinaWeiBoV20151217
//
//  Created by FanYuepan on 15/12/19.
//  Copyright © 2015年 FanYuepan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MS)

+ (UIImage *) fullscreenImage:(NSString *)imageName;

+ (UIImage *) resizeImage:(NSString *) imageName;

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;


-(UIImage *) ms_imageWithRoundedCornerAndSize:(CGSize)sizeToFit
                              andCornerRadius:(CGFloat)radius;
@end
