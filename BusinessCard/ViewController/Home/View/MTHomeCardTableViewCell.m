//
//  MTHomeCardTableViewCell.m
//  BusinessCard
//
//  Created by mt y on 2018/7/2.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTHomeCardTableViewCell.h"

@implementation MTHomeCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.jobLable.layer.borderColor = UIColorWithRGB(0xEA5D32).CGColor;
    self.jobLable.layer.borderWidth = 0.5;
    
}
- (IBAction)btnse:(UIButton *)sender {
    if (self.btnBlock) {
        self.btnBlock();
    }
}

- (void)setPersonMode:(MTPersonMood *)personMode
{
    _personMode = personMode;
    self.myImageView.image = personMode.headImge;
    self.myNameLable.text = personMode.personName;
    self.myJobLable.text = personMode.personPosition;
    self.telLable.text = personMode.personTel;
    self.addressLable.text = personMode.personAddress;
    self.companyLable.text = personMode.personCompany;
}

@end
