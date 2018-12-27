//
//  MTDetailsViewController.m
//  BusinessCard
//
//  Created by mt y on 2018/7/4.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTDetailsViewController.h"
#import "MTDetailsOneTableViewCell.h"
#import "MTDetailsyTwoTableViewCell.h"
#import "MTDetailyThreeTableViewCell.h"
#import "MTModifyViewController.h"
#import "WBNativityShare.h"
#import <Social/Social.h>
@interface MTDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MTDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Details";
    
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, ZHScreenW, ZHScreenH - 352 - 44*3);
    footView.backgroundColor = UIColorWithRGB(0xF0F0F0);
    self.myTableView.tableFooterView = footView;
    
    UIImage *selectedImage=[UIImage imageNamed: @"cbl"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBtn)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTDetailsOneTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTDetailsOneTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTDetailsyTwoTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTDetailsyTwoTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTDetailyThreeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTDetailyThreeTableViewCell class])];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}
#pragma mark -touch
- (void)rightBtn
{
    UIAlertController *alertController = [[UIAlertController alloc]init];
    
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MTModifyViewController *con = [MTModifyViewController new];
        con.perMode = self.perMode;
        [self.navigationController pushViewController:con animated:YES];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *appid = @"1402682615";
        NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",appid];
        
        
        NSDictionary *par = @{@"shareUrl":url};
        [WBNativityShare WBSystemCallShareWithController:self par:par];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
   [self presentViewController:alertController animated:YES completion:nil];
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
        MTDetailsyTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTDetailsyTwoTableViewCell class]) forIndexPath:indexPath];
        cell.nameLable.text = @"TEL:";
        cell.detailyLable.text = self.perMode.personTel;
        return cell;
    }else if (indexPath.row == 2){
        MTDetailsyTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTDetailsyTwoTableViewCell class]) forIndexPath:indexPath];
        cell.nameLable.text = @"Address:";
        cell.detailyLable.text = self.perMode.personAddress;
        return cell;
    }else if (indexPath.row == 3){
        MTDetailsyTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTDetailsyTwoTableViewCell class]) forIndexPath:indexPath];
        cell.nameLable.text = @"Company:";
        cell.detailyLable.text = self.perMode.personCompany;
        return cell;
    }
    MTDetailyThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTDetailyThreeTableViewCell class]) forIndexPath:indexPath];
    cell.markLable.text = self.perMode.personRemarks;
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
