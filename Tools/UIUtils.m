//
//  UIUtils.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIUtils.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"

@implementation UIUtils

+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate
{
    // 格式化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设置格式化 “12-12-03 9:21” // datestring
    [dateFormatter setDateFormat:formate];
    // 将字符串转换成NSDate
    NSDate *date = [dateFormatter dateFromString:datestring];
    [dateFormatter release];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *datestring = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return datestring;
}

+ (long long)countDirectorySize:(NSString *)directory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        //        NSNumber *filesize = [attribute objectForKey:NSFileSize];
        long long size = [attribute fileSize];
        
        sum += size;
    }
    
    return sum;
}

+ (NSString *)subString:(NSString *)orginal
{
    NSRange range1 = [orginal rangeOfString:@">"];
    // 从字符串末尾开始查找
    NSRange range2 = [orginal rangeOfString:@"<" options:NSBackwardsSearch];
    
    NSString *sub = [orginal substringWithRange:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
    return sub;
}


+ (NSString *)parseTextLink:(NSString *)orginal
{
    //    NSString *weiboText =[NSString stringWithFormat:@"%@", orginal];
    // \w 字母，中文、下划线、数字
    NSArray *values = [orginal componentsMatchedByRegex:@"(@\\w+|#[^#]+#|(http|https)://([A-Za-z0-9.?&=/'])+)"];
    
    //NSLog(@"new : %@", orginal);
    for (id value in values) {
        
        // 替换的内容
        NSString *replace = [NSString stringWithFormat:@"<a href='%@'>%@</a>", [value URLEncodedString], value];
        
        // 1 ,target:替换谁  2, replacement:需要替换内容
        orginal = [orginal stringByReplacingOccurrencesOfString:value withString:replace];
    }
    
    return orginal;
}
@end
