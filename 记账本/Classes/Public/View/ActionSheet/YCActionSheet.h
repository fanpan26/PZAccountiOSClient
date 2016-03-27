//
//  YCActionSheet.h
//  SimpleSelectionView
//
//  Created by 范月成 on 16/3/18.
//  Copyright © 2016年  Will. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSheetHeight 50
#define kActionSheetMaxHeight 320
#define kShareCellHeight 80
#define kUniversalHeight 44
#define kLableHeight 20
#define kSelectionTextFontSize 16
#define kShareTextFontSize 12

#import "UIColor+MS.h"

@protocol YCActionSheetProtocol <NSObject>

@required
/**
 *  ActionSheet
 *  @param labelText     按钮上要显示的文字
 *  @param textColor     按钮上要显示的文字的颜色  可为nil 默认黑色
 *  @param shouldDismiss 点击按钮是否隐藏actionsheet
 */
- (void)addItemWithLabelText:(NSString *)labelText textColor:(NSString *)textColor shouldDismiss:(BOOL)shouldDismiss;

@end

@protocol YCShareViewProtocol <NSObject>

@required
/**
 *  Share
 *
 *  @param labelText     分享平台名称
 *  @param imageName     分享平台logo
 *  @param textColor     分享文字颜色 可为nil 默认黑色
 *  @param shouldDismiss 点击按钮是否隐藏actionsheet
 *  @param isShare       是否为分享
 */
- (void)addItemWithLabelText:(NSString *)labelText imageName:(NSString *)imageName textColor:(NSString *)textColor shouldDismiss:(BOOL)shouldDismiss isShare:(BOOL)isShare;

@end


@interface YCActionSheet : UIView

+ (void)showWithItemsBlock:(void (^)(id <YCActionSheetProtocol> items))itemsBlock selectedBlock:(void (^)(NSInteger selectedTag))selectedBlock;

+ (void)shareWithItemsBlock:(void (^)(id <YCShareViewProtocol> items))itemsBlock selectedBlock:(void (^)(NSInteger selectedSection, NSInteger selectedRow))selectedBlock;


@end
