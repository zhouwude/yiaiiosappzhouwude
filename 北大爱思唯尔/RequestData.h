//
//  RequestData.h
//  北大爱思唯尔
//
//  Created by me2 on 14-8-26.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteMenu.h"
@interface RequestData : NSObject
@property(nonatomic,strong)NSMutableArray *dataArray;
+(RequestData *)shareManager;
-(void)number:(NSInteger)row remoteMenu:(RemoteMenu *)menu;
@end
