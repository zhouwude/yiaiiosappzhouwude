//
//  ChoiceBox.h
//  mcarepatient
//
//  Created by mobimac on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceBox : UIButton

@property (nonatomic, retain) UIImageView   *choiceImage;
@property (nonatomic, retain) UILabel       *choiceLabel;


- (void)creatUI;

@end
