//
//  UtilMethod.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-17.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "UtilMethod.h"

@implementation UtilMethod
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
      UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
   // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
// End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
    }
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
 {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",DEFAULT(USERNAME), imageName]];
    // and then we write it out
     [imageData writeToFile:fullPathToFile atomically:NO];
}
+(NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

@end
