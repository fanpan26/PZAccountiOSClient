//
//  MSSummaryDetailView.m
//  记账本
//
//  Created by FanYuepan on 16/2/19.
//  Copyright © 2016年 fyp. All rights reserved.
// 三个人每个人出了多少

#import "MSSummaryDetailView.h"
#import "MSPhotoView.h"
#import "MSCommon.h"
#import "MSCurrentUser.h"
#import "NSString+MS.h"
#import "UIImage+MS.h"

@interface MSSummaryDetailView()

@property(nonatomic,assign) NSInteger userid;
@property(nonatomic,assign) double all;
@property(nonatomic,assign) double value;
@property(nonatomic,readonly) CGFloat percentWidth;
@property(nonatomic,readonly) NSString *percentText;

@end


@implementation MSSummaryDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return  self;
}

-(instancetype)initWithFrame:(CGRect)frame userid:(NSInteger)userid all:(double)all value:(double)value
{
    self.userid = userid;
    self.all = all;
    self.value = value;
    return [self initWithFrame:frame];
}

-(CGFloat)percentWidth
{
    return kMSScreenWidth * 0.5 * (self.value / self.all);
}

-(void)buildUI
{
    //self.image = [UIImage resizeImage:@"common_card_background.png"];
    
    NSString *url = [[MSCurrentUser alloc] initWithUserId:self.userid].userPhoto;
    //添加头像
    MSPhotoView *photoView = [[MSPhotoView alloc] initWithPhoto:url size:MSPhotoViewSizeSmall];
    CGSize photoSize = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeSmall];
    photoView.photoType = MSPhotoViewTypeRound;
    photoView.frame = CGRectMake(10, 10, photoSize.width, photoSize.height);
    [self addSubview:photoView];
    //添加长度
    CGFloat viewX = photoSize.width + 2 * kMSTableViewContentPaddingHorizontal;
    UIView *percent = [[UIView alloc] initWithFrame:CGRectMake(viewX, 25, self.percentWidth, 10)];
    percent.backgroundColor = [UIColor orangeColor];
    [self addSubview:percent];
    //添加括号文字
    UILabel *detail = [[UILabel alloc] init];
    CGFloat detailX = CGRectGetMaxX(percent.frame) + kMSTableViewContentPaddingHorizontal;
    detail.text =  [NSString stringWithFormat:@"￥%.2f(%.2f%%)",self.value,(self.value * 100 / self.all)];
    detail.font = kMSFont(15);
    CGSize detailSize = [detail.text sizeSingleLineWithFont:kMSFont(15)];
    detail.frame = CGRectMake(detailX, 15 + percent.frame.size.height * 0.25, detailSize.width, detailSize.height);

    [self addSubview:detail];
}

-(void)setAll:(double)all
{
    _all = all;
    if (all == 0) {
        _all = 0.01;
    }
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = kMSScreenWidth;
    frame.size.height = 60;
    [super setFrame:frame];
}
@end
