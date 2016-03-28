//
//  MSBaseViewController.h
//  记账本
//
//  Created by FanYuepan on 16/3/14.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSBaseViewController : UIViewController

-(void)buildUI;

-(void)setLeftButtonWithTitle:(NSString *)title image:(NSString *)image;
-(void)setRightButtonWithTitle:(NSString *)title image:(NSString *)image;


-(void)showTitleLoading;
-(void)showTitleLoadingWithTitle:(NSString *)title;

-(void)hideTitleLoading;

-(void)hideTitleLoadingWithTitle:(NSString *)title;
@end
