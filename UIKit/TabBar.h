//
//  TabBar.h
//  aqgj_dial
//
//  Created by Sam on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBar : UIView {
    UIImageView     *bgView;
    UIImageView     *selectedView;
    NSInteger       total;
    
    NSMutableArray  *imageViews;
    NSMutableArray  *labels;
    NSMutableArray  *unSelectedImages;
    NSMutableArray  *selectedImages;
    NSMutableArray  *badgeViews;
    NSInteger       lastIdx;

    BOOL            isMove;
    __unsafe_unretained id parent;
    CGFloat         startY;
    
    CGFloat         barWidth;
    CGFloat         barHeight;
}

- (id)initWithSize:(CGSize)size;

- (void)setItems:(NSArray *)titles images:(NSArray *)images selectImages:(NSArray *)selectImages origin:(NSInteger)idx;
- (void)setItems:(NSArray *)images selectImages:(NSArray *)selectImages origin:(NSInteger)idx;
- (void)moveLine:(NSInteger)from to:(NSInteger)to animated:(BOOL)animated;
- (void)changeImage:(UIImage *)image at:(NSInteger)idx;
- (void)changeTitle:(NSString *)title at:(NSInteger)idx;
- (void)changeTitleColor:(UIColor *)color at:(NSInteger)idx;
- (void)setSelectImage:(UIImage *)image;
- (void)setBadge:(NSString *)badge at:(NSInteger)idx;

@property (nonatomic, assign) id parent;

@end

