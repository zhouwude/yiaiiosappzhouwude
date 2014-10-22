//
//  MainViewController.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemView;
@interface MainViewController : UITabBarController

{
    UIImageView *tabBarView;
}

@property (nonatomic, retain) NSArray *images;      // 标签图片
@property (nonatomic, retain) NSArray *selectImgs;

@property (nonatomic, retain) ItemView *lastView;


// 截取屏幕视图
@property (nonatomic, retain) UIImageView *oldView;

- (void)setHiddenTabBarView:(BOOL)isHidden isAnimated:(BOOL)animated;

@end
