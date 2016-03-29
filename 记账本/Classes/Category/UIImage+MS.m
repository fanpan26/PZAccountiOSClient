//
//  UIImage+Extension.m
//  SinaWeiBoV20151217
//
//  Created by FanYuepan on 15/12/19.
//  Copyright © 2015年 FanYuepan. All rights reserved.
//

#import "UIImage+MS.h"
#import "UIImageView+WebCache.h"

@implementation UIImage (MS)

//全屏幕
+(UIImage *)fullscreenImage:(NSString *)imageName
{
    return [self imageNamed:imageName];
}

///拉伸图片
+ (UIImage *) resizeImage:(NSString *)imageName
{
    return [self resizedImage:imageName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}


- (BOOL) imageHasAlpha;
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (NSString *) base64String;
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha]) {
        imageData = UIImagePNGRepresentation(self);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(self, 1.0f);
        mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
    
}

//
//-(UIImage *)ms_imageWithRoundedCornerAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius
//{
//    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
//    CGContextAddPath(context,
//                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
//    CGContextClip(UIGraphicsGetCurrentContext());
//    
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    [self drawInRect:rect];
//    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return output;
//}
@end
