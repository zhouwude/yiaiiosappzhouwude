//
//  SXJDataService.h
//  好豆菜谱
//
//  Created by 喵~ on 14-4-21.
//  Copyright (c) 2014年 石显军. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Reachability;
@interface SXJDataService : NSObject
// 本地请求
+ (id)requestDataWithName:(NSString *)name;

// 网络请求
+ (void)requestURL:(NSString *)requestURL
            method:(NSString *)method
            params:(NSDictionary *)params
        completion:(void (^)(id result))completion
             error:(void (^)(id error))error;
@end
