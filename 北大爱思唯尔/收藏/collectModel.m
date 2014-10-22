//
//  collectModel.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-24.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "collectModel.h"

@implementation collectModel
+(BOOL)dbWillInsert:(NSObject *)entity
{
    LKErrorLog(@"will insert : %@",NSStringFromClass(self));
    return YES;
}
//已经插入数据库
+(void)dbDidInserted:(NSObject *)entity result:(BOOL)result
{
    LKErrorLog(@"did insert : %@",NSStringFromClass(self));
}
+(NSString *)getTableName
{
    
    NSString *str = [NSString stringWithFormat:@"%@YIAICouseTable",DEFAULT(USERNAME)];
    return str;
}
@end
