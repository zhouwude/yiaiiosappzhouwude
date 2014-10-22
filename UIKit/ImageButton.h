//
//  ImageButton.h
//  mcare-ui
//
//  Created by sam on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageButton : UIButton

+ (UIImage *)getSizeImage1:(CGSize)size;
+ (UIImage *)getSizeImage2:(CGSize)size;
+ (ImageButton *)createButton:(NSString *)name size:(CGSize)size;
+ (ImageButton *)createButton:(NSString *)imageName;
+ (ImageButton *)createBackButton:(NSString *)name;
+ (UILabel *)createLabel:(NSString *)name;
- (void)setSelectState:(BOOL)tf;
- (void)setText:(NSString *)text;

@end
