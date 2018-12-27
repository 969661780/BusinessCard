//
//  MTAddPutModeTool.m
//  BusinessCard
//
//  Created by mt y on 2018/7/3.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTAddPutModeTool.h"

@implementation MTAddPutModeTool
+ (NSMutableArray *)getAllCardMode:(NSString *)type
{
     NSData *arrData = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.plist",type]]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:arrData];
    NSArray *DataArr = [unarchiver decodeObjectForKey:type];
    NSMutableArray *myDataAr = [NSMutableArray arrayWithArray:DataArr];
    return myDataAr;
}
+ (void)putAllCardMode:(NSArray *)arr type:(NSString *)type
{
    NSMutableData *mudata = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mudata];
    [archiver encodeObject:arr forKey:type];
    [archiver finishEncoding];
    [mudata writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.plist",type]] atomically:YES];
}
@end
