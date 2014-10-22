//
//  ZCFUserInfoHeaderView.h
//  LaShouUserInfo
//
//  Created by dianru on 14-7-30.
//  Copyright (c) 2014年 shixianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class personalCenterModel;
@interface ZCFUserInfoHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;



@property (strong, nonatomic) IBOutlet UIImageView *userImage;


@property (strong, nonatomic) IBOutlet UILabel *username;
// 余额
@property (strong, nonatomic) IBOutlet UILabel *accountBalance;
@property (weak, nonatomic) IBOutlet UILabel *shadwLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

// 优惠券
@property (strong, nonatomic) IBOutlet UILabel *coupon;
// 收藏
@property (strong, nonatomic) IBOutlet UILabel *collection;



@property (nonatomic, strong) void(^buttonDelegate)(NSInteger index);
-(void)configUI;
-(void)configUI1;
-(void)configUITest;
//-(void)configUI2:(NSInteger)buttonNum;
@end
