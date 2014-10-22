//
//  UIView+ViewController.m
//  WXWeibo
//
//  Created by 喵~ on 14-4-12.
//  Copyright (c) 2014年 无线互联3g学院. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
- (UIViewController *)viewController
{
    id next = [self nextResponder];
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return next;
        }
        
        next = [next nextResponder];
    }
    return nil;
}
@end
