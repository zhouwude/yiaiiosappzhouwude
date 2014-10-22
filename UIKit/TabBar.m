//
//  TabBar.m
//  aqgj_dial
//
//  Created by Sam on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabBar.h"
#import "ColorUtil.h"
#import "BadgeView.h"
#import "ImageCenter.h"

@implementation TabBar

@synthesize parent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        barWidth = 320;
        barHeight = 54;
        [self createUI];
    }
    return self;
}

- (id)initWithSize:(CGSize)size
{
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        // Initialization code
        barWidth = size.width;
        barHeight = size.height;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    /*
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPressGesture];
     */
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, barWidth, barHeight)];
    bgView.contentMode = UIViewContentModeScaleToFill;
    bgView.userInteractionEnabled = NO;
    //bgView.alpha = 0.6;
    //bgView.backgroundColor = [ColorUtil getColor:@"0099CC" alpha:1];
    bgView.image = [ImageCenter getBundleImage:@"tab_bar_bg.png"];
    [self addSubview:bgView];
    
    selectedView = [[UIImageView alloc] initWithFrame:CGRectZero];
    //[self addSubview:selectedView];
    
    imageViews = [[NSMutableArray alloc] init];
    labels = [[NSMutableArray alloc] init];
    unSelectedImages = [[NSMutableArray alloc] init];
    selectedImages = [[NSMutableArray alloc] init];
    badgeViews = [[NSMutableArray alloc] init];
}

- (void)setSelectImage:(UIImage *)image
{
    selectedView.image = image;
}

- (void)setItems:(NSArray *)titles images:(NSArray *)images selectImages:(NSArray *)selectImages origin:(NSInteger)idx
{
    CGSize size = CGSizeMake(barWidth, barHeight);
    total = titles.count;
    //
    [unSelectedImages removeAllObjects];
    [unSelectedImages addObjectsFromArray:images];
    //
    [selectedImages removeAllObjects];
    [selectedImages addObjectsFromArray:selectImages];
    //
    [badgeViews removeAllObjects];
    //
    CGFloat step = size.width/total;
    for (int i=0; i<titles.count; i++) {
        NSString *title = [titles objectAtIndex:i];
        if (title.length > 0) {
            CGFloat height = barHeight-14;
            UIImageView *uiv = [[UIImageView alloc] initWithFrame:CGRectZero];
            uiv.frame = CGRectMake(step*i+(step-height)/2, 0, height, height);
            uiv.image = [ImageCenter getBundleImage:[images objectAtIndex:i]];
            [self addSubview:uiv];
            [imageViews addObject:uiv];
            
            UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectZero];
            separator.frame = CGRectMake(step*i+(step-2), 0, 2, size.height);
            separator.image = [ImageCenter getBundleImage:@"tab_bar_separator.png"];
            if(i < titles.count-1) {
                [self addSubview:separator];
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.frame = CGRectMake(step*i, height, step, 14);
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor lightGrayColor];
            label.text = [titles objectAtIndex:i];
            label.font = [UIFont fontWithName:@"Arial" size:11];
            [self addSubview:label];
            [labels addObject:label];

            BadgeView *bv = [[BadgeView alloc] initWithFrame:CGRectZero];
            bv.frame = CGRectMake(step*i+(step+height)/2, 3, 20, 20);
            [badgeViews addObject:bv];
            [self addSubview:bv];
        } else {
            CGFloat height = barHeight;
            UIImageView *uiv = [[UIImageView alloc] initWithFrame:CGRectZero];
            uiv.frame = CGRectMake(step*i+(step-height)/2, 0, height, height);
            uiv.image = [ImageCenter getBundleImage:[images objectAtIndex:i]];
            [self addSubview:uiv];
            [imageViews addObject:uiv];

            BadgeView *bv = [[BadgeView alloc] initWithFrame:CGRectZero];
            bv.frame = CGRectMake(step*i+(step+height)/2, 3, 20, 20);
            [badgeViews addObject:bv];
            [self addSubview:bv];
        }
    }
    UIImageView *uiv = [imageViews objectAtIndex:idx];
    uiv.image = [ImageCenter getBundleImage:[selectedImages objectAtIndex:idx]];
    [self changeTitleColor:[UIColor whiteColor] at:idx];
    lastIdx = idx;
}

- (void)setItems:(NSArray *)images selectImages:(NSArray *)selectImages origin:(NSInteger)idx
{
    CGSize size = CGSizeMake(barWidth, barHeight);
    total = images.count;
    //
    [unSelectedImages removeAllObjects];
    [unSelectedImages addObjectsFromArray:images];
    //
    [selectedImages removeAllObjects];
    [selectedImages addObjectsFromArray:selectImages];
    //
    CGFloat step = size.width/total;
    for (int i=0; i<total; i++) {
        CGFloat height = barHeight;
        UIImageView *uiv = [[UIImageView alloc] initWithFrame:CGRectZero];
        uiv.frame = CGRectMake(step*i, 1, step, height-2);
        uiv.image = [ImageCenter getBundleImage:[images objectAtIndex:i]];
        [self addSubview:uiv];
        [imageViews addObject:uiv];
    }
    UIImageView *uiv = [imageViews objectAtIndex:idx];
    uiv.image = [ImageCenter getBundleImage:[selectedImages objectAtIndex:idx]];
    [self changeTitleColor:[UIColor whiteColor] at:idx];
    lastIdx = idx;
}

- (void)moveLine:(NSInteger)from to:(NSInteger)to animated:(BOOL)animated
{
    CGSize size = self.frame.size;
    if (from != to && from < total && from >=0 && to < total && to >= 0) {
        if (animated == YES) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            CGFloat step = size.width/total;
            selectedView.center = CGPointMake(step*to+step/2, selectedView.center.y);
            [UIView commitAnimations];
        } else {
            CGFloat step = size.width/total;
            selectedView.center = CGPointMake(step*to+step/2, selectedView.center.y);
        }
        UIImageView *old = [imageViews objectAtIndex:from];
        old.alpha = 0.5;
        UIImageView *new = [imageViews objectAtIndex:to];
        new.alpha = 1;
    }
}

- (void)changeImage:(UIImage *)image at:(NSInteger)idx
{
    if (idx >=0 && idx < imageViews.count) {
        UIImageView *uiv = [imageViews objectAtIndex:idx];
        uiv.image = image;
    }
}

- (void)changeTitle:(NSString *)title at:(NSInteger)idx
{
    if (idx >=0 && idx < labels.count) {
        UILabel *label = [labels objectAtIndex:idx];
        label.text = title;
    }
}

- (void)changeTitleColor:(UIColor *)color at:(NSInteger)idx
{
    if(idx >= 0 && idx < labels.count) {
        UILabel *lab = [labels objectAtIndex:idx];
        lab.textColor = color;
    }
}

- (void)clickTab:(NSInteger)idx
{
    if (lastIdx != idx) {
        if (lastIdx >=0 && lastIdx < unSelectedImages.count) {
            [self changeImage:[ImageCenter getBundleImage:[unSelectedImages objectAtIndex:lastIdx]] at:lastIdx];
            [self changeTitleColor:[ColorUtil getColor:@"BCBCBC" alpha:1] at:lastIdx];
        }
        if (idx >= 0 && idx < selectedImages.count) {
            [self changeImage:[ImageCenter getBundleImage:[selectedImages objectAtIndex:idx]] at:idx];
            [self changeTitleColor:[UIColor whiteColor] at:idx];
        }
        lastIdx = idx;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    startY = point.y;
    //
    isMove = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isMove == NO) {
        isMove = YES;
    }
}
-(void)longPressTab{
    if (parent != nil && [parent respondsToSelector:@selector(longPressTab)] == YES) {
        [parent performSelector:@selector(longPressTab) withObject:nil];
    }
    
}
-(void)selectTab:(NSNumber *)number{
    if (parent != nil && [parent respondsToSelector:@selector(selectTab:)] == YES) {
        [parent performSelector:@selector(selectTab:) withObject:number];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    if (isMove == YES) {
        if (startY - point.y > 8) {
            [self longPressTab];
        }
    } else {
        CGSize size = self.frame.size;
        CGFloat step = size.width/total;
        NSInteger idx = point.x/step;
        [self selectTab:[NSNumber numberWithInt:idx]];
        [self clickTab:idx];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer {
	if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        if (parent != nil && [parent respondsToSelector:@selector(longPressTab)] == YES) {
            [parent performSelector:@selector(longPressTab) withObject:nil];
        }
    }
}

- (void)setBadge:(NSString *)badge at:(NSInteger)idx
{
    if (idx >=0 && idx < badgeViews.count) {
        BadgeView *bv = (BadgeView *)[badgeViews objectAtIndex:idx];
        [bv setBadge:badge];
    }
}

@end
