//
//  SizeFit.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-22.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SizeFit : NSObject
@property (nonatomic,strong)NSString *returnString;
@property(nonatomic,assign)CGSize size;
+(SizeFit *)Manager;
-(void)JSONString:(NSString *)aString font:(CGFloat )fontSize  contain:(CGFloat)count;
@end
