//
//  TableViewEx.m
//  aqgj
//
//  Created by sam on 11-10-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TableViewEx.h"


@implementation TableViewEx

- (id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Custom initialization
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;

}
-(void)clickTable{
    if ([[self delegate] respondsToSelector:@selector(clickTable)] == YES) {
        [[self delegate] performSelector:@selector(clickTable)];
    }

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    //
    [self clickTable];
}

@end
