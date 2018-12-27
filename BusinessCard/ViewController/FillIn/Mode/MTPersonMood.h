//
//  MTPersonMood.h
//  BusinessCard
//
//  Created by mt y on 2018/7/3.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTPersonMood : NSObject

@property (nonatomic, copy)NSString *personName;
@property (nonatomic, copy)NSString *personPosition;
@property (nonatomic, copy)NSString *personTel;
@property (nonatomic, copy)NSString *personAddress;
@property (nonatomic, copy)NSString *personCompany;
@property (nonatomic, copy)NSString *personRemarks;
@property (nonatomic, strong)UIImage *headImge;
@property (nonatomic, copy)NSString *type;

@property NSInteger sectionNumber;  // Index
@end
