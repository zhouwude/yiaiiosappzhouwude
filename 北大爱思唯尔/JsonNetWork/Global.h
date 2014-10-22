//
//  Global.h
//  find
//
//  Created by sam on 13-5-13.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

+ (NSString *)getHost;
+ (NSString *)getPath;
+ (NSString *)getPicDownloadUrl;
+ (NSString *)getClientId;
+ (NSString *)getAccessToken;
+ (NSMutableDictionary *)getHeader;
+ (NSInteger)getPageCount;
+ (CGFloat)getSysVer;

@end
