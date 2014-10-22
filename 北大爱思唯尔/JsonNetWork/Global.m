//
//  Global.m
//  find
//
//  Created by sam on 13-5-13.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (NSString *)getHost
{
    //api.6tennis.com/Article/info/aid/455
    //api.6tennis.com/Article/index/p/57
    return @"kouqiang.yiaiwang.com.cn";
}

+ (NSString *)getPath
{
    return @"/index.php";
}

+ (NSString *)getPicDownloadUrl
{
    return @"http://www.6tennis.com/upload_files/";
}

+ (NSString *)getClientId
{
    static NSString *clientID;
    if (clientID == nil) {
        clientID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ClientID"];
        if (clientID == nil) {
            clientID = @"TennisClient";
        }
    }
    return clientID;
}

+ (NSString *)getAccessToken
{
    static NSString *access_token = nil;
    if (access_token == nil) {
        return @"AID_200100";
    } else {
        return access_token;
    }
}

+ (NSMutableDictionary *)getHeader
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"2.0" forKey:@"jsonrpc"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"id"];
    return dict;
}

+ (NSInteger)getPageCount
{
    return 15;
}

+ (CGFloat)getSysVer
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (CGFloat)getOffset
{
    return ([Global getSysVer] >= 7.0)? 20:0;
}

@end
