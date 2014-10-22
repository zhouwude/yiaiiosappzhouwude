//
//  RemoteMenu.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemoteMenu : UIView
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,assign)NSInteger  number2;
@property (nonatomic, strong)NSArray *data;
@property(nonatomic,strong)NSArray *UrlData;
@property (nonatomic, strong)UIButton *button;
@property(nonatomic,strong)UIImageView *imageView;
@property (nonatomic,copy)void(^urlBlock)(NSString *str);
@property(nonatomic,strong)id parent;
@property(nonatomic,assign)NSInteger sign;
@end
