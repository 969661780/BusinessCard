//
//  MTDetailsOneTableViewCell.m
//  BusinessCard
//
//  Created by mt y on 2018/7/4.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTDetailsOneTableViewCell.h"

@implementation MTDetailsOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myImageView.layer.cornerRadius = 39.5;
    self.myImageView.layer.masksToBounds = YES;
    self.jobLable.layer.cornerRadius = 11;
    self.jobLable.layer.masksToBounds = YES;
}

- (void)setPerMode:(MTPersonMood *)perMode
{
    _perMode = perMode;
    self.myImageView.image = perMode.headImge;
    self.nameLable.text = perMode.personName;
    self.jobLable.text = perMode.personPosition;
}
@end
