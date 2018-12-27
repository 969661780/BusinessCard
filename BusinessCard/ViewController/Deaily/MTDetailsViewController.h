//
//  MTDetailsViewController.h
//  BusinessCard
//
//  Created by mt y on 2018/7/4.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPersonMood.h"
@interface MTDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)MTPersonMood *perMode;
@end
