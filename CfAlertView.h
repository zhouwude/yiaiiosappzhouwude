//
//  CfAlertView.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-29.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CfAlertView : UIAlertView

+ (UIAlertView *)showMessage:(NSString *)message title:(NSString *)title cancel:(NSString *)cancel other:(NSString *)other;
@end