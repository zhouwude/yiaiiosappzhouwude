//
//  HttpDownLoad.h
//  HttpRequestDemo_1409
//
//  Created by ZhangCheng on 14-5-20.
//  Copyright (c) 2014年 张诚. All rights reserved.
//

#import <Foundation/Foundation.h>
//协议
@class HttpDownLoad;
@protocol HttpDownLoadDelegate <NSObject>

-(void)httpRequestFinishOrFail:(HttpDownLoad*)request isFinish:(BOOL)finish;

@end

@interface HttpDownLoad : NSObject<NSURLConnectionDataDelegate>
@property(nonatomic,retain)NSURLConnection*connection;
@property(nonatomic,retain)NSMutableData*data;
//缓存目录地址
@property(nonatomic,copy)NSString*pathFile;

//代理
@property(nonatomic,assign)id<HttpDownLoadDelegate>delegate;

//解析后的结果
@property(nonatomic,retain)NSArray*dataArray;
@property(nonatomic,retain)NSDictionary*dataDict;
@property(nonatomic,retain)UIImage*dataImage;

//外部初始化设置的函数
//此函数包含了init初始化以及网络请求还有设置代理
-(id)initWithUrlStr:(NSString*)urlStr setDelegate:(id)target;



@end
