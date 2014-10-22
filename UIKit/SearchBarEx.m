//
//  SearchBarEx.m
//  mcare-uihd
//
//  Created by lyuan on 13-2-26.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import "SearchBarEx.h"

@implementation SearchBarEx

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self deleteBgImage];
    }
    return self;
}

- (void)deleteBgImage
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
    }
}

@end
