//
//  PZActionItem.h
//  记账本
//
//  Created by FanYuepan on 16/3/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PZActionSheetItemDelegate<NSObject>

@required

-(void)addWithTitle:(NSString *)title icon:(NSString *)icon identifier:(NSString *)identifier;

@end

@interface PZActionSheetItem : NSObject<PZActionSheetItemDelegate>

@property(nonatomic,strong) NSMutableArray *identifiers;

@property(nonatomic,strong) NSMutableArray *icons;

@property(nonatomic,strong) NSMutableArray *titles;

@end
