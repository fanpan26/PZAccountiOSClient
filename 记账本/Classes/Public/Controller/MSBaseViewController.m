//
//  MSBaseViewController.m
//  记账本
//
//  Created by FanYuepan on 16/3/14.
//  Copyright © 2016年 fyp. All rights reserved.
//


#import "MSBaseViewController.h"

#import "PZLoadingNavigationTitle.h"
@interface MSBaseViewController()

@property(nonatomic,strong) PZLoadingNavigationTitle *loadingTitleView;

@end

@implementation MSBaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}
-(void)buildUI {
    self.edgesForExtendedLayout = NO;
}

-(void)setLeftButtonWithTitle:(NSString *)title image:(NSString *)image
{
    UIButton *btn = [self buttonWithImage:image];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)setRightButtonWithTitle:(NSString *)title image:(NSString *)image
{
    UIButton *btn = [self buttonWithImage:image];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(UIButton *)buttonWithImage:(NSString *)image
{
    NSString *selectedImage = [NSString stringWithFormat:@"-selected"];
    UIImage *bimage = [UIImage imageNamed:image];
    UIImage *bselectedImage = [UIImage imageNamed:selectedImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:bimage forState:UIControlStateNormal];
    [button setImage:bselectedImage forState:UIControlStateHighlighted];
    return button;
}


-(void)showTitleLoading
{
    [self showTitleLoadingWithTitle:nil];
}

-(void)showTitleLoadingWithTitle:(NSString *)title
{
    if (!self.navigationItem.titleView) {
        if (title) {
            self.loadingTitleView.title = title;
        }
        self.navigationItem.titleView = self.loadingTitleView;
    }
    [self.loadingTitleView startAnimation];
}

-(void)hideTitleLoading
{
    [self hideTitleLoadingWithTitle:nil];
}

-(void)hideTitleLoadingWithTitle:(NSString *)title
{
    [self.loadingTitleView stopAnimation];
    if (title) {
        self.title = title;
    }
    if (self.navigationItem.titleView) {
        [self.navigationItem.titleView removeFromSuperview];
        self.navigationItem.titleView = nil;
    }
}

-(PZLoadingNavigationTitle *)loadingTitleView
{
    if (_loadingTitleView == nil) {
        _loadingTitleView =[[PZLoadingNavigationTitle alloc] initWithTitle:@"加载中..."];
    }
    return _loadingTitleView;
}

@end
