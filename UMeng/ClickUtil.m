//
//  ClickUtil.m
//  zhihuhd
//
//  Created by 无忧 on 13-11-5.
//  Copyright (c) 2013年 mobimac. All rights reserved.
//

#import "ClickUtil.h"
#import "MKNetworkEngine.h"

@implementation ClickUtil

+ (void)startWithAppkey:(NSString *)myappid reportPolicy:(ReportPolicy)reportPolicy channelId:(NSString *)channelId
{
    [MobClick startWithAppkey:myappid reportPolicy:reportPolicy channelId:channelId];
}

+ (void)clickEvent:(NSString *)event
{
    [MobClick event:event];
}

+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes
{
    [MobClick event:eventId attributes:attributes];
    [ClickUtil sendEvent:eventId attributes:attributes];
}

+ (void)beginEvent:(NSString *)eventId
{
    [MobClick beginEvent:eventId];
}

+ (void)endEvent:(NSString *)eventId
{
    [MobClick endEvent:eventId];
}

+ (void)sendUsage:(NSDictionary *)info success:(void (^)(id JSON))success failure:(void (^)(NSError *error, id JSON))failure
{
    [[ClickUtil getParams] setValuesForKeysWithDictionary:info];

    MKNetworkOperation *op = [[ClickUtil getEngine] operationWithPath:@"appusage" params:info httpMethod:@"POST" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        success([completedOperation responseJSON]);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        failure(error, [errorOp responseString]);
    }];
    [[self getEngine] enqueueOperation:op];
}

+ (void)sendEvent:(NSString *)eventId attributes:(NSDictionary *)attributes
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[ClickUtil getParams]];
    [dict addEntriesFromDictionary:attributes];
    [dict setObject:eventId forKey:@"eventid"];
    //
    MKNetworkOperation *op = [[ClickUtil getEngine] operationWithPath:@"appevent" params:dict httpMethod:@"POST" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"success: %@", [completedOperation responseString]);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        NSLog(@"error: %@", [errorOp responseString]);
    }];
    [[self getEngine] enqueueOperation:op];
}

+ (NSMutableDictionary *)getParams
{
    static NSMutableDictionary *params = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        params = [[NSMutableDictionary alloc] init];
    });
    return params;
}

+ (MKNetworkEngine *)getEngine
{
    static MKNetworkEngine *engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *header = [NSMutableDictionary dictionary];
        engine = [[MKNetworkEngine alloc] initWithHostName:@"api.imxfd.com" apiPath:@"v1" customHeaderFields:header];
    });
    return engine;
}

@end
