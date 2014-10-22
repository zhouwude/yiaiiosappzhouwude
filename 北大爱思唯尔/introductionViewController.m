//
//  introductionViewController.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-25.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "introductionViewController.h"
#import "MovieViewController.h"
#import "SizeFit.h"
#define ADD(a)     [self.view addSubview:a]
@interface introductionViewController (){
    TapImageView *imageView;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UIScrollView *sc;
}

@end

@implementation introductionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self configUI];
    // Do any additional setup after loading the view.
}
-(void)configUI{
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view,imageView,label1,label2,label3,label4,sc);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[imageView(120)]-5-[label1]-0-|" options:0 metrics:0 views:views]];
    label1.numberOfLines = 0;
    label2.numberOfLines = 0;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView(140)]" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[imageView(120)]-5-[label2]-0-|" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView(140)]" options:0 metrics:0 views:views]];
   
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[label1]-5-[label2]" options:0 metrics:0 views:views]];




    label1.text = [NSString stringWithFormat:@"课程名称:%@",_model.dept_name];
    
    label1.textColor  = [UIColor blackColor];
    
    //NSLog(@"~~~~%@",_model.dept_name);
    label2.text = [NSString stringWithFormat:@"课程编号:%@",_model.term_number];
    SizeFit *autoSize = [SizeFit Manager];
    [autoSize JSONString:_model.effect font:15 contain:kScreenWidth-10];
    CGFloat hight1 = autoSize.size.height;
    label3.text = autoSize.returnString;
    [autoSize JSONString:_model.target font:15 contain:kScreenWidth-10];
    CGFloat hight2 = autoSize.size.height;
    NSLog(@"%f",hight1+hight2);
    //sc.contentSize = CGSizeMake(kScreenWidth-10, hight2+hight2+50);
    //sc.scrollEnabled = YES;
    
    label3.preferredMaxLayoutWidth = kScreenWidth-10;
    label4.text = autoSize.returnString;
    label4.preferredMaxLayoutWidth = kScreenWidth-10;
    
    NSLog(@"~~~%@",_model.target);
    label3.numberOfLines = 0;
    label4.numberOfLines = 0;
   //label3.frame = CGRectMake(5, 2, kScreenWidth-10, hight1 +10);
   // label4.frame = CGRectMake(5, label3.bottom+5, kScreenWidth-10, hight2 +10);
    
    
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[label3]-0-|" options:0 metrics:0 views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[label4]-0-|" options:0 metrics:0 views:views]];
    [sc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[label3]-5-[label4]-250-|" options:0 metrics:0 views:views]];
    


    
    
    
    
}
-(void)createUI{
    
    //imageView = [[TapImageView alloc] initWithFrame:CGRectMake(5, 10, 120, 140)];
    imageView = [[TapImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"logo.png"];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    ADD(imageView);
    //label1  =[[UILabel alloc] initWithFrame:CGRectMake(130,10 , kScreenWidth-110, 25)];
    label1  =[[UILabel alloc] init];
    ADD(label1);
    label1.translatesAutoresizingMaskIntoConstraints = NO;

   // label2 =[[UILabel alloc] initWithFrame:CGRectMake(130,label1.bottom+5,kScreenWidth-110, 25)];
    label2  =[[UILabel alloc] init];
    label2.translatesAutoresizingMaskIntoConstraints = NO;

    ADD(label2);
    
    label3 = [[UILabel alloc] init];
    label3.translatesAutoresizingMaskIntoConstraints = NO;
    label4 = [[UILabel alloc] init];
   label4.translatesAutoresizingMaskIntoConstraints = NO;
    sc = [[UIScrollView alloc] initWithFrame:CGRectMake(5,155,kScreenWidth-10 ,kScreenHeight-imageView.bottom+5 )];
    //sc.translatesAutoresizingMaskIntoConstraints = NO;
    sc.bounces = NO;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    ADD(sc);
    [sc addSubview:label3];
    [sc addSubview:label4];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
