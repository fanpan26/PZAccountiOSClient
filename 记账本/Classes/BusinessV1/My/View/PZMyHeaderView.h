//
//  PZMyHeaderView.h
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PZMyHeaderView;

@protocol PZMyHeaderViewDelegate <NSObject>

@optional

-(void)didTapHeaderView:(PZMyHeaderView *)headerView;

@end

@interface PZMyHeaderView : UIView

-(instancetype)initWithPhoto:(NSString *)photo name:(NSString *)name;

@property(nonatomic,copy) NSString *photo;
@property(nonatomic,copy) NSString *name;

@property(nonatomic,weak) id<PZMyHeaderViewDelegate> delegate;

@end
