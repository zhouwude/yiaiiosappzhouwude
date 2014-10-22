//
//  FileUtil.m
//  mcare-ui
//
//  Created by sam on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (BOOL)isExist:(NSString *)file
{
    BOOL tf = YES;
    NSFileManager *nfm = [NSFileManager defaultManager];
	BOOL isDir;
	BOOL isExist = [nfm fileExistsAtPath:file isDirectory:&isDir];
    if (isExist == NO || isDir == YES) {
        tf = NO;
    }
    return tf;
}

+ (BOOL)isExistDir:(NSString *)path
{
    BOOL tf = YES;
    NSFileManager *nfm = [NSFileManager defaultManager];
	BOOL isDir;
	BOOL isExist = [nfm fileExistsAtPath:path isDirectory:&isDir];
    if (isExist == NO || isDir == NO) {
        tf = NO;
    }
    return tf;
}

+ (BOOL)createDir:(NSString *)path
{
    BOOL tf = YES;
    NSError *error = nil;
    NSFileManager *nfm = [NSFileManager defaultManager];
	tf = [nfm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    return tf;
}

+ (NSString *)getPicPath
{
    static NSString *path = nil;
    if (path == nil) {
        path = [[FileUtil getBasePath] stringByAppendingPathComponent:@"pic"];
        if ([FileUtil isExistDir:path] == NO) {
            [FileUtil createDir:path];
        }
    }
    return path;
}

+ (NSString *)getAudioPath
{
    static NSString *path = nil;
    if (path == nil) {
        path = [[FileUtil getBasePath] stringByAppendingPathComponent:@"audio"];
        if ([FileUtil isExistDir:path] == NO) {
            [FileUtil createDir:path];
        }
    }
    return path;
}

+ (NSString *)getAdPath
{
    static NSString *path = nil;
    if (path == nil) {
        path = [[FileUtil getBasePath] stringByAppendingPathComponent:@"ad"];
        if ([FileUtil isExistDir:path] == NO) {
            [FileUtil createDir:path];
        }
    }
    return path;
}

+ (NSString *)getFileName:(NSString *)path
{
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *name = nil;
    if (range.location == NSNotFound) {
        name = path;
    } else {
        // audio
        name = [path substringFromIndex:range.location+1];
    }
    return name;
}

+ (NSString *)getFilePart:(NSString *)name idx:(NSInteger)idx
{
    NSString *part = nil;
    NSRange range = [name rangeOfString:@"." options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        if (idx == 0) {
            part = [name substringToIndex:range.location];
        } else {
            part = [name substringFromIndex:range.location+1];
        }
    } else {
        if (idx == 0) {
            part = name;
        } else {
            part = @"";
        }
    }
    return part;

}

+ (NSString *)getFileName:(NSString *)path suffix:(NSString *)suffix
{
    NSString *name = nil;
    NSString *name2 = [FileUtil getFileName:path];
    NSRange range = [name2 rangeOfString:suffix options:NSBackwardsSearch];
    if (range.location != NSNotFound && range.location+range.length == name2.length-1) {
        name = [name2 substringToIndex:range.location];
    } else {
        name = name2;
    }
    return name;
}

+ (NSString *)getFileSuffix:(NSString *)fileName
{
    NSRange range = [fileName rangeOfString:@"."];
    if (range.location != NSNotFound) {
        return [fileName substringFromIndex:range.location];
    } else {
        return fileName;
    }
}

+ (NSString *)getBasePath
{
    static NSString *basePath = nil;
    if (basePath == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        basePath = [paths objectAtIndex:0];
    }
    return basePath;
}

+ (NSString *)getBaseFilePath:(NSString *)dir fileName:(NSString *)fileName
{
    NSString *document = [NSHomeDirectory() stringByAppendingPathComponent:dir];
    NSString *filePath = [document stringByAppendingPathComponent:fileName];
    
    return filePath;
}

+ (BOOL)isLocalFile:(NSString *)path
{
    BOOL tf = YES;
    NSRange range = [path rangeOfString:[FileUtil getBasePath]];
    if (range.location == 0 && range.length > 0) {
        tf = YES;
    } else {
        tf = NO;
    }
    return tf;
}

+ (BOOL)clearDir:(NSString *)path
{
    BOOL tf = YES;
    NSFileManager *nfm = [NSFileManager defaultManager];
	BOOL isDir;
	BOOL isExist = [nfm fileExistsAtPath:path isDirectory:&isDir];
    if (isExist == YES && isDir == YES) {
        NSArray *array = [nfm contentsOfDirectoryAtPath:path error:nil];
        for (int i=0; i<array.count; i++) {
            tf = [nfm removeItemAtPath:[NSString stringWithFormat:@"%@/%@", path, [array objectAtIndex:i]] error:nil];
        }
    }
    return tf;
}

@end
