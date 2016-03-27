//
//  PZLoadingNavigationTitle.h
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PZLoadingNavigationTitle : UIView

-(instancetype)initWithTitle:(NSString *)title;

@property(nonatomic,copy) NSString *title;


-(void)startAnimation;
-(void)stopAnimation;
@end
