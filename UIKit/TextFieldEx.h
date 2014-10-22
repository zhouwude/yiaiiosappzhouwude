//
//  TextFieldEx.h
//  hangcom-ui
//
//  Created by lyuan on 14-5-18.
//  Copyright (c) 2014年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFieldEx : UITextField <UITextFieldDelegate>
{
    NSString    *placeholder;
    UIColor     *placeholderColor;
}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@end
