//
//  NetWorkDecideD.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "NetWorkDecideD.h"

@implementation NetWorkDecideD
+(void)getNetwork{
    
    
    
    Reachability *r = [Reachability reachabilityWithHostname:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没有网络连接");
            // 没有网络连接
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"使用3G网络");

            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"使用WiFi网络");

            break;
    }
}
// 是否wifi
+ (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}
// 是否3G
+ (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}
@end
