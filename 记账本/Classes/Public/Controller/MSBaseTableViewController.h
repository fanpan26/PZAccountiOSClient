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

@end
