//
//  GradeHelper.m
//  hangcom-core
//
//  Created by 无忧 on 13-12-17.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "GradeHelper.h"
#import "DateUtil.h"
#import "ClickUtil.h"

@implementation GradeHelper

+ (void)setGradeEvent:(NSString *)gradeEvent MyappID:(NSString *)MyappID
{
    NSString *defaultsVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"gradeEvent"];
    if (defaultsVersion == nil || (NSObject *)defaultsVersion == [NSNull null]) {
        [[NSUserDefaults standardUserDefaults] setObject:gradeEvent forKey:@"gradeEvent"];
        [[NSUserDefaults standardUserDefaults] setObject:MyappID forKey:@"appID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)inspectCondition
{
    NSString *defaultsVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if (defaultsVersion == nil || (NSObject *)defaultsVersion == [NSNull null]) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
        [[NSUserDefaults standardUserDefaults] setObject:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"] forKey:@"FirstDay"];
        [[NSUserDefaults standardUserDefaults] setObject:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"] forKey:@"TheDay"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:@"activateCount"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"isGrade"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (BOOL)getIsShowGrade
{
    /**版本对比**/
    NSString *version1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    NSString *version2 = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if ([version1 isEqualToString:version2] == NO) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
        [[NSUserDefaults standardUserDefaults] setObject:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"] forKey:@"FirstDay"];
        [[NSUserDefaults standardUserDefaults] setObject:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"] forKey:@"TheDay"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"isGrade"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    /**判断是否已评分**/
    BOOL isGrade = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isGrade"] boolValue];
    if (isGrade) {
        return NO;
    }
    /**判断当天点击次数**/
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:@"TheDay"];
    
    int num = [[[NSUserDefaults standardUserDefaults] objectForKey:@"activateCount"] intValue];
    NSLog(@"activateCount   %d",num);
    if ([time isEqualToString:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"]]) {
        num++;
        [[NSUserDefaults standardUserDefaults] setObject:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"] forKey:@"TheDay"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:num] forKey:@"activateCount"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"] forKey:@"TheDay"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"activateCount"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    time = [[NSUserDefaults standardUserDefaults] objectForKey:@"TheDay"];
    NSString *firstDay = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstDay"];
    if ([firstDay isEqualToString:time]) {
        return NO;
    }
    
    NSLog(@"%d",num);
    if (num == 3) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)goToGrade
{
    NSString *event = [[NSUserDefaults standardUserDefaults] objectForKey:@"gradeEvent"];
    NSString *MyappID = [[NSUserDefaults standardUserDefaults] objectForKey:@"appID"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[DateUtil getFormatTime:[NSDate date] format:@"yyyyMMdd"] forKey:@"grade_time"];
    [dict setObject:MyappID forKey:@"grade_appID"];
    [ClickUtil event:event attributes:dict];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"isGrade"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *path;
    if (version >= 7.0) {
        path = @"itms-apps://itunes.apple.com/app/id";
    } else {
        path = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=";
    }
    NSString *appURL = [NSString stringWithFormat:@"%@%@", path, MyappID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
}

@end
