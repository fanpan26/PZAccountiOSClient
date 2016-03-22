//
//  MSFirstController.m
//  记账本
//
//  Created by FanYuepan on 16/2/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSFirstController.h"
#import "MSPhotoView.h"
#import "Masonry.h"
#import "MSCurrentUser.h"
#import "MSUserTool.h"
#import "MSCommon.h"
#import "MSTabBarController.h"
#import "UIImage+RoundedCorner.h"

@interface MSFirstController()
{
    MSPhotoView *_photoView1;
    MSPhotoView *_photoView2;
    MSPhotoView *_photoView3;

}

@end

@implementation MSFirstController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}
-(MSPhotoView *)createPhoto:(NSInteger)tag
{
    MSPhotoView *photoViewUser1 = [[MSPhotoView alloc] initWithPhoto:nil size:MSPhotoViewSizeBig];
    
    photoViewUser1.photoType = MSPhotoViewTypeRound;
    photoViewUser1.tag = tag;
    [photoViewUser1 setImage:[[MSCurrentUser alloc] initWithUserId:tag].userPhoto];
    
    [self.view addSubview:photoViewUser1];
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tap:)];
    [photoViewUser1 addGestureRecognizer:tapRecognize];
    return  photoViewUser1;
}

-(void)buildUI
{
    self.title = @"选择身份";
    self.view.backgroundColor = [UIColor clearColor];
 
    MSPhotoView *photoViewUser1 = [self createPhoto:1];
    MSPhotoView *photoViewUser2 = [self createPhoto:2];
    MSPhotoView *photoViewUser3 = [self createPhoto:3];
    
    _photoView1 = photoViewUser1;
    _photoView2 = photoViewUser2;
    _photoView3 = photoViewUser3;
    
    NSLog(@"%@",NSStringFromCGRect(photoViewUser1.frame));
    
    CGSize photoSize = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeBig];
    [photoViewUser1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-100);
        make.top.mas_equalTo(self.view).with.offset(200);
        make.size.mas_equalTo(photoSize);//必须设置size，否则不会触发点击事件
    }];
    
    [photoViewUser2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(200);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(photoSize);
    }];
    
    [photoViewUser3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(200);
        make.centerX.equalTo(self.view).offset(100);
        make.size.mas_equalTo(photoSize);
    }];
    
//    UILabel *btn = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 100, 44)];
//    btn.text = @"12122112121";
//    btn.textColor = [UIColor orangeColor];
//    UIImageView *labelRoundedCornerView = [[UIImageView alloc] initWithFrame:btn.frame];
//    labelRoundedCornerView.image = [UIImage jm_imageWithRoundedCornersAndSize:CGSizeMake(100, 44) andCornerRadius:10 andColor:[UIColor lightGrayColor]];
//    [self.view addSubview:labelRoundedCornerView];
//    [self.view addSubview:btn];
}


-(void)tap:(UITapGestureRecognizer *)recognizer
{
    MSPhotoView *photoView = (MSPhotoView *)recognizer.view;
    NSInteger userid =  photoView.tag;
    [[MSUserTool sharedMSUserTool] saveCurrentUser:[[MSCurrentUser alloc] initWithUserId:userid]];

    [self startAnitmations:photoView];
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removePhotoView:photoView];
    }];
}

-(void)startAnitmations:(MSPhotoView *)photoView
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[MSPhotoView class]]) {
            if (view == photoView) {
                NSLog(@"点击的是这个，吧他移动到中间去");
                [view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.view);
                }];
            }else{
                [view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(-100);
                }];
            }
        }
    }}
-(void)removePhotoView:(MSPhotoView *)photoView
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[MSPhotoView class]]) {
            if (view == photoView) {
                NSLog(@"点击的是这个，吧他移动到中间去");
            }else{
                [view removeFromSuperview];
            }
        }
    }
    MSTabBarController *tabBarController = [[MSTabBarController alloc] init];
    self.view.window.rootViewController = tabBarController;
}

@end
