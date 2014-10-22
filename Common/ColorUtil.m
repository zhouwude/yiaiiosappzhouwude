//
//  ColorUtil.m
//  aqgj_dial
//
//  Created by Sam on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil


+ (UIColor *)getColor:(NSString *)hexColor alpha:(CGFloat)alpha
{
	unsigned int red, green, blue;
	NSRange range;
	range.length = 2;
	
	range.location = 0;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	range.location = 2; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	range.location = 4; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];	
	
	return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}

UIColor *navigationColor = nil;
+ (void)setNavigationColor:(UIColor *)color
{
    if (navigationColor != nil) {
        navigationColor = nil;
    }
    navigationColor = color;
}

+ (UIColor *)getNavigationColor
{
    return navigationColor;
}

UIColor *backgroundColor = nil;
+ (void)setBackgroundColor:(UIColor *)color
{
    if (backgroundColor != nil) {
        backgroundColor = nil;
    }
    backgroundColor = color;
}

+ (UIColor *)getBackgroundColor
{
    return backgroundColor;
}

UIImageView *imageView = nil;
+ (void)setBackgroundImageView:(UIImage *)bgImage size:(CGSize)size
{
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        imageView.userInteractionEnabled = YES;
    }
    imageView.image = bgImage;
}

+(UIImageView *)getBackgroundImageView
{
    return imageView;
}

NSInteger  colorRow = 0;
+ (NSInteger)getColorRow
{
    return colorRow;
}

+ (void)setColorRow:(NSInteger)cRow
{
    NSString   *tempRow = [NSString stringWithFormat:@"%d",cRow];
    [[NSUserDefaults standardUserDefaults] setObject:tempRow forKey:@"navigationColorRow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    colorRow = cRow;
}

@end
