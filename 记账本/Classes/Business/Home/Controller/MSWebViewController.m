//
//  MSWebViewController.m
//  记账本
//
//  Created by FanYuepan on 16/2/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSWebViewController.h"

@interface MSWebViewController() <UIWebViewDelegate>

@property(nonatomic,weak) UIWebView *webView;

@end

@implementation MSWebViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI
{
    UIWebView *_w = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_w];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://univ.gurucv.com/gurucv/index"]];
    [_w loadRequest:request];
    self.webView = _w;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

@end
