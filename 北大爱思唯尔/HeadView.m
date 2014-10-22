//
//  HeadView.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-8-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "HeadView.h"
#import "ColorUtil.h"
#import "SizeFit.h"
#import "SXJDataService.h"
@implementation HeadView
@synthesize str1;
@synthesize str2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(revice) name:@"dataChange" object:nil];
        
        label1 = [[UILabel alloc] init];
        label1.translatesAutoresizingMaskIntoConstraints = NO;
        label1.numberOfLines = 0;
        [self addSubview:label1];
        label2 = [[UILabel alloc] init];
        label2.translatesAutoresizingMaskIntoConstraints = NO;
        label2.numberOfLines = 0;
        [self addSubview:label2];
        label3 = [[UILabel alloc] init];
        label3.translatesAutoresizingMaskIntoConstraints = NO;
        label3.numberOfLines = 0;
        [self addSubview:label3];
        label4 = [[UILabel alloc] init];
        label4.translatesAutoresizingMaskIntoConstraints = NO;
        label4.numberOfLines = 0;
        [self addSubview:label4];
        label5 = [[UILabel alloc] init];
        label5.translatesAutoresizingMaskIntoConstraints = NO;
        label5.numberOfLines = 0;
        [self addSubview:label5];
        label6 = [[UILabel alloc] init];
        label6.translatesAutoresizingMaskIntoConstraints = NO;
        label6.numberOfLines = 0;
        [self addSubview:label6];
        label7 = [[UILabel alloc] init];
        label7.translatesAutoresizingMaskIntoConstraints = NO;
        label7.numberOfLines = 0;
        [self addSubview:label7];
        label8 = [[UILabel alloc] init];
        label8.translatesAutoresizingMaskIntoConstraints = NO;
        label8.numberOfLines = 0;
        [self addSubview:label8];
        [self createData];
       

        
    }
    return self;
}
-(void)createData{
    [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/getcoursetime&userid=%@",DEFAULT(USERID)] method:@"GET" params:nil completion:^(id result) {
        
        str1 = [[result objectForKey:@"UserCoursetime"] stringValue];
        //NSLog(@"~~~~%@",str1);
        str2 = [[result objectForKey:@"UserFinishCoursetime"] stringValue];
        //NSLog(@"~~~~%@",str2);
        [self createUI];
        
    } error:^(id error) {
        
    }];
    
    
}
-(void)revice{
    [self createUI];
}
-(void)createUI{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path1 = [path objectAtIndex:0];
    NSDictionary *views = NSDictionaryOfVariableBindings(label1,label2,label3,label4,label5,label6,label7,label8);
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/dataArray.plist",path1]];
    NSArray *array = @[@"用  户  名:",@"真实姓名:",@"性       别:",@"地       址:",@"身份证号:"];
    label1.text = [NSString stringWithFormat:@"%@ %@",array[0],arr[0]];
    
    label2.text = [NSString stringWithFormat:@"%@ %@",array[1],arr[1]];
    

    label3.text = [NSString stringWithFormat:@"%@ %@",array[2],arr[2]];
    

    label4.text = [NSString stringWithFormat:@"%@ %@",array[3],arr[3]];
    

    label5.text = [NSString stringWithFormat:@"%@ %@",array[4],arr[4]];
    //label6.text = [NSString stringWithFormat:@"%@%@",array[5],arr[5]];
    
    label6.text = @"已完成口腔种植课程:";
    label6.font = [UIFont systemFontOfSize:18];
    
    NSString *str3 = [NSString stringWithFormat:@"%@  %@",@"购买课程的总学时:",str1];
    NSRange range1 = [str3 rangeOfString:@"购买课程的总学时"];
    label7.attributedText = [self judgeTextHight:str3 font:0 range:range1];
    NSString *str4 = [NSString stringWithFormat:@"%@  %@",@"完成学时:",str2];
    NSRange range2 = [str4 rangeOfString:@"完成学时"];
    label8.attributedText = [self judgeTextHight:str4 font:0 range:range2];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label1]-10-|" options:0 metrics:0 views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label2]-10-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label3]-10-|" options:0 metrics:0 views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label4]-10-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label5]-10-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label6]-10-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-50-[label7]-10-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-50-[label8]-10-|" options:0 metrics:0 views:views]];

    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[label6]-10-|" options:0 metrics:0 views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label1]-5-[label2]-5-[label3]-5-[label4]-5-[label5]-20-[label6]-10-[label7]-10-[label8]" options:0 metrics:0 views:views]];

    
    
}
-(NSMutableAttributedString *)judgeTextHight:(NSString *)str font:(CGFloat)font range:(NSRange)range{
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
    // NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle1.firstLineHeadIndent = 80;
    
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[ColorUtil getColor:@"B3EE3A" alpha:1] range:range];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
    
    
    
    
    
    
    
    return attributedString1;
}

@end
