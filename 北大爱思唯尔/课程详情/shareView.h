//
//  shareView.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-4.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapImageView.h"
@interface shareView : UIView<IamgeDelegate>
@property(nonatomic,copy)void(^shareBlock)(NSInteger num);
@end
