//
//  MSPhotoView.h
//  MSProduct
//
//  Created by FanYuepan on 16/2/7.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MSPhotoViewSize){
    MSPhotoViewSizeBig = 1,
    
    MSPhotoViewSizeDefault = 2,
    
    MSPhotoViewSizeSmall = 3,
    
    MSPhotoViewSizeNone = 0
} ;

typedef  NS_ENUM(NSInteger,MSPhotoViewType){
    MSPhotoViewTypeDefault = 0,
    MSPhotoViewTypeRound = 1,//圆形
    MSPhotoViewTypeSquare = 2,//方形
    MSPhotoViewTypeRoundWhite = 3,//圆形带白边
    MSPhotoViewTypeSquareWhite = 4,//方形带白边
    MSPhotoViewTypeSquareRectRound = 5,//方形圆角
    MSPhotoViewTypeSquareRectRoundWhite = 6,//方形圆角带白边
};

@interface MSPhotoView : UIView

@property(nonatomic,assign) MSPhotoViewType photoType;


@property(nonatomic,copy) NSString *image;

-(instancetype)initWithPhoto:(NSString *)image;

-(instancetype) initWithPhoto:(NSString *)image size:(MSPhotoViewSize)size;

+(CGSize)photoSizeWithSize:(MSPhotoViewSize)size;

@end
