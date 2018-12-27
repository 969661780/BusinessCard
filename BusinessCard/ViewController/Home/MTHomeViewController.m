//
//  MTHomeViewController.m
//  BusinessCard
//
//  Created by mt y on 2018/7/2.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTFootView.h"
#import "MTAddPutModeTool.h"
#import "MTHomeCardTableViewCell.h"
#import "MTFillInMoodViewController.h"
#import "MTContactsViewController.h"
#import "MTDetailsViewController.h"
#import "MTFillConViewController.h"
#import "WBNativityShare.h"
#import <Social/Social.h>
#import <Masonry.h>
@interface MTHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong)NSMutableDictionary *dataDic;
@property (nonatomic, strong)UIView *noData;
@property (nonatomic, strong)UIImageView *imageVIew;
@property (nonatomic, strong)UILabel *abe;
@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Electronic Name Card";
    UIImage *selectedImage=[UIImage imageNamed: @"形状"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBtn)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.myTable registerNib:[UINib nibWithNibName:NSStringFromClass([MTHomeCardTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTHomeCardTableViewCell class])];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    
    [self getData];
}
- (void)addNoDateView
{
    CHKit_WeakSelf
    //    self.noData.frame = CGRectMake(self.myTableView.x, self.myTableView.y, ZHScreenW, self.myTableView.height);
    [self.view addSubview:self.noData];
    [self.noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.myTable);
        make.width.bottom.equalTo(self.view);
    }];
    [self.imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_self.noData);
        make.centerY.equalTo(weak_self.noData).offset(-15);
    }];
    [self.abe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_self.noData);
        make.top.equalTo(self.imageVIew.mas_bottom);
    }];
    
}
- (void)renoveDataView
{
    [self.noData removeFromSuperview];
}
- (void)getData
{
    NSMutableArray *myArrJob = [MTAddPutModeTool getAllCardMode:@"Job"];
    NSMutableArray *myArrColleague = [MTAddPutModeTool getAllCardMode:@"Colleague"];
    NSMutableArray *myArrClassmates = [MTAddPutModeTool getAllCardMode:@"Classmates"];
    NSMutableArray *myArrOthers = [MTAddPutModeTool getAllCardMode:@"Others"];
    if (myArrJob.count != 0) {
        [self.dataDic setValue:myArrJob forKey:@"Job"];
    }
    if (myArrColleague.count != 0) {
        [self.dataDic setValue:myArrColleague forKey:@"Colleague"];
    }
    if (myArrClassmates.count != 0) {
        [self.dataDic setValue:myArrClassmates forKey:@"Classmates"];
    }
    if (myArrOthers.count != 0) {
        [self.dataDic setValue:myArrOthers forKey:@"Others"];
    }
    if (self.dataDic.count == 0 || !self.dataDic.count) {
        [self renoveDataView];
        [self addNoDateView];
    }else{
        [self renoveDataView];
    }
    [self.myTable reloadData];
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataDic.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.dataDic[self.dataDic.allKeys[section]];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTHomeCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTHomeCardTableViewCell class]) forIndexPath:indexPath];
    NSArray *arr = self.dataDic[self.dataDic.allKeys[indexPath.section]];
    cell.personMode = arr[indexPath.row];
    cell.btnBlock = ^{
        NSString *appid = @"1402682615";
        NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",appid];
        
        
        NSDictionary *par = @{@"shareUrl":url};
        [WBNativityShare WBSystemCallShareWithController:self par:par];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTDetailsViewController *contactdetail = [[MTDetailsViewController alloc] init];
    NSArray *arr = self.dataDic[self.dataDic.allKeys[indexPath.section]];
    contactdetail.perMode = arr[indexPath.row];
    [self.navigationController pushViewController:contactdetail animated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataDic.allKeys[section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 194;
}

#pragma mark -touchs
- (void)rightBtn
{
    MTContactsViewController *con = [MTContactsViewController new];
    [self.navigationController pushViewController:con animated:YES];
}
- (IBAction)jobBtn:(UIButton *)sender {
    MTFillConViewController *con = [MTFillConViewController new];
    con.type = @"Job";
    [con view];
    [self.navigationController pushViewController:con animated:YES];
}
- (IBAction)colleagueBtn:(UIButton *)sender {
    MTFillConViewController *con = [MTFillConViewController new];
    con.type = @"Colleague";
    [con view];
    [self.navigationController pushViewController:con animated:YES];
}
- (IBAction)classBtn:(UIButton *)sender {
    MTFillConViewController *con = [MTFillConViewController new];
    con.type = @"Classmates";
    [con view];
    [self.navigationController pushViewController:con animated:YES];
}
- (IBAction)classmatesBtn:(UIButton *)sender {
    MTFillConViewController *con = [MTFillConViewController new];
    con.type = @"Others";
    [con view];
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark -getter
- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary new];
    }
    return _dataDic;
}
- (UIView *)noData{
    if (!_noData) {
        _noData = [UIView new];
        _noData.backgroundColor = ZHBackgroundColor;
        self.imageVIew= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1313"]];
        
        //        imageVIew.frame = CGRectMake(self.myTableView.width/2 - 54, self.myTableView.height/2 - 32, 128, 84);
        [_noData addSubview:self.imageVIew];
        self.abe= [UILabel new];
        self.abe.text = @"There is no data now";
        self.abe.textColor = [UIColor grayColor];
        
        //        abe.frame = CGRectMake(imageVIew.x+ 15, imageVIew.y+imageVIew.height + 10, imageVIew.width, 50);
        [_noData addSubview:self.abe];
    }
    return _noData;
}
@end
