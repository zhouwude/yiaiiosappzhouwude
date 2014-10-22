//
//  contentView.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-10.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "contentView.h"
#import "RemoteModel.h"
#import "ListViewController.h"
@implementation contentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView:) name:ACTION object:nil];
        [self createSC];
        label1  = [[UILabel alloc] init];
        label1.preferredMaxLayoutWidth = kScreenWidth-10;
        label1.translatesAutoresizingMaskIntoConstraints = NO;
        label2  = [[UILabel alloc] init];
        label2.preferredMaxLayoutWidth = kScreenWidth-10;

        label2.translatesAutoresizingMaskIntoConstraints = NO;
        
        label3  = [[UILabel alloc] init];
        label3.translatesAutoresizingMaskIntoConstraints = NO;
        label3.preferredMaxLayoutWidth = kScreenWidth-10;

        label3.numberOfLines = 0;
        label4  = [[UILabel alloc] init];
        label4.translatesAutoresizingMaskIntoConstraints = NO;
        label4.preferredMaxLayoutWidth = kScreenWidth-10;

        label4.numberOfLines = 0;
        [self createUI];
    }
    return self;
}
-(void)changeView:(NSNotification *)info{
    
    NSInteger num = [[info object] integerValue];
    
    if (selected != num){
        selected = num;
        CGPoint point = sc.contentOffset;
        point.x = selected*320;
        sc.contentOffset = point;
        
        
        
        
    }
    NSLog(@"%d",num);
    
    
}
-(void)createSC{
    
    sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    sc.bounces = NO;
    sc.pagingEnabled =YES;
    sc.contentSize = CGSizeMake(kScreenWidth*3, self.height);
    sc.delegate = self;
    [self addSubview:sc];
    //sc.backgroundColor = [UIColor redColor];
    //[self createUI];
    
    
    
}
-(void)createUI{
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, self.height) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    
    [sc addSubview:_tabelView];
    secendSC  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , self.height)];
    secendSC.showsHorizontalScrollIndicator = NO;
    secendSC.bounces = NO;
    [sc addSubview:secendSC];
    [secendSC addSubview:label1];
    [secendSC addSubview:label2];
    [secendSC addSubview:label3];
    threeSc = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.height)];
    threeSc.showsHorizontalScrollIndicator = NO;
    threeSc.bounces = NO;
    [sc addSubview:threeSc];
    [threeSc addSubview:label4];

    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == sc){
    CGPoint point = scrollView.contentOffset;
    
   [[NSNotificationCenter defaultCenter] postNotificationName:ACTION object:[NSString stringWithFormat:@"%f",point.x/320]];
    }
    
    
}

-(void)configUI:(DetailModel *)model array:(NSArray *)array contactData:(NSString *)courseData{
    
    if(courseData.length>0&&courseData){
    
    NSString *label1Text = [NSString stringWithFormat:@"%@%@",@"类型:",courseData];
    NSRange range1 = [label1Text rangeOfString:@"类型:"];
       label1.attributedText =[self judgeTextHight:label1Text font:0 range:range1];
    }else{
        NSString *label1Text = [NSString stringWithFormat:@"%@%@",@"类型:",@"暂时还没有数据"];
        NSRange range1 = [label1Text rangeOfString:@"类型:"];
        label1.attributedText =[self judgeTextHight:label1Text font:0 range:range1];
        
    }
    
    
    NSString *label2Text = [NSString stringWithFormat:@"%@%@",@"学时:",@""];
    NSRange range2 = [label2Text rangeOfString:@"学时:"];

    label2.attributedText =[self judgeTextHight:label2Text font:0 range:range2];

    NSString *str = [self JSONString:model.summary];
     if(model.summary&&model.summary.length>0){
    NSString *label3Text = [NSString stringWithFormat:@"%@%@",@"内容介绍:",str];
    NSRange range3 = [label3Text rangeOfString:@"内容介绍:"];
    label3.attributedText =[self judgeTextHight:label3Text font:0 range:range3];

    NSLog(@"%@",NSStringFromRange(range3));
     }else{
         NSString *label3Text = [NSString stringWithFormat:@"%@%@",@"内容介绍:",@"暂时没有课程的相关介绍"];
         NSRange range3 = [label3Text rangeOfString:@"内容介绍:"];
         label3.attributedText =[self judgeTextHight:label3Text font:0 range:range3];
         
     }
    NSDictionary *views = NSDictionaryOfVariableBindings(label1,label2,label3,label4);
    [secendSC addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[label1]-5-|" options:0 metrics:0 views:views]];
    [secendSC addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[label2]-5-|" options:0 metrics:0 views:views]];
    
    [secendSC addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[label3]-5-|" options:0 metrics:0 views:views]];
    [secendSC addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label1]-10-[label2]-10-[label3]-10-|" options:0 metrics:0 views:views]];
    
    
    if (model.authordescription&&model.authordescription.length>0){

    NSString *label4Text = [self JSONString:model.authordescription];
    
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label4Text];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.firstLineHeadIndent = 40;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [attributedString length])];
    label4.attributedText = attributedString;
    [threeSc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label4]-20-|" options:0 metrics:0 views:views]];
    [threeSc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[label4]-5-|" options:0 metrics:0 views:views]];
    }else{
        label4.text = @"暂时没有专家的相关介绍";
    }


    
    
    
    
    
    
    
    
    
}
-(NSMutableAttributedString *)judgeTextHight:(NSString *)str font:(CGFloat)font range:(NSRange)range{
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
   // NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle1.firstLineHeadIndent = 80;
    
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[ColorUtil getColor:@"B3EE3A" alpha:1] range:range];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];


   
    
   

    
    return attributedString1;
}

-(NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    //[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"。。" withString:@"。" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
        
    }
    RemoteModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.fullname;
    
    return cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(void)loadData:(RemoteModel *)model{
    [self.parent performSelector:@selector(loadData:) withObject:model];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RemoteModel *model = [_dataArray objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:ACTION object:[NSString stringWithFormat:@"%d",0]];
    [self loadData:model];
    
    
}
@end
