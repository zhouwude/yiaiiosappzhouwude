//
//  LandedViewController.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"

@interface LandedViewController : ZCFBaseViewController <UITextFieldDelegate>
{
    NSString *_userName;      // 帐号
    NSString *_passWord;      // 密码
    NSMutableArray *_data;
    UIImageView *_logoView;  // logo背景
    UIImageView *_lendView;  // 登陆背景
    
    UITextField *_userText;  // 帐号输入
    UITextField *_passText;  // 密码输入
    NSTimer *timer;
    BOOL loadFinish;
    CfAlertView *_alerView;
}

@property(nonatomic,strong)NSString *ID;
@end
