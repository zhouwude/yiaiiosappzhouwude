//
//  topicView.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-9.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "topicView.h"
#import "QuestionModel.h"
#import "SizeFit.h"
#import "onlyView.h"
@implementation topicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIControl];
        
        
        
  
    }
    return self;
}
-(void)createUIControl{
    sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    //sc.translatesAutoresizingMaskIntoConstraints= NO;
    sc.showsHorizontalScrollIndicator = NO;
    sc.bounces = NO;
    [self addSubview:sc];
    imageView1 = [[TapImageView alloc] init];
    imageView1.parent = self;
    //imageView1.image = [UIImage imageNamed:@"1_06.jpg"];

    imageView1.translatesAutoresizingMaskIntoConstraints = NO;
    imageView1.tag = 100;
    [sc addSubview:imageView1];
    imageView2 = [[TapImageView alloc] init];
   // imageView2.image = [UIImage imageNamed:@"1_06.jpg"];
    imageView2.parent = self;

    imageView2.translatesAutoresizingMaskIntoConstraints = NO;
    imageView2.tag = 101;
    [sc addSubview:imageView2];
    imageView3 = [[TapImageView alloc] init];
    imageView3.parent = self;
   // imageView3.image = [UIImage imageNamed:@"1_06.jpg"];

    imageView3.translatesAutoresizingMaskIntoConstraints = NO;
    imageView3.tag = 102;
    [sc addSubview:imageView3];
    imageView4 = [[TapImageView alloc] init];
    //imageView4.image = [UIImage imageNamed:@"1_06.jpg"];
    imageView4.parent = self;
    imageView4.translatesAutoresizingMaskIntoConstraints = NO;
    imageView4.tag = 103;
    [sc addSubview:imageView4];
    label1 = [[UILabel alloc] init];
    label1.numberOfLines = 0;
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    label1.preferredMaxLayoutWidth = kScreenWidth - 50;
    [sc addSubview:label1];
    label2 = [[UILabel alloc] init];
    label2.numberOfLines = 0;

    label2.translatesAutoresizingMaskIntoConstraints = NO;
    label2.preferredMaxLayoutWidth = kScreenWidth - 50;
    [sc addSubview:label2];
    label3 = [[UILabel alloc] init];
    label3.numberOfLines = 0;

    label3.translatesAutoresizingMaskIntoConstraints = NO;
    label3.preferredMaxLayoutWidth = kScreenWidth - 50;
    [sc addSubview:label3];
    label4 = [[UILabel alloc] init];
    label4.numberOfLines = 0;

    label4.translatesAutoresizingMaskIntoConstraints = NO;
    label4.preferredMaxLayoutWidth = kScreenWidth - 50;
    [sc addSubview:label4];
       selectButton = [[UIButton alloc] init];
    selectButton.translatesAutoresizingMaskIntoConstraints = NO;
    [sc addSubview:selectButton];
   
    selectButton.layer.masksToBounds = YES;
    selectButton.layer.cornerRadius = 10;
    selectButton.layer.borderWidth = 2;
    selectButton.layer.borderColor = [UIColor greenColor].CGColor;
    [selectButton setTitle:@"下一题" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //_button.hidden = YES;
    [selectButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton = [[UIButton alloc] init];
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [sc addSubview:backButton];
    [backButton setTitle:@"上一题" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.layer.masksToBounds = YES;
    backButton.layer.cornerRadius = 10;
    backButton.layer.borderWidth = 2;
    backButton.layer.borderColor = [UIColor greenColor].CGColor;
    titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.preferredMaxLayoutWidth = kScreenWidth-50;
    [sc addSubview:titleLabel];
}
-(void)createSomeUI:(QuestionModel *)array count:(NSInteger)count{
    NSArray *arrayCon = [sc constraints];
    for (NSLayoutConstraint *laye in arrayCon){
        [sc removeConstraint:laye];
    }
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<array.dataArray.count; i++) {
        QuestionModel *model = array.dataArray[i];
        [self.dataArray addObject:model.CONTENT];
    }
   
//    [view1 loadData:_dataArray[0]];
//    [view2 loadData:_dataArray[1]];
//    [view3 loadData:_dataArray[2]];
//    [view4 loadData:_dataArray[3]];
    
    label1.text = _dataArray[0];
    label2.text = _dataArray[1];

    label3.text = _dataArray[2];

    label4.text = _dataArray[3];
    imageView1.image = [UIImage imageNamed:@"1_06.jpg"];
    imageView2.image = [UIImage imageNamed:@"1_06.jpg"];
    imageView3.image = [UIImage imageNamed:@"1_06.jpg"];
    imageView4.image = [UIImage imageNamed:@"1_06.jpg"];


    
    
    NSArray *array0 =  @[@"1",@"2",@"3",@"4",@"9",@"10"];
            NSArray *array1 = @[@"5",@"11"];
    
            QuestionModel *model =array;
            NSString *string = nil;
            if ([array0 containsObject:model.QUESTION_LABEL_ID]){
                string = [NSString stringWithFormat:@"%@(单选题)",model.CONTENT];
    
            }else{if ([array1 containsObject:model.QUESTION_LABEL_ID]){
            string = [NSString stringWithFormat:@"%@(多选题)",model.CONTENT];
           }
            }
    titleLabel.text = string;
    

    

    
    [self createUI:count];

}
-(void)createUI:(NSInteger)count{
  
   
    if (count==0){
        backButton.hidden = YES;
    }else{
        backButton.hidden = NO;
    }
    
    //_button.hidden = YES;
   
    if (count==_allCount-1){
        selectButton.hidden = YES;
    }else{
        selectButton.hidden = NO;
    }
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(selectButton,backButton,titleLabel,label1,label2,label3,label4,imageView1,imageView2,imageView3,imageView4);
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-[label1]-[label2]-[label3]-[label4]-[backButton(40)]-30-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-40-[titleLabel]-10-|" options:0 metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[imageView1(15)]-[label1]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[imageView2(15)]-[label2]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[imageView3(15)]-[label3]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[imageView4(15)]-[label4]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView1(15)]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView2(15)]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];

    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView3(15)]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];

    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView4(15)]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];



    
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[backButton(selectButton)]-[selectButton]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectButton(==backButton)]" options:0 metrics:nil views:views]];
    
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectButton(==backButton)]" options:0 metrics:nil views:views]];



    
        
        
        
    

    
    
        
}
-(void)buttonClick{
    if ([_parent respondsToSelector:@selector(buttonClick)]){
        [_parent performSelector:@selector(buttonClick)];
        
    }
    
    
}
-(void)backButtonClick{
    if ([_parent respondsToSelector:@selector(backButtonClick)]){
        [_parent performSelector:@selector(backButtonClick)];
        
    }
}


    
-(void)Click:(TapImageView *)view{
        
    if([_parent respondsToSelector:@selector(Click:)]){
        [_parent performSelector:@selector(Click:) withObject:view];
       
        }
    
}

   
  
    
    
    


@end
