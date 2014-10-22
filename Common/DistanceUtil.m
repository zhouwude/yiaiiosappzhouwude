//
//  DistanceUtil.m
//  hangcom-core
//
//  Created by sam on 13-5-20.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "DistanceUtil.h"

@implementation DistanceUtil

+ (NSString *)getDisplayDistance:(CGFloat)distance
{
    NSString *str = nil;
    if (distance >= 1000) {
        str = [NSString stringWithFormat:@"%d公里", (int)(distance/1000)];
    } else if (distance >= 0) {
        str = [NSString stringWithFormat:@"%d米", (int)distance];
    } else {
        str = @"";
    }
    return str;
}

@end
