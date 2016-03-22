//
//  PZActionItem.m
//  记账本
//
//  Created by FanYuepan on 16/3/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZActionSheetItem.h"

@implementation PZActionSheetItem

-(void)addWithTitle:(NSString *)title icon:(NSString *)icon identifier:(NSString *)identifier
{
    [self.identifiers addObject:identifier];
    [self.icons addObject:icon];
    [self.titles addObject:title];
}

#pragma  mark getter setter

-(NSMutableArray *)icons
{
    if (_icons == nil) {
        _icons = [NSMutableArray array];
    }
    return  _icons;
}

-(NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

-(NSMutableArray *)identifiers
{
    if (_identifiers == nil) {
        _identifiers = [NSMutableArray array];
    }
    return  _identifiers;
}

@end
