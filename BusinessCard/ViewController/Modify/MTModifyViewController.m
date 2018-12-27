//
//  MTModifyViewController.m
//  BusinessCard
//
//  Created by mt y on 2018/7/4.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTModifyViewController.h"
#import "MTModifyTelOneTableViewCell.h"
#import "MTModifyMarkTableViewCell.h"
#import "MTDetailsOneTableViewCell.h"
#import <SVProgressHUD.h>
#import "MTHomeViewController.h"
#import "MTAddPutModeTool.h"
@interface MTModifyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)UITextField *telTextFiled;
@property (nonatomic, strong)UITextField *AddressTextFiled;
@property (nonatomic, strong)UITextField *companyTextFiled;
@property (nonatomic, strong)UITextView *markTextView;
@end

@implementation MTModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Details";
    
    UIView *footView = [UIView new];
    if (ZHScreenH - 352 - 44*3 > 100) {
        footView.frame = CGRectMake(0, 0, ZHScreenW, ZHScreenH - 352 - 44*3);
    }else{
         footView.frame = CGRectMake(0, 0, ZHScreenW, 100);
    }
    
    footView.backgroundColor = UIColorWithRGB(0xF0F0F0);
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
    [butt setTitle:@"Save" forState:UIControlStateNormal];
    [butt setBackgroundColor:UIColorWithRGB(0x2D67FD)];
    butt.titleLabel.textColor = [UIColor whiteColor];
    [butt addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    butt.frame = CGRectMake(12, 30, ZHScreenW - 24, 50);
    [footView addSubview:butt];
    self.myTableView.tableFooterView = footView;
    
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTDetailsOneTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTDetailsOneTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTModifyTelOneTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTModifyTelOneTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTModifyMarkTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTModifyMarkTableViewCell class])];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void)save
{
    if (self.companyTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your company"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.telTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your tel"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.AddressTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your address"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    MTPersonMood *personMode = [MTPersonMood new];
    personMode = self.perMode;
    self.perMode.personTel = self.telTextFiled.text;
    self.perMode.personAddress = self.AddressTextFiled.text;
    self.perMode.personCompany = self.companyTextFiled.text;
    if (!self.markTextView.text) {
        self.perMode.personRemarks = @"";
    }else{
        self.perMode.personRemarks = self.markTextView.text;
    }
    NSMutableArray *myArr = [MTAddPutModeTool getAllCardMode:self.perMode.type];
    for (MTPersonMood *mode in myArr) {
        if ([mode.personName isEqualToString:self.perMode.personName]) {
            [myArr removeObject:mode];
        }
    }
    [myArr addObject:personMode];
    [MTAddPutModeTool putAllCardMode:myArr type:self.perMode.type];
    MTHomeViewController *con = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3];
    [con getData];
    [con view];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MTDetailsOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTDetailsOneTableViewCell class]) forIndexPath:indexPath];
        cell.perMode = self.perMode;
        return cell;
    }else if (indexPath.row == 1){
        MTModifyTelOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTModifyTelOneTableViewCell class]) forIndexPath:indexPath];
        cell.myLable.text = @"TEL:";
        self.telTextFiled = cell.myTextFild;
        cell.myTextFild.text = self.perMode.personTel;
        return cell;
    }else if (indexPath.row == 2){
        MTModifyTelOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTModifyTelOneTableViewCell class]) forIndexPath:indexPath];
        cell.myLable.text = @"Address:";
        self.AddressTextFiled = cell.myTextFild;
        cell.myTextFild.text = self.perMode.personAddress;
        return cell;
    }else if (indexPath.row == 3){
        MTModifyTelOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTModifyTelOneTableViewCell class]) forIndexPath:indexPath];
        cell.myLable.text = @"Company:";
        self.companyTextFiled = cell.myTextFild;
        cell.myTextFild.text = self.perMode.personCompany;
        return cell;
    }
    MTModifyMarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTModifyMarkTableViewCell class]) forIndexPath:indexPath];
    cell.modeTextView.text = self.perMode.personRemarks;
    self.markTextView = cell.modeTextView;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 202;
            break;
        case 1:
        case 2:
        case 3:
            return 44;
            break;
        default:
            return 150;
            break;
    }
}

@end
