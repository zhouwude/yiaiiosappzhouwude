//
//  SXJDataService.m
//  好豆菜谱
//
//  Created by 喵~ on 14-4-21.
//  Copyright (c) 2014年 石显军. All rights reserved.
//

#import "SXJDataService.h"
#import "Reachability.h"

@implementation SXJDataService


/*-------------------------------    从本地请求    -----------------------------------*/
//请求电影数据
+ (id)parserData:(NSString *)name
{
    //获取包路径对应的json文件
    [SVProgressHUD showWithStatus:@"正在请求数据" maskType:SVProgressHUDMaskTypeClear];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 读取成 data
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    //版本判断
    UIDevice *device = [UIDevice currentDevice];
    NSDictionary *result = nil;
    if ([[device systemVersion] floatValue] >= 0.5) {
        
        //ios5之后 框架解析
        result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    }
    return result;
}

+ (id)requestDataWithName:(NSString *)name
{
    id result = [self parserData:name];
    return result;
}


/*-------------------------------    从网络请求    -----------------------------------*/
+ (void)requestURL:(NSString *)requestURL
            method:(NSString *)method
            params:(NSDictionary *)params
        completion:(void (^)(id result))completion
             error:(void (^)(id error))error
{
    Reachability *hostReach = [Reachability reachabilityForInternetConnection];
    
    
    if ([hostReach currentReachabilityStatus] == NotReachable) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"没找到网络，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [view show];
        completion(nil);
        return;
    }else{
        
        // 将参数拼接
        NSInteger count = [params count];
        NSMutableString *append = nil;
        if (count > 0) {
            
            NSArray *keys = [params allKeys];
            append = [NSMutableString string];
            for (int i = 0; i < count; i++) {
                
                if (i > 0) {
                    [append appendFormat:@"&"];
                }
                // 1个参数 pageIndex=1
                // 2个参数 pageIndex=1&count=5
                NSString *key = keys[i];
                NSString *value = params[key];
                // 当存在多个参数时
                // 拼接字符串
                [append appendFormat:@"%@=%@", key, value];
            }
        }
        
        // 设置请求方法
        NSData *data = nil;
        if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
            
            if (append != nil) {
                requestURL = [requestURL stringByAppendingFormat:@"?%@", append];
            }
            
        }else if ([method caseInsensitiveCompare:@"POST"] == NSOrderedSame){
            
            if (append != nil) {
                data = [append dataUsingEncoding:NSUTF8StringEncoding];
            }
            
        }else {
            //...
        }
        
        NSLog(@"请求数据： %@", [NSString stringWithFormat:@"%@%@", kBaseURL, requestURL]);
        
        // 编码
        NSString *encode = [[NSString stringWithFormat:@"%@%@", kBaseURL, requestURL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // 构造URL
        NSURL *url = [NSURL URLWithString:encode];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = method;
        request.HTTPBody = data;
        // 建立连接
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (connectionError) {
                NSLog(@"error : %@", connectionError);
                error(connectionError);
                return;
            }
            
            // 服务器给我们的数据，将数据解析，JSON
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
            completion(result);
            [SVProgressHUD dismiss];
            
        }];
    }
    
}
@end
