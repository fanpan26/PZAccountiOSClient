//
//  MSChatController.m
//  记账本
//
//  Created by FanYuepan on 16/2/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSChatController.h"
#import "MSChatListViewController.h"
#import <RongIMKit/RCConversationViewController.h>
#import "MSChatConfig.h"
#import "MSUserTool.h"
#import "UIImageView+MS.h"
#import "MSCurrentUser.h"
#import "MSChatUserFriendsCell.h"

@interface MSChatController()
{
    NSArray *userFriends;
}

@end

@implementation MSChatController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI
{
    userFriends = [NSArray arrayWithArray:[[MSUserTool sharedMSUserTool] getAllUsers]];
    [self.tableView registerClass:[MSChatUserFriendsCell class] forCellReuseIdentifier:@"MS_RECENT_USERS"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
    self.title  = @"聊天";
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  section == 0 ? 44 : 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSChatUserFriendsCell *recentUserCell = [tableView dequeueReusableCellWithIdentifier:@"MS_RECENT_USERS"];
    recentUserCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    recentUserCell.indexPath = indexPath;
    recentUserCell.myTableView = tableView;
    if (indexPath.section == 1) {
        recentUserCell.textLabel.text = @"最近联系";
    }else{
        MSCurrentUser *user =  userFriends[indexPath.row];
        [recentUserCell.imageView setImageWithUrl:user.userPhoto placeHolder:nil];
        recentUserCell.textLabel.text = user.userName;
        
    }
    return  recentUserCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  section == 0 ? @"我的好友" : nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MSCurrentUser *user = userFriends[indexPath.row];
        if([MSUserTool sharedMSUserTool].currentUser.userId == user.userId){
            NSLog(@"不可以给自己发信息哦");
        }
        [self redirectToFriendControllerWithUser:user];
    }
    
    if (indexPath.section == 1) {
        [self redirectToRecentController];
    }
}


-(void)redirectToFriendControllerWithUser:(MSCurrentUser *)user
{
    BOOL hasLogin = [[MSUserTool sharedMSUserTool] isLoginIMServer];
    //已经登录过了
    if (hasLogin) {
        NSLog(@"已经登陆过聊天服务器了...");
        [self toChatDetail:user];
        return;
    }
    //登录云
    NSString *token = [MSUserTool sharedMSUserTool].currentUser.userToken;
    
    
    
    [[RCIM sharedRCIM] connectWithToken:token
                                success:^(NSString *userId) {
                                    //记录登录状态
                                    [[MSUserTool sharedMSUserTool] loginIMServer];
                                    
                                    [[RCIM sharedRCIM] setUserInfoDataSource:self];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self toChatDetail:user];
                                    });
                                } error:^(RCConnectErrorCode status) {
                                    
                                } tokenIncorrect:^{
                                    
                                }];
}


-(void)redirectToRecentController
{
    BOOL hasLogin = [[MSUserTool sharedMSUserTool] isLoginIMServer];
    //已经登录过了
    if (hasLogin) {
        NSLog(@"已经登陆过聊天服务器了...");
        [self toChatList];
        return;
    }
    //登录云
    NSString *token = [MSUserTool sharedMSUserTool].currentUser.userToken;
    [[RCIM sharedRCIM] connectWithToken:token
                                success:^(NSString *userId) {
                                    //记录登录状态
                                    [[MSUserTool sharedMSUserTool] loginIMServer];

                                    [[RCIM sharedRCIM] setUserInfoDataSource:self];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self toChatList];
                                    });
                                } error:^(RCConnectErrorCode status) {
                                    
                                } tokenIncorrect:^{
                                    
                                }];
}

//跳转到聊天页面
-(void)toChatDetail:(MSCurrentUser *)user
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;//私人聊天类型
    conversationVC.targetId = [NSString stringWithFormat:@"%ld", (long)user.userId ]; //对方ID
    conversationVC.title = user.userName;//对方昵称
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

//跳转到最近聊天记录页面
-(void)toChatList
{
    MSChatListViewController *chatListViewController = [[MSChatListViewController alloc]init];
    chatListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatListViewController animated:YES];
}

//根据userId获取用户信息，实现此代理方法

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
   
        RCUserInfo *user = [[RCUserInfo alloc] init];
        //获取当前用户信息，传递给RCUserInfo
        user.userId = userId;
        user.name = [NSString stringWithFormat:@"ceshi%@",userId];
        user.portraitUri = @"http://qlogo3.store.qq.com/qzone/645857874/645857874/100?1440900705";

        return completion(user);
}

@end
