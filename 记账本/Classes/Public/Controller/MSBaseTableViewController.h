//
//  MSBaseTableViewController.h
//  记账本
//
//  Created by FanYuepan on 16/2/18.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface MSBaseTableViewController : UITableViewController

@property(nonatomic,assign,getter=isNeedHeaderRefresh) BOOL needHeaderRefresh;
@property(nonatomic,assign,getter=isNeedFooterRefresh) BOOL needFooterRefresh;

-(void)startHeaderRefreshing;
-(void)startFooterRefreshing;

-(void)endHeaderRefreshing;
-(void)endFooterRefreshing;

-(void)reloadData;

-(void)didHeaderStartedRefresh;
-(void)didFooterStartedRefresh;

-(void)showLoading;
-(void)hideLoading;
-(void)hideLoading:(BOOL)error;
-(void)buildUI;

-(void)showTitleLoading;
-(void)hideTitleLoading;

-(void)hideTitleLoadingWithTitle:(NSString *)title;
@end
