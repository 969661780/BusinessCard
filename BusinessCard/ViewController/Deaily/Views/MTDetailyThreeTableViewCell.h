//
//  MTDetailyThreeTableViewCell.h
//  BusinessCard
//
//  Created by mt y on 2018/7/4.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPersonMood.h"
@interface MTDetailyThreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *markLable;
@property (nonatomic, strong)MTPersonMood *perMode;
@end
