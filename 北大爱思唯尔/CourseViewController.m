//
//  CourseViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "CourseViewController.h"
#import "RemoteMenu.h"
#import "DropDownListView.h"
#import "MovieController.h"
#import "CustomCell.h"
#import "introductionViewController.h"
#import "LandedViewController.h"
#import "SXJDataService.h"
#import "RemoteModel.h"
#import "FacetofaceModel.h"
#import "RefreshTableView.h"
@interface CourseViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *chooseArray ;
}

@property (nonatomic, strong)RemoteMenu *menuView;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)NSMutableArray *yuanData;
@end

@implementation CourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"面授课程";
        _yuanData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"面授课程";
    [self _loadTableView];
    
    [self _loadMeunView];
    
    [self requestData];
    [self showWaiting];
    HttpDownLoadBlock *http = [[HttpDownLoadBlock alloc] initWithUrlStr:[NSString stringWithFormat:FACETOFACEURL,FACETOFACEALLURL] setBlock:^(HttpDownLoadBlock *http, BOOL isFinish) {
        if (isFinish){
            self.dataArray = [NSMutableArray array];
            for (NSDictionary *dict in http.dataArray) {
                FacetofaceModel *model = [[FacetofaceModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
                
                
            }
           // NSLog(@"~~~~~%@",self.dataArray);
            [self hideWaiting];
            [_tableView reloadData];
            
            
            
            
            
        }
        
        
        
        
        
        
        
    }];

    //[self _dropList];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}




- (void)_loadMeunView

{   //NSArray *array = [[NSArray alloc] initWithObjects:@"国家级面授课",@"学会级面授课",@"其他面授课", nil];
    
    
    _menuView = [[RemoteMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _menuView.tag = 100;
    __block typeof(self)Aself = self;
    _menuView.urlBlock = ^(NSString *str){
        [Aself loadData:str];
        
    };
    
    [_menuView.button setTitle:@"面授课程" forState:UIControlStateNormal];
    [self.view addSubview:_menuView];
}
- (void)showWaiting
{
    [[ProgressHUD instance] showProgressHD:YES inView:self.view info:@"加载中..."];
}

- (void)hideWaiting
{
    [[ProgressHUD instance] showProgressHD:NO inView:self.view info:@"加载中..."];
}

-(void)loadData:(NSString *)str{
    [self showWaiting];
    HttpDownLoadBlock *http = [[HttpDownLoadBlock alloc] initWithUrlStr:[NSString stringWithFormat:@"%@%@",kBaseURL,str]     setBlock:^(HttpDownLoadBlock *http, BOOL isFinish) {
        NSLog(@"!!!!!!!%@",[NSString stringWithFormat:@"%@%@",kBaseURL,str]);
        if (isFinish){
            self.dataArray= [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in http.dataArray){
                FacetofaceModel *model = [[FacetofaceModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
                
            }
            [self hideWaiting];
            [_tableView reloadData];
        }
        
        
        
        
    }];

    
}
- (void)loadHeader
{
    //pageNum = 1;
    //[self _loadData];
}

- (void)loadFooter
{
    //[self _loadData];
}
- (void)_loadTableView
{
    _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40-64) style:UITableViewStylePlain];
    _tableView.rowHeight = 90;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.parent = self;
    _tableView.enableHeader = YES;
    _tableView.enableFooter = YES;
    _tableView.userInteractionEnabled = YES;
    [self.view addSubview:_tableView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_tableView performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_tableView performSelector:@selector(scrollViewDidEndDragging:willDecelerate:) withObject:scrollView withObject:nil];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CustomCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
//        cell = [[CourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CourseTableViewCell" owner:nil options:nil] lastObject];
    }
    FacetofaceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell configUI:model];
    
    
    

    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    FacetofaceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    introductionViewController *expatiationVC = [[introductionViewController alloc] init];
    expatiationVC.model = model;
    
    [self.navigationController pushViewController:expatiationVC animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.0;
}

#pragma mark - Request Data
- (void)requestData
{
    [SXJDataService requestURL:kRemoteURL method:@"GET" params:nil completion:^(id result) {
        
        //DLog(@"result : %@", result);
        
        for (NSDictionary *data in [result[0] objectForKey:@"childs"]) {
            RemoteModel *model = [[RemoteModel alloc] initWithContent:data];
            [_yuanData addObject:model];
           // NSLog(@"_data:%@",_yuanData);
        }
        _menuView.data = _yuanData;
       // NSLog(@"_data:%@",_yuanData);
    } error:^(id error) {
        NSLog(@"列表请求错误");
    }];
}




@end
