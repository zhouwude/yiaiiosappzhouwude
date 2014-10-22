//
//  ProgressHUD.h
//  aqgj
//
//  Created by Sam on 11-10-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

@class MBProgressHUD;

@interface ProgressHUD : NSObject {
    MBProgressHUD *hud;
    CGFloat offsetY;
}

+ (id)instance;
- (void)showProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info;
- (void)CompletedProgressHD:(BOOL)tf inView:(UIView *)inView msg:(NSString *)msg;
- (void)setOffsetY:(CGFloat)y;

@end
