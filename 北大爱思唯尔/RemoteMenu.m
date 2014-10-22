//
//  RemoteMenu.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "RemoteMenu.h"
#import "RemoteModel.h"
#import "RemoteMenuRightCell.h"
#import "RemoteMenuLeftCell.h"
#import "SXJDataService.h"
#import "CourseViewController.h"
#import "RequestData.h"
#import "EveryUrl.h"
#import "ColorUtil.h"
#define kNavNumber 2
#define kNavHeight 40
#define kBtnTag 1000

#define kIndexViewHiddenHeight 100


#define kLeftTableViewTag 1111
#define kRightTableViewTag 1112

@interface RemoteMenu () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite)UIView *mainView;
@property (nonatomic, strong)UIView *navigationView;

@property (nonatomic, strong)UITableView *leftTableView;
@property (nonatomic, strong)UITableView *rightTableView;

@property (nonatomic, strong)NSMutableArray *rightData;
@end

@implementation RemoteMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuHid) name:NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuHid) name:NOTIFICATION object:nil];
        [self _initSubViews];
        [self _loadTableView];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuHid) name:NOTIFICATION object:nil];
        
        _rightData = [[NSMutableArray array] init];
    }
    return self;
}
-(void)menuHid{
    NSLog(@"!!!!!!!!");
    if (_mainView.left!=-kScreenWidth){
    _mainView.left = -kScreenWidth;
    _mainView.height = 0;
    self.height = kNavHeight;
    }

    
    
}
#pragma mark - Private Method
- (void)_initSubViews
{
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavHeight)];
    _navigationView.backgroundColor = [UIColor whiteColor];
    [ColorUtil setBackgroundColor:[ColorUtil getColor:@"EBEBEB" alpha:1]];
    [_navigationView setBackgroundColor:[ColorUtil getBackgroundColor]];
    [self addSubview:_navigationView];
    
//    for (int i = 0; i<kNavNumber; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(i * kScreenWidth/kNavNumber, 0, kScreenWidth/kNavNumber, kNavHeight);
//        [button setTitle:@"远程授课" forState:UIControlStateNormal];
//        [button setTitleColor:kHodoGray forState:UIControlStateNormal];
//
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//        [button addTarget:self action:@selector(navButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = kBtnTag + i;
//        [_navigationView addSubview:button];
//    }
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, kScreenWidth/kNavNumber, kNavHeight);
//        [_button setTitle:@"远程授课" forState:UIControlStateNormal];
        [_button setTitleColor:kHodoGray forState:UIControlStateNormal];

        _button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
          [ColorUtil setBackgroundColor:[ColorUtil getColor:@"EBEBEB" alpha:1]];
    [_button setBackgroundColor:[ColorUtil getBackgroundColor]];
        [_button addTarget:self action:@selector(navButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _button.tag = kBtnTag ;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/kNavNumber-40,14 , 15,12 )];
    _imageView.image = Image(@"all_category_right@2x");
    [_button addSubview:_imageView];
        [_navigationView addSubview:_button];

    _mainView = [[UIView alloc] initWithFrame:CGRectMake(-kScreenWidth, kNavHeight, self.width, kMainHeight)];
    _mainView.backgroundColor = kHodoxuanzhong;
    [self addSubview:_mainView];
}

- (void)_loadTableView
{
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, _mainView.height) style:UITableViewStyleGrouped];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.rowHeight = 30;
    _leftTableView.tag = kLeftTableViewTag;
    [_mainView addSubview:_leftTableView];
    
    
    
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, _mainView.height) style:UITableViewStyleGrouped];
    _rightTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.rowHeight = 30;
    _rightTableView.tag = kRightTableViewTag;
    [self.rightTableView setBackgroundView:nil];
    [self.rightTableView setBackgroundColor:[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0]];
    [_mainView addSubview:_rightTableView];
}
#pragma mark - Setter Method
-(void)setUrlData:(NSArray *)UrlData{
    if (_UrlData!=UrlData){
        
        _UrlData = UrlData;
        
        
    }
}
- (void)setData:(NSArray *)data
{
    if (_data != data) {
        _data = data;
        [_leftTableView reloadData];
    }
}
-(void)setRightData:(NSMutableArray *)rightData{
    if (_rightData != rightData){
        _rightData = rightData;
        //[_rightTableView reloadData];
        
    }
}

#pragma mark - Action Method
- (void)navButtonAction:(UIButton *)button
{
    //[self bringSubviewToFront:_parent];
    if (button.tag == kBtnTag) {
        
        button.selected  = !button.selected;
        
        if (button.selected) {
            
            _mainView.left = 0;
            _mainView.height = kMainHeight;
            self.height = kNavHeight + kMainHeight;
        }else{
            
            _mainView.left = -kScreenWidth;
            //_mainView.height = 0;
            self.height = kNavHeight;
            
        }

    }
}


#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == kLeftTableViewTag) {
        return _data.count;
    }
    if (tableView.tag == kRightTableViewTag) {
        return _rightData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kLeftTableViewTag) {
        
        static NSString *ID = @"cell";
        RemoteMenuLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RemoteMenuLeftCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;

            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                [self.leftTableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
            }


        }
        RemoteModel *model = _data[indexPath.row];
        cell.textLabel.text = model.title;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = kHodoGray;

        
       
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
        return cell;
    }
    if (tableView.tag == kRightTableViewTag) {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RemoteMenuRightCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        RemoteModel *model = _rightData[indexPath.row];
        cell.textLabel.text = model.title;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = kHodoGray;
        cell.backgroundColor = kHodoxuanzhong;

        return cell;
    }
    return nil;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kLeftTableViewTag) {
        if (self.tag == 200){
        _sign= indexPath.row;
            NSLog(@"!!!!%d",_sign);
        }
        RemoteModel *model = _data[indexPath.row];
        self.rightData = model.childs;
        self.number2 = model.childs.count;
//        if (self.tag == 200&&indexPath.row ==4){
//            [_rightData removeLastObject];
//            
//            
//            
//        }
        
        if (_rightData.count==0){
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"全部课程",@"title",nil];
            RemoteModel *model = [[RemoteModel alloc] initWithContent:dict];
            [self.rightData addObject:model];
            
            NSLog(@"%@",self.rightData);
        }
        [_rightTableView reloadData];
//        if (_rightData.count <= 0) {
//            UIButton *button = (UIButton *)[_navigationView viewWithTag:kBtnTag];
//            button.selected = !button.selected;
//            _mainView.left = -kScreenWidth;
//            _mainView.height = 0;
//            self.height = kNavHeight;
           // NSDictionary *dict = @{@"1": kCountryURL,@"2":kCanURL,@"3":kOtherURL};
//            
//            if(self.urlBlock){
//                
//                self.urlBlock([dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]]);
//            }
//            _rightTableView.hidden = YES;
//        }else{
        
        if (self.tag ==200){

            _rightTableView.hidden = NO;
            [[RequestData shareManager] number:indexPath.row remoteMenu:self];
                       
            
        }else if (self.tag == 100){
            self.number= indexPath.row+1;
            
        }
           
            
            
            
        //}
        //NSLog(@"点击%@", model.title);
        
        
    }
    if (tableView.tag == kRightTableViewTag) {
        
        if (self.tag==200&&_sign == 4&& indexPath.row==2){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"暂时没有信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            return;
            
        }
        
        
        //RemoteModel *model = _rightData[indexPath.row];
        UIButton *button = (UIButton *)[_navigationView viewWithTag:kBtnTag];
        button.selected = !button.selected;
        _mainView.left = -kScreenWidth;
        _mainView.height = 0;
        self.height = kNavHeight;
        if (self.tag == 100){
            NSDictionary *dict = @{@"1": kCountryURL,@"2":kCanURL,@"3":kOtherURL};
            
            if(self.urlBlock){
                self.urlBlock([dict objectForKey:[NSString stringWithFormat:@"%d",self.number]]);

            }
            
            
//        }
//        if (indexPath.row>_UrlData.count-1){
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"暂时没有信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//            [alert show];
            
            
        }else if(self.tag == 200&&self.UrlData==nil){
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"暂时没有信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                       [alert show];
            
            
        }else{
            
            if (self.urlBlock){
                RemoteModel *model = [_UrlData objectAtIndex:indexPath.row];
                
                //NSLog(@"%@",model.coursecategoryid);
                self.urlBlock(model.coursecategoryid);
            
        }
        }
       // NSLog(@"点击%@", model.title);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.1;
}


@end
