//
//  MSChatListViewController.m
//  记账本
//
//  Created by FanYuepan on 16/2/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSChatListViewController.h"

@implementation MSChatListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最近联系人";
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    
    self.conversationListTableView.tableFooterView = [UIView new];
}



/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}


/**
 *  退出登录
 *
 *  @param sender <#sender description#>
 */
- (void)leftBarButtonItemPressed:(id)sender {
    NSLog(@"要退出吗？");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"会话";
}
@end
