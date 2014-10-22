//
//  MessageCell.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-3.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell<UITextFieldDelegate>{
    
    UIButton *button;
    UILabel *messageLabel;
    
    UITextField *labelMessage;
}
@property(nonatomic,strong)NSMutableArray *dataArray;

-(void)conFig:(NSString *)str;
@end
