//
//  FileUtil.h
//  mcare-ui
//
//  Created by sam on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

+ (BOOL)isExist:(NSString *)file;
+ (NSString *)getPicPath;
+ (NSString *)getAudioPath;
+ (NSString *)getAdPath;

+ (NSString *)getFileName:(NSString *)path;
+ (NSString *)getFilePart:(NSString *)name idx:(NSInteger)idx;
+ (NSString *)getFileName:(NSString *)path suffix:(NSString *)suffix;
+ (NSString *)getFileSuffix:(NSString *)fileName;
+ (NSString *)getBasePath;
+ (NSString *)getBaseFilePath:(NSString *)dir fileName:(NSString *)fileName;
+ (BOOL)isLocalFile:(NSString *)path;
+ (BOOL)clearDir:(NSString *)path;

+ (BOOL)isExistDir:(NSString *)path;
+ (BOOL)createDir:(NSString *)path;

@end
