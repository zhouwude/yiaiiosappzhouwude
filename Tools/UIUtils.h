//
//  UIUtils.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

// 将字符串格式化为Date对象
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate;

// 将日期格式化为NSString对象
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

// 截取字符串
+ (NSString *)subString:(NSString *)orginal;

// 计算目录下面所有文件的大小
+ (long long)countDirectorySize:(NSString *)directory;

// 将原始内容转变成链接内容
+ (NSString *)parseTextLink:(NSString *)orginal;
@end
