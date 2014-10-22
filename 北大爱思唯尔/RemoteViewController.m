//
//  RemoteViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "RemoteViewController.h"
#import "RemoteMenu.h"
#import "SXJDataService.h"
#import "RemoteModel.h"
#import "CustomCell.h"
#import "ListViewController.h"

#define kMenuNavHeight 40

@interface RemoteViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)RefreshTableView *tableView;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)RemoteMenu *menuView;

@end

@implementation RemoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"远程授课";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    strUrl = @"2070";
    _data = [[NSMutableArray alloc] init];
    [self _initSubViews];
    [self _loadMeunView];
   // return;
    [self _loadRequest];
    
    [self _loadData];
}

- (void)showWaiting
{
    [[ProgressHUD instance] showProgressHD:YES inView:self.view info:@"加载中..."];
}

- (void)hideWaiting
{
    [[ProgressHUD instance] showProgressHD:NO inView:self.view info:@"加载中..."];
}
- (void)loadHeader
{
    //pageNum = 1;
    [self _loadData];
}

- (void)loadFooter
{
    [self _loadData];
}


-(void)_loadData{
    //return;
    self.pID = strUrl;
    [self showWaiting];
    [SXJDataService requestURL:[NSString stringWithFormat:REmotePartUrl,strUrl] method:@"GET"params:nil completion:^(id result) {
        //self.dataCell = [[NSMutableArray alloc] init];
        if (![[result firstObject] isKindOfClass:[NSDictionary class]]){
            [self hideWaiting];
            NSLog(@"!!!%@",strUrl);
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒信息" message:@"暂时没有相关课程" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [view show];
            return ;
        }
        self.dataCell = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in result){
            RemoteModel *model = [[RemoteModel alloc] initWithContent:dict];
            [self.dataCell addObject:model];
            
        }
        [self hideWaiting];
        [_tableView reloadData];
        
       // NSLog(@"!!!!!!!!%@",self.dataCell);
        
        
    } error:^(id error) {
        NSLog(@"列表请求错误");
        
    }];
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method
- (void)_initSubViews
{
    _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-kTabBarHeight-kNavgationHeight-kStatusHeight) style:UITableViewStylePlain];
    _tableView.rowHeight = 140;
    _tableView.parent = self;
    _tableView.enableHeader = YES;
    _tableView.enableFooter = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
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

- (void)_loadMeunView
{
    _menuView = [[RemoteMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _menuView.tag = 200;
    _menuView.parent = self;
        [_menuView.button setTitle:@"远程课程" forState:UIControlStateNormal];
    __block typeof(self)Aself = self;
    _menuView.urlBlock = ^(NSString *str){
        
        
        [Aself loadData:str];
        
    };
    [self.view addSubview:_menuView];


}
-(void)loadData:(NSString *)str{
    
    
    strUrl = str;
    //NSLog(@"~~~~~~%@",str);
    [self _loadData];
    
    
    
    
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataCell.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {

        cell = [[[NSBundle mainBundle] loadNibNamed:@"CourseTableViewCell" owner:nil options:nil] lastObject];

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [self.tableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
        }
        
        

    }
    RemoteModel *model = [self.dataCell objectAtIndex:indexPath.row];
    
   
    [cell configRemote:model];
   

    return cell;
}
//http://kouqiang.yiaiwang.com.cn/index.php
#pragma mark - Request Data
-(void)_loadRequest{
    
    [SXJDataService requestURL:kRemoteURL method:@"GET" params:nil completion:^(id result) {
        
       // DLog(@"result : %@", result);
       
        for (NSDictionary *data in [result[1] objectForKey:@"childs"]) {
            
            
            RemoteModel *model = [[RemoteModel alloc] initWithContent:data];
            [_data addObject:model];
            //NSLog(@"_data:%@",_data);
        }
       
        
        _menuView.data = _data;
        
        //NSLog(@"_data:%@",_data);
    } error:^(id error) {
        NSLog(@"列表请求错误");
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RemoteModel *model = [self.dataCell objectAtIndex:indexPath.row];
    
    //NSLog(@"~~~~~%@",model.RemoteModelID);
    ListViewController *vc = [[ListViewController alloc] init];
    vc.title = @"课程详情";
    vc.model = model;
    vc.num = 100;
    vc.pID = self.pID;
    vc.correlationArray = _dataCell;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
    
    
    
    
    

//    [SXJDataService requestURL:kRemoteURL method:@"POST" params:nil completion:^(id result) {
//        for (NSDictionary *data in [result[1] objectForKey:@"childs"]) {
//            RemoteModel *model = [[RemoteModel alloc] initWithContent:data];
//            [_data addObject:model];
//            NSLog(@"_data:%@",_data);
//        }
//        _menuView.data = _data;
//    }];
//}
@end
