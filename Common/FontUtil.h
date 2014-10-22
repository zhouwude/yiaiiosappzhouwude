//
//  FontUtil.h
//  mcare-core
//
//  Created by sam on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FontUtil : NSObject

+ (void)setFont:(NSString *)fontName;
+ (UIFont *)getFont:(CGFloat)size;
+ (NSString *)getFontName;
+ (void)setComFont:(UILabel *)label size:(CGFloat)size;
+ (void)setFont:(UILabel *)label size:(CGFloat)size;
+ (UIColor *)getBarFontColor;
+ (void)setBarFontColor:(UIColor *)color;
+ (CGFloat)getLabelHeight:(UILabel *)label labelFont:(CGFloat)labelFont;
+ (CGFloat)getLabelWidth:(UILabel *)label labelFont:(CGFloat)labelFont;
+ (CGFloat)infoHeight:(NSString *)info font:(CGFloat)font width:(CGFloat)width;
//
+ (void)getFontsNames;

+ (CGFloat)getTextWidth:(NSString *)txt font:(UIFont *)font;
+ (CGFloat)getTextHeight:(NSString *)txt font:(UIFont *)font width:(CGFloat)width;

@end
