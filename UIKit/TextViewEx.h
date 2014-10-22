//
//  TextViewEx.h
//  mcare-uihd
//
//  Created by lyuan on 13-2-21.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewEx : UITextView
{
    NSString    *placeholder;
    UIColor     *placeholderColor;
}

- (void)textChanged:(NSNotification *)notification;

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@end
