//
//  CollectViewController.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-20.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "CollectViewController.h"
#import "DetailModel.h"
#import "collectModel.h"
#import "collectMetod.h"
@interface CollectViewController (){
    
    UIButton * _deleteButton;
    NSIndexPath * _editingIndexPath;
    
    UISwipeGestureRecognizer * _leftGestureRecognizer;
    UISwipeGestureRecognizer * _rightGestureRecognizer;
    UITapGestureRecognizer * _tapGestureRecognizer;

}
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"收藏的课程";
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self createTableView];
    // Do any additional setup after loading the view.
}
-(void)loadData{
    NSMutableArray *array= [collectMetod synFindData];
    for (collectModel *data in array){
        [self.dataArray addObject:data];
       
        
        
    }
    if(self.dataArray.count == 0){
        UIAlertView *ALview = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"暂时还没有收藏的课程" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [ALview show];
        //[self.navigationController popViewControllerAnimated:YES];
        
        
    }
   
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
       [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)createTableView{
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight-kTabBarHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    
    
    
    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"不想要了";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"医爱LOGO.png"];
    collectModel *model  = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.fullName;
    cell.detailTextLabel.text = model.speaker;
    cell.accessoryView = [self createView];
    
    return cell;
}
-(UIView *)createView{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 44, 20)];
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"HH:mm"];
    NSString *date=[nsdf2 stringFromDate:[NSDate date]];
    
    label.text = date;
    [view addSubview:label];
    
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        if (indexPath.row<[self.dataArray count]) {
            //[_dataArray removeObjectAtIndex:indexPath.row];//移除数据源的数据
            
           // [useDB deleteUserWithId:[NSString stringWithFormat:@"%d",self.dataArray.count-indexPath.row]];
            [collectMetod update:@"DELETE" data:nil row:indexPath.row];
            [AppDelegate showStatusWithText:@"该课程你已经从收藏中删除" duration:2];
            [self.dataArray removeObjectAtIndex:indexPath.row];
            //[_tableView reloadData];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:arc4random()%7];//移除tableView中的数据
            
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
