//
//  ContactCell.m
//  Contacts
//
//  Created by emma on 15/6/18.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myHeadImage.layer.cornerRadius = 3;
    self.myHeadImage.layer.masksToBounds = YES;
    self.numbereLable.layer.cornerRadius = 16;
    self.numbereLable.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
