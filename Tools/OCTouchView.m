//
//  OCTouchView.m
//  testTouchView
//
//  Created by Blue on 14/7/29.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "OCTouchView.h"

@implementation OCTouchView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
       // [self createUI];
        
    }
    return self;
}
-(void)createUI{
    UIView *view = [[UIView alloc] init];
    view.alpha = 1;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-50-[view]-50-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[view]-150-|" options:0 metrics:nil views:views]];
    UIButton *button1 = [[UIButton alloc] init];
    UIButton *button2 = [[UIButton alloc] init];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 setTitle:@"重相册中选择" forState:UIControlStateNormal];
    [view addSubview:button1];
    [view addSubview:button2];
    [button2 setTitle:@"相机" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSDictionary *views1 = NSDictionaryOfVariableBindings(button1,button2);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[button1(40)]-[button2]" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:views1]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-50-[button1]-50-|" options:0 metrics:nil views:views1]];

    
    

    //[button1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    //[button2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];


    

    
    
    
}

    
    


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateBegan);
    else
        [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateMoved);
    else
        [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateEnded);
    else
        [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateCancelled);
    else
        [super touchesCancelled:touches withEvent:event];
}

@end


@implementation OCDrawView
//
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.drawBlock)
        self.drawBlock(context, rect);
}




@end
