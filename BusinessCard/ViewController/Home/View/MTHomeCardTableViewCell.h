//
//  MTHomeCardTableViewCell.h
//  BusinessCard
//
//  Created by mt y on 2018/7/2.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPersonMood.h"
typedef void(^myBlock)(void);

@interface MTHomeCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobLable;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myNameLable;
@property (weak, nonatomic) IBOutlet UILabel *myJobLable;
@property (weak, nonatomic) IBOutlet UILabel *telLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *companyLable;
@property (nonatomic, copy)myBlock btnBlock;

@property (nonatomic, strong)MTPersonMood *personMode;
@end
