//
//  TitleCell.m
//  mcarepatient
//
//  Created by sam on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TitleCell.h"
#import "ColorUtil.h"
#import "ImageCenter.h"

@implementation TitleCell

@synthesize parent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        height = 44;
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bgView.backgroundColor = [UIColor clearColor];
        //[self addSubview:bgView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIcon:(UIImage *)icon
{
    if (imageview == nil) {
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, (height-30)/2, 30, 30)];
        [self addSubview:imageview];
    }
    if (icon != nil) {
        offsetx = 40;
    } else {
        offsetx = 0;
    }
    imageview.image = icon;
}

- (void)setName:(NSString *)n
{
    if (name == nil) {
        name = [[UILabel alloc] initWithFrame:CGRectMake(20+offsetx, (height-20)/2, 260+offsetx2, 20)];
        name.font = [UIFont fontWithName:@"Arial" size:16];
        name.backgroundColor = [UIColor clearColor];
        [self addSubview:name];
    }
    name.text = n;
}

- (void)setDesc:(NSString *)d isHolder:(BOOL)tf
{
    [self showSubView:on show:NO];
    //
    if (desc == nil) {
        desc = [[UILabel alloc] initWithFrame:CGRectZero];
        desc.font = [UIFont fontWithName:@"Arial" size:18];
        desc.backgroundColor = [UIColor clearColor];
        desc.textAlignment = UITextAlignmentRight;
    }
    CGFloat offset = 0;
    if (self.accessoryType != UITableViewCellAccessoryNone) {
        offset = 20;
    }
    
    desc.frame = CGRectMake(offsetx/2+offsetx2, (height-20)/2, 320-offset-offsetx/2-10, 20);
    
    [self showSubView:desc show:YES];
    if (d == nil || (NSObject *)d == [NSNull null]) {
        desc.text = @"";
    } else {
        desc.text = d;
    }
    if (tf == YES) {
        desc.textColor = [UIColor lightGrayColor];
    } else {
        desc.textColor = [UIColor darkGrayColor];
    }
}

- (void)setCheck:(BOOL)tf
{
    [self showSubView:desc show:NO];
    [self showSubView:selectview show:NO];
    //
    if (on == nil) {
        CGFloat lengthOffset = 0;
        NSInteger ver = [[[UIDevice currentDevice] systemVersion] intValue];
        if (ver >= 5) {
            lengthOffset = 10;
        }
        on = [[UISwitch alloc] initWithFrame:CGRectMake(210+lengthOffset, 9, 80-lengthOffset, 30)];
        [on addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    }
    [self showSubView:on show:YES];
    //
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    on.on = tf;
}

- (BOOL)isCheck
{
    return on.on;
}

- (void)setIndex:(NSInteger)idx
{
    index = idx;
}

- (void)changeValue
{
    BOOL tf = on.on;
    
    [self changeValue:[NSNumber numberWithBool:tf] index:[NSNumber numberWithInt:index]];
}
-(void)changeValue:(NSNumber *)num index:(NSNumber *)num1{
    
    if (parent != nil && [parent respondsToSelector:@selector(changeValue:index:)] == YES) {
        [parent performSelector:@selector(changeValue:index:) withObject:num withObject:num1];
    }
}

- (void)setColorImage:(BOOL)tf
{
    [self showSubView:on show:NO];
    //
    if (selectview == nil) {
        CGFloat offset = 0;
        offsetx2 = -20;
        if (self.accessoryType != UITableViewCellAccessoryNone) {
            offset = 20;
        }
        selectview = [[UIImageView alloc] initWithFrame:CGRectMake(320-offset-35, 12, 20, 20)];
        [self addSubview:selectview];
    }
    [self showSubView:selectview show:YES];
    if (tf == YES) {
        [selectview setImage:[ImageCenter getBundleImage:@"mark_select.png"]];
    } else {
        [selectview setImage:nil];
    }
}

- (void)showSubView:(UIView *)subview show:(BOOL)tf
{
    if ([self.subviews containsObject:subview] != tf) {
        if (tf == YES) {
            [self addSubview:subview];
        } else {
            [subview removeFromSuperview];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    bgView.backgroundColor = [ColorUtil getColor:@"006CFF" alpha:0.75];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self performSelector:@selector(clickChange) withObject:self afterDelay:0.2];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    bgView.backgroundColor = [UIColor clearColor];
}

- (void)clickChange
{
    bgView.backgroundColor = [UIColor clearColor];
}

- (void)dealloc
{
    
}

//- (void)layoutSubviews
//{
//    CGSize size = self.frame.size;
//    bgView.frame = CGRectMake(0, 0, size.width, size.height);
//    imageview.frame = CGRectMake(0, 0, imageview.frame.size.width, imageview.frame.size.height);
//    name.frame = CGRectMake(30, (size.height-name.frame.size.height)/2, name.frame.size.width, name.frame.size.height);
//    desc.frame = CGRectMake(size.width-desc.frame.size.width-60, (size.height-desc.frame.size.height)/2, desc.frame.size.width, desc.frame.size.height);
//    desc.backgroundColor = [UIColor lightGrayColor];
//    name.backgroundColor = [UIColor lightGrayColor];
//}

@end
