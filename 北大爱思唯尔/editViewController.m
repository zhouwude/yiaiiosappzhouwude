//
//  editViewController.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-11.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "editViewController.h"
#import "beginEditViewController.h"
#import "JSONKit.h"
#import "SXJDataService.h"
#import "AppDelegate.h"
@interface editViewController (){
    UITableView *_tableView;
    NSArray * MessageArray;
    UIAlertView *alert;
    UIAlertView *alert1;
    UIActionSheet *sheet;
    NSMutableDictionary *dict;
    NSArray *array;
}
@property(nonatomic,strong)NSMutableDictionary *tempDic;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation editViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tempDic = [[NSMutableDictionary alloc] init];
    array = @[@"user_name",@"true_name",@"gender",@"address",@"cardno"];
    [self createTableView];
    [self loadData];
    [self createNai];
    
    
    
}
-(void)createNai{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = leftButton;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 80, 30);
    [button1 setTitle:@"取消" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = leftButton1;
    [button1 addTarget:self action:@selector(leftbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)createUserMessage{
    if ([_parent respondsToSelector:@selector(createUserMessage)]){
        [_parent performSelector:@selector(createUserMessage)];
    }
    
    
}
-(void)buttonClick{
    if(_tempDic.count==0){
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请做相应的修改后再保存。。。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [view show];
        return;
    }
    
    NSString *str = [_tempDic JSONString];
    str = [NSString stringWithString:str];
    NSLog(@"%@",str);
    
    [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/updateuserinfo&uid=%@&content=%@",DEFAULT(USERID),str] method:@"GET" params:nil completion:^(id result) {
        NSLog(@"!!!!!!!2222%@",result);
        if ([[result objectForKey:@"code"] isEqualToString:@"1"]){
            
            
            
            [AppDelegate showStatusWithText:@"更新成功....." duration:2];
            
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path1 = [path objectAtIndex:0];
        [_dataArray writeToFile:[path1 stringByAppendingString:@"/dataArray.plist"] atomically:YES];
        [dict writeToFile:[path1 stringByAppendingString:@"/dataDict.plist"] atomically:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataChange" object:nil];
        [self createUserMessage];
        [self.navigationController popViewControllerAnimated:YES];
        self.tempDic = [[NSMutableDictionary alloc] init];
        }else{
            alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"资料修改失败，请重新修改!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alert1.delegate = self;
            [alert1 show];
            self.tempDic = [[NSMutableDictionary alloc] init];
            
            
        }
     
    } error:^(id error) {
        
    }];
    
   // [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
}
-(void)leftbuttonClick{
    alert = [[UIAlertView alloc] initWithTitle:nil message:@"放弃对资料的修改？" delegate:self cancelButtonTitle:@"继续编辑" otherButtonTitles:@"放弃", nil];
    alert.delegate = self;
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alert == alertView){
        if (buttonIndex==0){
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
        
    }
    if (alertView == alert1){
        [self loadData];
    }
}
-(void)loadData{
    
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path1 = [path objectAtIndex:0];
    
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/dataArray.plist",path1]];
    dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/dataDict.plist",path1]];
    //NSLog(@"%@",dict);
    self.dataArray = [[NSMutableArray alloc] initWithArray:arr];
    
    MessageArray = @[@"用  户  名:",@"真实姓名:",@"性       别:",@"地       址:",@"身份证号:"];
    [_tableView reloadData];
    
    
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.dataArray.count;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section ==0){
    return @"基本信息";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0){
        return 20;
        
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==2){
        sheet = [[UIActionSheet alloc] initWithTitle:@"性别修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"女",@"男", nil];
        
        [sheet showInView:self.view];
        return;
        
    }
    if (indexPath.row==0){
        
    }else{
    NSString *str = [_dataArray objectAtIndex:indexPath.row];
    beginEditViewController *vc = [[beginEditViewController alloc] init];
    vc.parent = self;
    vc.message = str;
    NSString *string = [[MessageArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""];
    vc.rowNum = indexPath.row;
    vc.title = [string stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"~~~~~~~~~%d",buttonIndex);
    if (buttonIndex==0){
        [_dataArray replaceObjectAtIndex:2 withObject:@"女"];
        NSString *string = [dict objectForKey:array[2]];
        if (![@"女" isEqualToString:string]){
            [_tempDic setValue:@"113" forKey:array[2]];
            
            [dict setValue:@"女" forKey:array[2]];
        }

        
        [_tableView reloadData];
    }else{
        [_dataArray replaceObjectAtIndex:2 withObject:@"男"];
        NSString *string = [dict objectForKey:array[2]];
        if (![@"男" isEqualToString:string]){
            [_tempDic setValue:@"112" forKey:array[2]];

            
            [dict setValue:@"男" forKey:array[2]];
        }

        [_tableView reloadData];
  
    }


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.row==0){
        cell.accessoryType =     UITableViewCellAccessoryNone;    // regular chevron. doesn't track
   
    }else{
    cell.accessoryType =     UITableViewCellAccessoryDisclosureIndicator;    // regular chevron. doesn't track
    }
    NSString *string = [_dataArray objectAtIndex:indexPath.row];
    string = [NSString stringWithFormat:@"%@   %@",MessageArray[indexPath.row],string];
    cell.textLabel.text = string;
    NSLog(@"~~~~~~%@",string);
    return cell;
}
-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavgationHeight-kStatusHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [ _tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
   // [_tableView registerClass: forHeaderFooterViewReuseIdentifier:];
    [self.view addSubview:_tableView];
    
    
    
}
-(void)backData:(NSString *)str textField:(NSString *)str1{
    [self.dataArray replaceObjectAtIndex:[str integerValue] withObject:str1];
    NSString *string = [dict objectForKey:array[[str integerValue]]];
    if (![str1 isEqualToString:string]){
    [dict setValue:str1 forKey:array[[str integerValue]]];
    [_tempDic setValue:str1 forKey:array[[str integerValue]]];
    }
    
    [_tableView reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
