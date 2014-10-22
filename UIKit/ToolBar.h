//
//  ToolBar.h
//  mcarepatient
//
//  Created by sam on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolBar : UIView {
    __unsafe_unretained id parent;
    NSInteger count;
}

- (void)setButtons:(NSArray *)titles isFull:(BOOL)isFull;

+ (UIButton *)createButton:(NSString *)title target:(id)target action:(SEL)action;

@property (nonatomic, assign) id parent;

@end
