//
//  CentreViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-8-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "CentreViewController.h"
#import "ZCFUserInfoHeaderView.h"
#import "LiebTableViewCell.h"
#import "LandedViewController.h"
#import "Animation.h"
#import "AppDelegate.h"
#import "SXJDataService.h"
#import "personalCenterModel.h"
#import "OCTouchView.h"
#import "landNaiViewController.h"
#import "collectMetod.h"
#define kUserInfoID @"userInfoCellID"
#import "MessageCell.h"
#import "ListViewController.h"
#import "CollectViewController.h"
#import "editViewController.h"
#import "UtilMethod.h"
typedef enum{
    btn_coupon     = 3111,   // 优惠券
    btn_collection = 3112,   // 收藏
    btn_history    = 3113,   // 最近浏览
    
    userInfo       = 3333,   // 点击用户页面
    
} button_type;


@interface CentreViewController ()
{
    UITableView *_tableView ;
    NSInteger number;
    UIAlertView *outAlert;
    UIImagePickerController *imagePicker;

}
@property(nonatomic,assign)personalCenterModel *model;
@property(nonatomic,retain)personalCenterModel *model1;
@property(nonatomic,strong)NSString *neID;
@property(nonatomic,strong)OCTouchView *maskView;
@property(nonatomic,strong)UIView *ShowView;
@property(nonatomic,strong)NSMutableArray *courseArray;
@property(nonatomic,strong)NSMutableArray *messageArray;
@end

@implementation CentreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"个人中心";
        self.USEDataArray = [[NSMutableArray alloc] init];
        self.courseArray = [[NSMutableArray alloc] init];
        editButton = [[UIButton alloc] init];
        //self.messageArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    number = 1;
    selectIndex = 3111;
    [self _loadTableView];
    [self createNaV];
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0;i<3;i++){
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        [self.dataArray addObject:array];
        
        
        
    }
    
    [self _loadTableView];
   
    [self _loadTableHeaderView];
    
   
    if (![[NSUserDefaults standardUserDefaults] objectForKey:LOGIN]){
        [self getUserData];
        [self getAccountData];
        
    }else{
        
    [headerView configUI1];
    [headerView configUI];
        [headerView configUITest];
        
    }


   
    [self loadData];
    
  
}

-(void)createNaV{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 30);
    [button setImage:[UIImage imageNamed:@"nav_menu_icon@2x"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = leftButton;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 80, 30);
    [button1 setTitle:@"退出登录" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = leftButton1;
    [button1 addTarget:self action:@selector(leftbuttonClick) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
}
-(void)leftbuttonClick{
    outAlert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"确定退出" otherButtonTitles:@"取消", nil];
    [outAlert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == outAlert){
        if (buttonIndex==0){
            
            
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            LandedViewController *vc = [[LandedViewController alloc] init];
            landNaiViewController *nc= [[landNaiViewController alloc] initWithRootViewController:vc];
            
            [UIView animateWithDuration:0.5 animations:^{
                app.window.rootViewController = nc;
            } completion:^(BOOL finished) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERID];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *path1 = [path objectAtIndex:0];
                [[NSFileManager defaultManager] removeItemAtPath:[path1 stringByAppendingString:@"/dataArray.plist"] error:nil];
                [[NSFileManager defaultManager] removeItemAtPath:[path1 stringByAppendingString:@"/dataDict.plist"] error:nil];
                
                [collectMetod dropAllTable];
                
                
            }];       //app.window.rootViewController = vc;
            
            
            
        }
        
        
    }
}

-(void)buttonClick{
    
    CollectViewController *vc = [[CollectViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)getAccountData{
    [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/Getuserexpand&uid=%@",_neID] method:@"GET"
     
     
                        params:nil completion:^(id result) {
                            personalCenterModel *model = [[personalCenterModel alloc] initWithContent:result];
                            
                            if (_model1 != nil){
                                _model1 = nil;
                            }
                            _model1 = model;
                            //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION object:_model];
                            [[NSUserDefaults standardUserDefaults] setObject:_model1.money forKey:BALANCE];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [headerView configUI1];
                            
                        } error:^(id error) {
                            
                            
                        }];

  
    
    
}
-(void)loadData{

   
    NSMutableArray *array = self.dataArray[selectIndex-3111];
    if (array.count>0){
        [_tableView reloadData];
        return;
    }
    
    
    [self showWaiting];
    [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/Getbuycourseinfo&uid=%@",DEFAULT(USERID)] method:@"GET" params:nil completion:^(id result) {
       // _dataArray = [NSMutableArray array];
        for (NSDictionary *dict in result){
            
            personalCenterModel *model = [[personalCenterModel alloc] initWithContent:dict];
            
            [array addObject:model];
            [_courseArray addObject:model.personalCenterModelID];
            
        }
        
        NSString *path = homeURL;
        [_courseArray writeToFile:[path stringByAppendingString:@"/course.plist"] atomically:YES];
        
        [self hideWaiting];
        [_tableView reloadData];
        
    } error:^(id error) {
        
        
    }];
    
    
    
    
    
    
}

   
    
- (void)showWaiting
{
    [[ProgressHUD instance] showProgressHD:YES inView:self.view info:@"加载中..."];
}

- (void)hideWaiting
{
    [[ProgressHUD instance] showProgressHD:NO inView:self.view info:@"加载中..."];
}
    
    

-(void)getUserData{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    
    NSString *useId = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    if (useId&&useId.length>0){
        //NSLog(@"~~~~~~~~");
        _neID = useId;
    }else{
        _neID = app.shareID;
        [[NSUserDefaults standardUserDefaults] setObject:_neID forKey:USERID];
        [[NSUserDefaults standardUserDefaults] synchronize];
       // NSLog(@"!!!!!!!!");
        
        
        
        
    }
    
   
    //_neID = app.shareID;
    
    
    [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/getuserinfo&uid=%@",_neID] method:@"GET"
     
     
                        params:nil completion:^(id result) {
                            NSLog(@"~~~~%@",result);
                            personalCenterModel *model = [[personalCenterModel alloc] initWithContent:result];
                            if (_model != nil){
                                _model = nil;
                                
                            }
                            _model = model;
                           
                            [[NSUserDefaults standardUserDefaults] setObject:_model.user_name forKey:USERNAME];
                            
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self collectData];
                            
                        
                            [headerView configUI];
                            
                        } error:^(id error) {
                           // NSLog(@"!!!!!%@",error);
                            
                            
                        }];
    
    
}
-(void)collectData{
    //self.USEDataArray = [[NSArray alloc] init];
    NSString *str = nil;
    if (_model.gender.length>0){
    if ([_model.gender isEqualToString:@"112"]){
        str = @"男";
        
    }
    if ([_model.gender isEqualToString:@"113"]){
        str = @"女";
    }
    }else{
        str = @"";
    }
    
   
    _dataDict = [[NSDictionary alloc] initWithObjects:@[_model.user_name,_model.true_name,str,_model.address,_model.cardno]forKeys:@[@"user_name",@"true_name",@"gender",@"address",@"cardno"]];
    
    
   
    _USEDataArray = [NSArray arrayWithObjects:_model.user_name,_model.true_name,str,_model.address,_model.cardno, nil];
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path1 = [path objectAtIndex:0];
    
    [_USEDataArray writeToFile:[path1 stringByAppendingString:@"/dataArray.plist"] atomically:YES];
    [_dataDict writeToFile:[path1 stringByAppendingString:@"/dataDict.plist"] atomically:YES];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_loadTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kNavgationHeight-kStatusHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 135;
    [self.view addSubview:_tableView];
}
#pragma mark - UITableView HeaderView
ZCFUserInfoHeaderView *headerView;
- (void)_loadTableHeaderView
{
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"ZCFUserInfoHeaderView" owner:self options:nil] lastObject];
    
    headerView.buttonDelegate = ^(NSInteger index){
        if (index ==3333){
            [self changeImage];
            
            
        }
        
        if (index == btn_coupon) {
            selectIndex = btn_coupon;
            number = 1;
            _tableView.tableFooterView = nil;
            [self loadData];
            // 点击 优惠券
        }else if (index == btn_collection){
            selectIndex = btn_collection;
            number = 2;
            _tableView.tableFooterView = nil;
            [self recordData];
            // 点击 收藏
        }else if (index == btn_history){
            selectIndex = btn_history;
            NSLog(@"!!!!!");
            //[self showView];
            [self createUserMessage];
            
            
            // 点击 历史
        }else if (index == userInfo){
            NSLog(@"点击 用户信息界面");
            // 点击 用户信息界面
            
            [self changeImage];
            
        }
    };
    _tableView.tableHeaderView = headerView;
}
-(void)changeImage{
    [self showView];
    
}

-(void)createUserMessage{
    
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path1 = [path objectAtIndex:0];
    
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/dataArray.plist",path1]];
    
   _dataArray[selectIndex-3111] = [NSArray arrayWithArray:arr];
    
    MessageArray = @[@"用  户  名:",@"真实姓名:",@"性       别:",@"地       址:",@"身份证号:"];
    editButton.frame = CGRectMake(0, 0,kScreenWidth, 60);
    // 设置button标题
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    editButton.backgroundColor =kHodoGreen;
    editButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    editButton.layer.cornerRadius = 3.0;
    editButton.layer.borderWidth = 1.0;
    // 线的颜色
    editButton.layer.borderColor = [UIColor clearColor].CGColor;
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(sureInfo) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = editButton;
    [_tableView reloadData];
    
    
    
    
    
}
-(void)sureInfo{
    
    editViewController *vc = [[editViewController alloc] init];
    vc.parent = self;
    vc.title = @"编辑资料";
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)showView{
    self.maskView.hidden = NO;
    self.ShowView.hidden = NO;
    
    
}
-(OCTouchView *)maskView{
    if (!_maskView&&!_ShowView){
        CREATE_WEAK_SELF;
        _maskView = [[OCTouchView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.6;
        _maskView.touchesBlock = ^(NSSet *touches, UIEvent *event, OCTouchState state) {
            [weakSelf hideView];
            
            
        
        };
        
        [self.view addSubview:_maskView];
        [self createShowView];
        
    }
    return _maskView;
}
-(void)createShowView{
    _ShowView = [[UIView alloc] init];
    _ShowView.alpha = 1;
    _ShowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_ShowView];
    _ShowView.backgroundColor = [UIColor whiteColor];
    NSDictionary *views = NSDictionaryOfVariableBindings(_ShowView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-50-[_ShowView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[_ShowView]-150-|" options:0 metrics:nil views:views]];
    UIButton *button1 = [[UIButton alloc] init];
    UIButton *button2 = [[UIButton alloc] init];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    button1.layer.borderWidth = 1;
    button1.layer.borderColor = [UIColor blackColor].CGColor;
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = 10;
    button2.layer.borderWidth = 1;
    button2.layer.borderColor = [UIColor blackColor].CGColor;
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 10;
    [button1 setTitle:@"重相册中选择" forState:UIControlStateNormal];
    [_ShowView addSubview:button1];
    [_ShowView addSubview:button2];
    [button2 setTitle:@"相机" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSDictionary *views1 = NSDictionaryOfVariableBindings(button1,button2);
    [_ShowView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[button1(40)]-[button2]" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:views1]];
    [_ShowView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-50-[button1]-50-|" options:0 metrics:nil views:views1]];
    
    
    
    
    [button1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    [button2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    

    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self hideView];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"~~~~~))))))%@",mediaType);
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            
            //UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
           // UIImageWriteToSavedPhotosAlbum(original_image, self,
//                                           @selector(image:didFinishSavingWithError:contextInfo:),
//                                           nil);
                        }
    UIImage* theImage = [UtilMethod imageWithImageSimple:image scaledToSize:CGSizeMake(120.0, 120.0)];
    UIImage *midImage = [UtilMethod imageWithImageSimple:image scaledToSize:CGSizeMake(210.0, 210.0)];
    UIImage *bigImage = [UtilMethod imageWithImageSimple:image scaledToSize:CGSizeMake(440.0, 440.0)];
    
    [UtilMethod saveImage:theImage WithName:@"salesImageSmall.jpg"];
    [UtilMethod saveImage:midImage WithName:@"salesImageMid.jpg"];
    [UtilMethod saveImage:bigImage WithName:@"salesImageBig.jpg"];
    if ([mediaType isEqualToString:@"public.movie"]){
        //NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"found a video");
       // NSData *webData = [NSData dataWithContentsOfURL:videoURL];
        //NSData *video = [[NSString alloc] initWithContentsOfURL:videoURL];
       // [webData writeToFile:[self findUniqueMoviePath] atomically:YES];
       // CFShow([[NSFileManager defaultManager] directoryContentsAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents"]]);
    }
    [self hideView];
    [self dismissViewControllerAnimated:YES completion:^{
        
        //[self hideView];
        [headerView configUITest];
        
    }];
    
    
}
-(void)btn1Click{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    }
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
    
}
-(void)btn2Click{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}
-(void)hideView{
    
    self.maskView.hidden = YES;
    self.ShowView.hidden = YES;
        
    }
-(void)recordData{
    
    NSLog(@"%d",selectIndex);
    //return;
    if ([_dataArray[selectIndex-3111] count]>0){
        [_tableView reloadData];
        return;
    }
    
    [self showWaiting];
    
    [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/Gethistorycourseinfo&uid=%@",DEFAULT(USERID)] method:@"GET"
     
                        params:nil completion:^(id result) {
                            
                            for (NSDictionary *dict in result){
                                personalCenterModel *model = [[personalCenterModel alloc] initWithContent:dict];
                                [_dataArray[selectIndex-3111] addObject:model];
                            }
                            [self hideWaiting];
                            [_tableView reloadData];
                            
                        } error:^(id error) {
                            
                            
                            
                            
                        }];
    
    
}
#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *arr = [_titleArr objectAtIndex:section];
    if(selectIndex == 3113){
        return [self.dataArray[selectIndex-3111] count];
    }else {
    return [self.dataArray[selectIndex-3111] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (selectIndex == 3113){
        
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        if (cell == nil){
            
            
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        NSString *string = [_dataArray[selectIndex-3111] objectAtIndex:indexPath.row];
        if (string.length==0||!string){
            string = @"请您将资料填写完整";
        }
        NSLog(@"!@!@!@!@@12122%d",string.length);
        string = [NSString stringWithFormat:@"%@   %@",MessageArray[indexPath.row],string];
        [cell conFig:string];
   
        
        
        return cell;
        
        
    }else{
    
    LiebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LiebTableViewCell" owner:self options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    personalCenterModel *model = self.dataArray[selectIndex-3111][indexPath.row];
    [cell configUI:model number:number];

    return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectIndex == 3113){
        return;
    }else{
        
        personalCenterModel *model = self.dataArray[selectIndex-3111][indexPath.row];
        ListViewController *vc = [[ListViewController alloc] init];
        vc.model2 = model;
        
        //NSLog(@"~~~%@",model.model.personalCenterModelID);
        vc.num = selectIndex;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
        
        
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectIndex == 3113){
        return 80.0f;
    }else{
        
        return 125.0f;
    }
}

@end
