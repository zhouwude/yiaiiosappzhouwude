//
//  ProgressHUD.m
//  aqgj
//
//  Created by Sam on 11-10-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ProgressHUD.h"
#import "MBProgressHUD.h"

@implementation ProgressHUD

- (void)showProgressHD:(BOOL)tf inView:(UIView *)inView info:(NSString *)info
{
    if (tf == YES) {
        if (hud == nil) {
            hud = [[MBProgressHUD alloc] initWithView:inView];
            hud.yOffset = offsetY;
            [inView addSubview:hud];
        }
        hud.labelText = info;
        [hud show:YES];
    } else {
        if (hud != nil) {
            [hud hide:YES];
            [hud removeFromSuperview];
            hud = nil;
        }
    }
}

+ (id)instance
{
    static ProgressHUD *ph;
    if (ph == nil) {
      ph = [[ProgressHUD alloc] init];
    }
    return ph;
}

- (void)setOffsetY:(CGFloat)y
{
    offsetY = y;
}

- (void)CompletedProgressHD:(BOOL)tf inView:(UIView *)inView msg:(NSString *)msg
{
    if (tf == YES) {
        if (hud == nil) {
            hud = [[MBProgressHUD alloc] initWithView:inView];
            hud.yOffset = offsetY;
            [inView addSubview:hud];
        }
        hud.labelText = msg;
        [hud show:NO];
    } else {
        if (hud != nil) {
            [hud hide:YES];
            [hud removeFromSuperview];
            hud = nil;
        }
    }
}

@end
