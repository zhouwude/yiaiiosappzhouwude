//
//  MkNetWorkParse.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-12.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "MkNetWorkParse.h"

@implementation MkNetWorkParse




+(void)requestData:(id)string Method:(NSString *)str success:(SuccessBlock)success fail:(FailureBlock)faile{
    
    if ([str isEqualToString:@"GET"]){
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:[Global getHost] customHeaderFields:nil];
    
    MKNetworkOperation *op = [engine operationWithPath:string params:nil httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //NSLog(@"request string: %@",[self replaceUnicode:[completedOperation responseString]]);
        success([completedOperation responseJSON]);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        NSLog(@"error: %@", error);
        faile(error, [errorOp responseString]);
    }];
    
    NSLog(@"url:%@", op.url);
    [engine enqueueOperation:op];
    }
    
    if ([str isEqualToString:@"POST"]){
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:[Global getHost] customHeaderFields:nil];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setValue:@"admin" forKey:@"username"];
//        [dic setValue:@"123" forKey:@"password"];
        
        MKNetworkOperation *op = [engine operationWithPath:[Global getPath] params:string httpMethod:@"POST"];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSLog(@"request string: %@",[completedOperation responseJSON]);
            
            success([completedOperation responseJSON]);
        } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
            NSLog(@"error: %@", error);
            faile(error, [errorOp responseString]);
        }];
        

        NSLog(@"url:%@", op.url);
        
        [engine enqueueOperation:op];
        
    }
    
    
    
    
}


@end
