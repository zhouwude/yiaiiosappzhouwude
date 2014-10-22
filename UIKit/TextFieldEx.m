//
//  TextFieldEx.m
//  hangcom-ui
//
//  Created by lyuan on 14-5-18.
//  Copyright (c) 2014年 sam. All rights reserved.
//

#import "TextFieldEx.h"

@implementation TextFieldEx

@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self createUI];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [placeHolderLabel release]; placeHolderLabel = nil;
    [placeholderColor release]; placeholderColor = nil;
    [placeholder release]; placeholder = nil;
    [super dealloc];
#endif
    
}

- (void)createUI
{
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0) {
        return;
    }
    
    [[self viewWithTag:999] setAlpha:self.text.length == 0? 1:0];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if(self.placeholder.length > 0) {
        if(placeHolderLabel == nil) {
            CGSize size = self.frame.size;
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (size.height-20)/2, self.bounds.size.width, 20)];
            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            placeHolderLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:placeHolderLabel];
        }
        
        placeHolderLabel.text = self.placeholder;
//        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    if(self.text.length == 0 && self.placeholder.length > 0 ) {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

@end
