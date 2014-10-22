//
//  ImageButton.m
//  mcare-ui
//
//  Created by sam on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageButton.h"
#import "ImageCenter.h"

@implementation ImageButton

+ (UIImage *)getSizeImage1:(CGSize)size 
{
    static UIImageView *imageView;
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithImage:[[ImageCenter getBundleImage:@"naviBar_btn_normal.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
    }
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    return imageView.image;
}

+ (UIImage *)getSizeImage2:(CGSize)size 
{
    static UIImageView *imageView;
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithImage:[[ImageCenter getBundleImage:@"naviBar_btn_normal_select.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
    }
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    return imageView.image;
}

+ (UIImage *)getSizeBackImage1:(CGSize)size 
{
    static UIImageView *imageView;
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithImage:[[ImageCenter getBundleImage:@"naviBar_back_bg.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
    }
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    return imageView.image;
}

+ (UIImage *)getSizeBackImage2:(CGSize)size 
{
    static UIImageView *imageView;
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithImage:[[ImageCenter getBundleImage:@"naviBar_back_bg_select.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
    }
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    return imageView.image;
}
+ (ImageButton *)createButton:(NSString *)name size:(CGSize)size
{
    ImageButton *button = [ImageButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button setBackgroundImage:[ImageButton getSizeImage1:size] forState:UIControlStateNormal];
    [button setBackgroundImage:[ImageButton getSizeImage2:size] forState:UIControlStateHighlighted];
    
    UILabel *label = [ImageButton createLabel:name];
    label.tag = 100;
    label.numberOfLines = 0;
    label.frame = CGRectMake(0, (size.height-20)/2, size.width, 20);
    [button addSubview:label];
    
    return button;
}

+ (ImageButton *)createButton:(NSString *)imageName
{
    UIImage *image = [ImageCenter getNamedImage:imageName];
    ImageButton *button = [ImageButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width*2, image.size.width+8);
    [button setBackgroundImage:[ImageButton getSizeImage1:button.frame.size] forState:UIControlStateNormal];
    [button setBackgroundImage:[ImageButton getSizeImage2:button.frame.size] forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];

    return button;
}

+ (ImageButton *)createBackButton:(NSString *)name
{
    ImageButton *button = [ImageButton buttonWithType:UIButtonTypeCustom];
    
    CGSize size2 = CGSizeMake(100, 20);
    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
    
    [button setBackgroundImage:[ImageButton getSizeBackImage1:CGSizeMake(size.width+20, size.height+12)] forState:UIControlStateNormal];
    [button setBackgroundImage:[ImageButton getSizeBackImage2:CGSizeMake(size.width+20, size.height+12)] forState:UIControlStateHighlighted];
    //
    UILabel *label = [ImageButton createLabel:name];
    label.tag = 100;
    label.frame = CGRectMake(10+2, 6, size.width, size.height);
    [button addSubview:label];
    
    button.frame = CGRectMake(0, 0, size.width+20, size.height+12);
    return button;
}

+ (UILabel *)createLabel:(NSString *)name
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.text = name;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)setSelectState:(BOOL)tf
{
    CGSize size = self.frame.size;
    if (tf == YES) {
        [self setBackgroundImage:[ImageButton getSizeImage2:size] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[ImageButton getSizeImage1:size] forState:UIControlStateNormal];
    }
}

- (void)setText:(NSString *)text
{
    UILabel *label = (UILabel *)[self viewWithTag:100];
    if (label != nil) {
        label.numberOfLines = 0;
        label.text = text;
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    UILabel *label = (UILabel *)[self viewWithTag:100];
    if (enabled == NO) {
        if (label != nil) {
            label.textColor = [UIColor lightGrayColor];
        }
    } else {
        if (label != nil) {
            label.textColor = [UIColor whiteColor];
        }
    }
}

@end
