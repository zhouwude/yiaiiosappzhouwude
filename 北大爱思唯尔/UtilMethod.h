//
//  UtilMethod.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-17.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilMethod : NSObject
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
+(NSString *)documentFolderPath;
@end
