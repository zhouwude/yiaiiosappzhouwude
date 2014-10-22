//
//  ZilTableViewCell.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-16.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZilTableViewCell.h"

@implementation ZilTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
////    [_Tianxie resignFirstResponder];
//    if (![_Tianxie isExclusiveTouch]) {
//        
//        [_Tianxie resignFirstResponder];
//        
//    }

    
}


-(UIToolbar *)inputAccessoryView
{
 if(!_inputAccessoryView)
    {
     UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItem target:self action:@selector(dodo)];
     UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dodo)];
     toolBar.items = [NSArray arrayWithObject:right];
     return toolBar;
         }
     return _inputAccessoryView;
 }
-(UIPickerView *)inputView
{
     if(!_inputView)
         {
               UIPickerView *  pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, 320, 200)];
                 pickView.delegate =self;
                 pickView.dataSource = self;
                 pickView.showsSelectionIndicator = YES;
                 return pickView;
             }
     return _inputView;
}
-(void)dodo
{
  //   [_Tianxie resignFirstResponder];
 }

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
     return 1;
 }

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     return [NSString stringWithFormat:@"%d",row];
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     return 5;
}




@end
