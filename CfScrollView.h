//
//  CfScrollView.h
//  北大爱思唯尔
//
//  Created by me2 on 14-8-27.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CfScrollView : UIScrollView
@property(nonatomic,strong)NSArray *ImageArray;
@property(nonatomic,strong)void(^backBlock)();
-(void)configImage:(NSArray *)array;

@end