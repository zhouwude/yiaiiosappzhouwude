//
//  BadgeView.m
//  mcare-ui
//
//  Created by sam on 12-10-8.
//
//

#import "BadgeView.h"
#import "ImageCenter.h"

@implementation BadgeView

@synthesize width;
@synthesize height;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createUI];
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

- (void)createUI
{
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    //[self addSubview:imageView];

    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //[self addSubview:label];
    
    width = 20;
    height = 20;
}

- (void)layoutSubviews
{
    // do nothing
}

- (void)setBadge:(NSString *)badge
{
    CGSize size = CGSizeMake(32, 20);
    CGSize size2 = [badge sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingMiddle];
    
    imageView.image = [[ImageCenter getBundleImage:@"bg_badge.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    width = size2.width+8;
    CGFloat offsetx = 2;
    if (width < 20) {
        width = 20;
        offsetx = 1;
    }
    height = size2.height;
    if (height < 20) {
        height = 20;
    }

    CGSize size3 = self.frame.size;
    imageView.frame = CGRectMake(0, (size3.height-height)/2, width, height);
    label.frame = CGRectMake(8/4+offsetx, (size3.height-height)/2-1, width-8, height);
    label.text = badge;

    if (badge != nil) {
        if ([self.subviews containsObject:imageView] == NO) {
            [self addSubview:imageView];
        }
        if ([self.subviews containsObject:label] == NO) {
            [self addSubview:label];
        }
    } else {
        if ([self.subviews containsObject:imageView] == YES) {
            [imageView removeFromSuperview];
        }
        if ([self.subviews containsObject:label] == YES) {
            [label removeFromSuperview];
        }
    }
}

@end
