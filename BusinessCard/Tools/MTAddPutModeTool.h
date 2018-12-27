//
//  MTAddPutModeTool.h
//  BusinessCard
//
//  Created by mt y on 2018/7/3.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTAddPutModeTool : NSObject
+ (NSMutableArray *)getAllCardMode:(NSString *)type;
+ (void)putAllCardMode:(NSArray *)arr type:(NSString *)type;
@end
