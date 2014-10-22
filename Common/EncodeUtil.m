//
//  EncodeUtil.m
//  mcare-core
//
//  Created by sam on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EncodeUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation EncodeUtil

/*32位小写*/
+ (NSString *)getMD5ForStr:(NSString *)str
{
    const char *ptr = [str UTF8String];
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) 
        [output appendFormat:@"%02x",md5Buffer[i]];
    return output;
}

//md5 32位 加密 （小写）
+ (NSString *)md5_32:(NSString *)str
{
    return [EncodeUtil md5:str lowercase:YES];
}

//md5 32位 加密 （大写）
+ (NSString *)MD5_32:(NSString *)str
{
    return [EncodeUtil md5:str lowercase:NO];
}

//md5 16位加密 （小写）
+ (NSString *)md5_16:(NSString *)str
{
    return [[EncodeUtil md5_32:str] substringWithRange:NSMakeRange(8, 16)];
}

//md5 16位加密 （大写）
+ (NSString *)MD5_16:(NSString *)str
{
    return [[EncodeUtil MD5_32:str] substringWithRange:NSMakeRange(8, 16)];
}

+ (NSString *)md5:(NSString *)str lowercase:(BOOL)lowercase
{
    const char *ptr = [str UTF8String];
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    NSString *format = lowercase? @"%02x":@"%02X";
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:format, md5Buffer[i]];
    return output;
}

+ (NSString *)md5_num:(NSString *)str
{
    const char *ptr = [str UTF8String];
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:sizeof(md5Buffer)*4];
    for(int i = 0; i < 4; i++)
        [output appendFormat:@"%03d", md5Buffer[i]];
    [output appendFormat:@"%04d", md5Buffer[4]];
    
    return output;
}

+ (NSString *)generateUUID
{
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *guid = (__bridge NSString *)newUniqueIDString;
    
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    guid = [[guid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return guid;
}

+ (UIImage *)convertImage:(UIImage *)origImage scope:(CGFloat)scope
{
    UIImage *image = nil;
    CGSize size = origImage.size;
    if (size.width <= scope && size.height <= scope) {
        // do nothing
        image = origImage;
    } else {
        CGFloat length = size.width;
        if (size.width < size.height) {
            length = size.height;
        }
        CGFloat f = scope/length;
        CGSize newSize = CGSizeMake(size.width*f, size.height*f);
        //
        UIGraphicsBeginImageContext(newSize);
        // Tell the old image to draw in this new context, with the desired
        // new size 
        [origImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)]; 
        // Get the new image from the context 
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext(); 
    }
    return image;
}

+ (UIImage *)tailorImage:(UIImage *)origImage scope:(CGFloat)scope
{
    CGSize size = origImage.size;
    if (size.width < scope && size.height < scope) {
        return origImage;
    } else {
        @autoreleasepool {
            CGFloat min = MIN(origImage.size.width, origImage.size.height);
            CGFloat f = scope/min;
            CGSize scaleSize = CGSizeMake(origImage.size.width*f, origImage.size.height*f);//等比例尺寸
            CGRect rect = CGRectMake((scaleSize.width-scope)/2, (scaleSize.height-scope)/2, scope, scope);//等宽高rect
            //
            UIGraphicsBeginImageContext(scaleSize);
            [origImage drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
            
            UIGraphicsBeginImageContext(rect.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextDrawImage(context, CGRectMake(0, 0, scope, scope), subImageRef);
            UIImage *image = [UIImage imageWithCGImage:subImageRef];
            UIGraphicsEndImageContext();
            CGImageRelease(subImageRef);
            
            return image;
        }
    }
}

+ (NSString *)formatPhone:(NSString *)phone
{
    NSMutableString *aNumber = [NSMutableString string];
    [aNumber appendFormat:@"%@", phone];
    if (phone == nil) {
        aNumber = nil;
    } else if ([phone rangeOfString:@"0"].location == 0) {
        [aNumber replaceOccurrencesOfString:@"(" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [aNumber length])];
        [aNumber replaceOccurrencesOfString:@")" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [aNumber length])];
        [aNumber replaceOccurrencesOfString:@"+" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [aNumber length])];
        [aNumber replaceOccurrencesOfString:@"-" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [aNumber length])];
        if ([aNumber rangeOfString:@"86"].location == 0) {
            [aNumber deleteCharactersInRange:NSMakeRange(0, 2)];
        }
    
        BOOL isFormated = NO;
        NSArray *list = [NSArray arrayWithObjects:@"010", @"020", @"021", @"022", @"023", @"024", @"025", @"027", @"028", @"029", @"852", @"853", nil];
        for (int i=0; i<list.count; i++) {
            NSString *num = [list objectAtIndex:i];
            if ([aNumber rangeOfString:num].location == 0) {
                [aNumber insertString:@"-" atIndex:num.length];
                isFormated = YES;
                break;
            }
        }
        
        if (isFormated == NO) {
            [aNumber insertString:@"-" atIndex:4];
        }
    }

    return aNumber;
}

+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}

@end
