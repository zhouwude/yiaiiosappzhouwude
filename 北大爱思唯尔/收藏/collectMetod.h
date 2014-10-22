//
//  collectMetod.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-24.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "collectModel.h"
@class DetailModel;
@interface collectMetod : NSObject
@property(nonatomic,strong)collectModel *collModel;
-(void)insetData:(DetailModel *)model;
+(NSMutableArray *)synFindData;
+(id)manager;
+(void)dropAllTable;
-(void)clearTableData;
+(NSArray *)findColumn:(NSString *)propertyName;
+(void)update:(NSString *)updateORdelete data:(id)wantData row:(NSInteger)row;
@end
