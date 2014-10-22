//
//  collectModel.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-24.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
@interface collectModel : NSObject
@property(nonatomic,strong)NSString *courseID;
@property(nonatomic,strong)NSString *Expert_introduction;

@property(nonatomic,strong)NSString *fullName;

@property(nonatomic,strong)NSString *speaker;
@property(nonatomic,strong)NSString *technical;
@property(nonatomic,strong)NSString *price;
@end
