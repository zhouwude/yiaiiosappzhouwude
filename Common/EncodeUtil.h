//
//  EncodeUtil.h
//  mcare-core
//
//  Created by sam on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncodeUtil : NSObject

+ (NSString *)getMD5ForStr:(NSString *)str;
+ (NSString *)md5_16:(NSString *)str;
+ (NSString *)md5_32:(NSString *)str;
+ (NSString *)MD5_16:(NSString *)str;
+ (NSString *)MD5_32:(NSString *)str;
+ (NSString *)md5_num:(NSString *)str;
+ (NSString *)generateUUID;
+ (UIImage *)convertImage:(UIImage *)origImage scope:(CGFloat)scope;
+ (UIImage *)tailorImage:(UIImage *)origImage scope:(CGFloat)scope;
+ (NSString *)formatPhone:(NSString *)phone;
+ (int)getRandomNumber:(int)from to:(int)to;

@end
