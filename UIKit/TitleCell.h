//
//  TitleCell.h
//  mcarepatient
//
//  Created by sam on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCell.h"

@interface TitleCell : MCell {
    UIImageView *imageview;
    UILabel *name;
    UILabel *desc;
    UISwitch *on;
    UIImageView *selectview;
    UIView *bgView;
    CGFloat offsetx;
    CGFloat offsetx2;
    NSInteger index;
}

- (void)setIcon:(UIImage *)icon;
- (void)setName:(NSString *)n;
- (void)setDesc:(NSString *)d isHolder:(BOOL)tf;
- (void)setIndex:(NSInteger)idx;
- (void)setCheck:(BOOL)tf;
- (BOOL)isCheck;
- (void)setColorImage:(BOOL)tf;

@property (nonatomic, assign) id parent;

@end
