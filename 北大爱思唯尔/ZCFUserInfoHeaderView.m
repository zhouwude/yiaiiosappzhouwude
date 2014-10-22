//
//  ZCFUserInfoHeaderView.m
//  LaShouUserInfo
//
//  Created by dianru on 14-7-30.
//  Copyright (c) 2014年 shixianjun. All rights reserved.
//

#import "ZCFUserInfoHeaderView.h"
#import "personalCenterModel.h"
#import "ColorUtil.h"
@implementation ZCFUserInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       NSLog(@"11111");
             //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createData:) name:NOTIFICATION object:nil];
        
    }
    return self;
}
-(void)configUI1{
    if (DEFAULT(BALANCE)){
    self.accountBalance.text = [NSString stringWithFormat:@"账户余额:%@",DEFAULT(BALANCE)];
    }
    self.shadwLabel.backgroundColor = [UIColor clearColor];
    //self.shadwLabel.layer.borderWidth = 3.0f;
    self.shadwLabel.backgroundColor = [ColorUtil getColor:@"BC8F8F" alpha:1];
    self.twoLabel.backgroundColor = [ColorUtil getColor:@"BC8F8F" alpha:1];
    self.threeLabel.backgroundColor = [ColorUtil getColor:@"BC8F8F" alpha:1];
    
    
    
    
}
-(void)configUI{
    if (DEFAULT(USERNAME)){
    self.username.text= [NSString stringWithFormat:@"用户名:%@",DEFAULT(USERNAME)];
    }
    self.coupon.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:17];
    self.shadwLabel.hidden = NO;
    self.twoLabel.hidden = YES;
    self.threeLabel.hidden = YES;
    //self.imageHeader.backgroundColor = [UIColor clearColor];
    
    
    
}
-(void)configUITest{
    self.userImage.layer.masksToBounds = YES;
   self.userImage.layer.cornerRadius = 35;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",DEFAULT(USERNAME),@"salesImageSmall.jpg"]];
    UIImage *image =[UIImage imageWithContentsOfFile:fullPathToFile];
    
    //int a= 1;
   // NSAssert(a==2, @"hehehehhehhehe");
    if (image){
        self.userImage.image = image;
    }else{
        
    }
    

    
}


#pragma mark - Action Method

- (IBAction)actionButton:(UIButton *)sender {
    if (sender.tag==3112){
        
        self.collection.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:17];
        self.coupon.font = [UIFont fontWithName:@"Heiti SC" size:13];
        self.messageLabel.font = [UIFont fontWithName:@"Heiti SC" size:13];
        [UIView animateWithDuration:0.3 animations:^{
            self.shadwLabel.hidden = YES;
            self.twoLabel.hidden = NO;
            self.threeLabel.hidden = YES;

            
        }];

        
            }
    if (sender.tag == 3111){
        
        
        self.coupon.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:17];
        self.messageLabel.font = [UIFont fontWithName:@"Heiti SC" size:13];
        self.collection.font = [UIFont fontWithName:@"Heiti SC" size:13];
        [UIView animateWithDuration:0.3 animations:^{
            self.shadwLabel.hidden = NO;
            self.twoLabel.hidden = YES;
            self.threeLabel.hidden = YES;
            
            
        }];

        
       
    }
    if (sender.tag == 3113){
        
        self.messageLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:17];
        
        self.collection.font = [UIFont fontWithName:@"Heiti SC" size:13];
        
        self.coupon.font = [UIFont fontWithName:@"Heiti SC" size:13];
        [UIView animateWithDuration:0.3 animations:^{
            self.shadwLabel.hidden = YES;
            self.twoLabel.hidden = YES;
            self.threeLabel.hidden = NO;
            
            
        }];
        

        
        
    }
        
        
    
    
    
    
    
    
     
    
    if (_buttonDelegate) {
        _buttonDelegate(sender.tag);
        
    }

}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_buttonDelegate) {
        _buttonDelegate(3333);
    }
}
@end
