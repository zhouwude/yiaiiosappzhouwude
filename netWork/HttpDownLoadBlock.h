//
//  HttpDownLoadBlock.h
//  HttpRequestDemo_1409
//
//  Created by ZhangCheng on 14-5-20.
//  Copyright (c) 2014年 张诚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpDownLoadBlock : NSObject<NSURLConnectionDataDelegate>
@property(nonatomic,retain)NSURLConnection*connection;
@property(nonatomic,retain)NSData*data;
//缓存目录地址
@property(nonatomic,copy)NSString*pathFile;
//解析后的结果
@property(nonatomic,retain)NSArray*dataArray;
@property(nonatomic,retain)NSDictionary*dataDict;
@property(nonatomic,retain)UIImage*dataImage;


//取消请求
-(void)cancelBlock;

//建立block指针
@property(nonatomic,copy)void(^httpRequestBlock)(HttpDownLoadBlock*,BOOL);

//外部初始化设置的函数
//(void(^)(HttpDownLoadBlock*,BOOL))a 函数指针

-(id)initWithUrlStr:(NSString*)urlStr setBlock:(void(^)(HttpDownLoadBlock*,BOOL))a;
@end
