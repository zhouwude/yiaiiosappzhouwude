//
//  UIWebView+VideoControl.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-22.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (VideoControl)
- (BOOL)hasVideo;
- (NSString *)getVideoTitle;
- (double)getVideoDuration;
- (double)getVideoCurrentTime;

- (int)play;
- (int)pause;
- (int)resume;
- (int)stop;

@end
