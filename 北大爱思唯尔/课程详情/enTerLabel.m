//
//  enTerLabel.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-4.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "enTerLabel.h"

@implementation enTerLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_parent Click2];
}

@end
