//
//  DateUtil.m
//  mcare-core
//
//  Created by sam on 12-8-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSInteger)getWeekDay:(NSString *)theDay
{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                              
                                         fromDate:[self convertDay:theDay]];
    
    NSInteger weekday = [comps weekday];
    return weekday;
}

+ (NSDateFormatter *)getDataFormatter
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
}

+ (NSCalendar *)getCalendar
{
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    });
    return calendar;
}

+ (NSString *)getFormatTime:(NSDate *)date format:(NSString *)format
{
    NSString *time = @"";
    if (date != nil) {
        NSDateFormatter *dateFormatter = [DateUtil getDataFormatter];
        [dateFormatter setDateFormat:format];
        time = [dateFormatter stringFromDate:date];
        if (time == nil) {
            time = @"";
        }
    } else {
        //time = [NSNull null];
        time = @"";
    }
    return time;
}

+ (NSString *)getFormatTime:(NSDate *)date
{
    return [DateUtil getFormatTime:date format:@"MM-dd HH:mm"];
}

+ (NSDate *)convertTime:(NSString *)time
{
    NSDate *time2 = nil;
    if ((NSObject *)time != [NSNull null]) {
        NSDateFormatter *dateFormatter = [DateUtil getDataFormatter];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        time2 = [dateFormatter dateFromString:time];
    } else {
        
    }
    return time2;
}

+ (NSDate *)convertDay:(NSString *)time
{
    NSDate *time2 = nil;
    if ((NSObject *)time != [NSNull null]) {
        NSDateFormatter *dateFormatter = [DateUtil getDataFormatter];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        time2 = [dateFormatter dateFromString:time];
    } else {
        
    }
    return time2;
}

+ (NSDate *)convertTimeFromNumber:(NSNumber *)time
{
    NSDate *time2 = nil;
    if ((NSObject *)time != [NSNull null] && time != nil) {
        time2 = [NSDate dateWithTimeIntervalSince1970:[time longLongValue]];
    }
    return time2;
}

+ (NSString *)convertToDay:(NSDate *)date
{
    return [DateUtil getFormatTime:date format:@"yyyy-MM-dd"];
}

+ (NSNumber *)convertNumberFromTime:(NSDate *)time
{
    NSNumber *time2 = nil;
    if ((NSObject *)time != [NSNull null] && [time isKindOfClass:[NSDate class]]) {
        long long l = [time timeIntervalSince1970];
        time2 = [NSNumber numberWithDouble:l];
    } else {
        time2 = [NSNumber numberWithDouble:0];
    }
    return time2;

}

+ (NSMutableArray *)getMonthArrayFrom2014
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 2014; i <2024 ; i ++) {
        for (int j = 1; j < 13; j++) {
            [array addObject:[NSString stringWithFormat:@"%d%02d",i,j]];
        }
    }
    
    return array;
}

+ (NSMutableArray *)getMonthByYearArrayFrom2014
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 2014; i < 2024; i ++) {
        NSMutableArray *month = [NSMutableArray array];
        for (int j = 1; j < 13; j ++) {
            [month addObject:[NSString stringWithFormat:@"%d%02d",i,j]];
        }
        [array addObject:month];
    }
    return array;
}

+ (NSMutableArray *)getYearArrayFrom2014
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 2014; i <2024 ; i ++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    return array;
}

+ (NSMutableArray *)getMonthArray
{
    NSMutableArray *array = [NSMutableArray array];
    int year = [[self getYear] intValue];
    int month = [[self getMonth:[NSDate date]] intValue];
    
    for (int i = year-2013; i > -1 ; i --) {
        for (int j = 1; j < 13; j++) {
            [array insertObject:[NSString stringWithFormat:@"%d%02d",year-i,j] atIndex:0];
        }
    }
    if (month < 12) {
        for (int i = 0; i < 12-month; i ++) {
            [array removeObjectAtIndex:0];
        }
    }
    for (int i = 0; i < 4; i ++) {
        [array removeLastObject];
    }
    
    return array;
}

+ (NSString *)getMessageTime:(NSDate *)date
{
    NSString *str = nil;
    NSDateComponents *comp1 = [self getComponenet:date];
    NSDateComponents *comp2 = [self getComponenet:[NSDate date]];
    if (comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day) {
        str = [NSString stringWithFormat:@"%02d:%02d", comp1.hour, comp1.minute];
    } else {
        str = [NSString stringWithFormat:@"%d-%02d", comp1.month, comp1.day];
    }
    return str;
}

+ (NSString *)getDisplayTime:(NSDate *)date
{
    NSString *str = nil;
    NSTimeInterval interval = 0-[date timeIntervalSinceNow];
    if (interval > 24*60*60) {
        if ((int)(interval/(24*60*60)) < 3) {
            str = [NSString stringWithFormat:@"%d天前", (int)(interval/(24*60*60))];
        } else {
            str = [DateUtil convertToDay:date];
        }
    } else if (interval > 60*60) {
        str = [NSString stringWithFormat:@"%d小时前", (int)(interval/(60*60))];
    } else if (interval > 60) {
        str = [NSString stringWithFormat:@"%d分钟前", (int)(interval/60)];
    } else if (interval > 0) {
        str = @"刚才";
    } else {
        str = @"";
    }
    return str;
}

+ (NSString *)getYears:(NSDate *)date
{
    NSInteger year;
    NSTimeInterval interval = 0-[date timeIntervalSinceNow];
    year = interval/(24*60*60*365);
    return [NSString stringWithFormat:@"%d", year];
}

+ (NSString *)getMonth:(NSDate *)date
{
    return [DateUtil getFormatTime:date format:@"MM"];
}

+ (NSString *)getYearMonth:(NSDate *)date
{
    return [DateUtil getFormatTime:date format:@"yyyyMM"];
}

+ (NSString *)getYearMonthDay:(NSDate *)date
{
    return [DateUtil getFormatTime:date format:@"yyyyMMdd"];
}

+ (NSString *)getYear
{
    return [NSString stringWithFormat:@"%@",[DateUtil getFormatTime:[NSDate date] format:@"yyyy"]];
}

+ (NSString *)getDisplayTime:(NSDate *)date num:(NSInteger)num
{
    NSString *str = nil;
    NSTimeInterval interval = 0-[date timeIntervalSinceNow];
    if(interval > num*24*60*60) {
        str = [DateUtil getFormatTime:date format:@"yyyy-MM-dd"];
    } else {
        str = [DateUtil getDisplayTime:date];
    }
    return str;
}

+ (NSDate *)dateFromComponent:(NSDateComponents *)omponent
{
    return [[DateUtil getCalendar] dateFromComponents:omponent];
}

+ (NSDateComponents *)getComponenet:(NSDate *)date
{
    NSDateFormatter *formatter = [DateUtil getDataFormatter];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [DateUtil getCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    return comps;
}


@end
