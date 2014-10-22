//
//  CfAlertView.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-29.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "CfAlertView.h"

@implementation CfAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (UIAlertView *)showMessage:(NSString *)message title:(NSString *)title cancel:(NSString *)cancel other:(NSString *)other
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:other, nil];
    [alert show];
    
    return alert;
}


@end
