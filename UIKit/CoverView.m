//
//  CoverView.m
//  mcare-ui
//
//  Created by sam on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

@synthesize parent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clickCover];
}
-(void)clickCover{
    if (parent != nil && [parent respondsToSelector:@selector(clickCover)] == YES) {
        [parent performSelector:@selector(clickCover)];
    }
}
+ (UIImageView *)createImageView:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    return imageView;
}

@end
