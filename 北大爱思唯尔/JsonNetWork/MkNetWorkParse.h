//
//  MkNetWorkParse.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-12.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//
typedef void (^SuccessBlock)(id JSON);
typedef void (^FailureBlock)(NSError *error, id JSON);
#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
@interface MkNetWorkParse : NSObject
//@property(nonatomic,strong)void(^successRequest)(id dataJson);
+(void)requestData:(id)string Method:(NSString *)str success:(SuccessBlock)success fail:(FailureBlock)faile;
@end
