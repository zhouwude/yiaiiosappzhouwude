//
//  StatusBar.m
//  mcare-ui
//
//  Created by sam on 12-10-10.
//
//

#import "StatusBar.h"
#import "ImageCenter.h"

@implementation StatusBar

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
    self.frame = [UIApplication sharedApplication].statusBarFrame;
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = UIWindowLevelStatusBar + 1.0f;
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BAR_WIDTH, 20)];
    bgView.backgroundColor = [UIColor blackColor];
    //
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [ImageCenter getBundleImageFromName:@"status_blue.png"];
    [bgView addSubview:imageView];
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label];
    
    [self addSubview:bgView];
}

- (void)showMessage:(NSString *)message duration:(CGFloat)duration
{
    /*
    self.hidden = NO;
    self.alpha = 1.0f;
    label.text = @"";
    
    CGSize totalSize = self.frame.size;
    self.frame = (CGRect){ self.frame.origin, 0, totalSize.height };
    
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = (CGRect){ self.frame.origin, totalSize };
    } completion:^(BOOL finished){
        label.text = message;
    }];
     */
    bgView.hidden = NO;
    label.text = message;
    //
    CGSize size = CGSizeMake(280, 20);
    CGSize size2 = [message sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    if (size2.width > 280) {
        size2.width = 280;
    }
    label.frame = CGRectMake((BAR_WIDTH-size2.width)/2+15, 0, size2.width, 20);
    imageView.frame = CGRectMake((BAR_WIDTH-size2.width)/2-10, 0, 20, 20);
    if (duration > 0) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:duration];
    }
}

- (void)hide
{
    self.alpha = 1.0f;
    bgView.hidden = YES;
    /*
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished){
        label.text = @"";
        self.hidden = YES;
    }];;
     */
    
}

+ (StatusBar *)shareInstance
{
    static StatusBar *instance = nil;
    if (instance == nil) {
        instance = [[StatusBar alloc] initWithFrame:CGRectMake(0, 0, BAR_WIDTH, 20)];
        [instance makeKeyAndVisible];
    }
    return instance;
}

+ (void)showMessage:(NSString *)message duration:(CGFloat)duration
{
    [[StatusBar shareInstance] showMessage:message duration:duration];
}

+ (void)hideStatus
{
    [[StatusBar shareInstance] hide];
}

@end
