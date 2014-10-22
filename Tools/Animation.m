//
//  Animation.m
//  Scroller缩放
//
//  Created by qianfeng on 14-6-16.
//  Copyright (c) 2014年 周武德. All rights reserved.
//

#import "Animation.h"

@implementation Animation

+(CATransition *)Amimayion:(NSString *)subType{
    CATransition *Animation = [CATransition animation];
    Animation.type = @"cube";
    //动画方向
    Animation.subtype  = subType;
    //持续时间。。
    Animation.duration = 1.0;
    //作用效果。easeout 缓和曲线离开.
    Animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    /*
     1.	 pageCurl            向上翻一页
     2.	 pageUnCurl          向下翻一页
     3.	 rippleEffect        滴水效果
     4.	 suckEffect          收缩效果，如一块布被抽走
     5.	 cube                立方体效果
     6.	 oglFlip             上下翻转效果
     */
    return Animation;
}

@end
