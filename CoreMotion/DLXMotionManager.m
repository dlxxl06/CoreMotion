//
//  DLXMotionManager.m
//  CoreMotion
//
//  Created by admin on 15/9/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXMotionManager.h"

static DLXMotionManager *motionManager = nil;

@implementation DLXMotionManager

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        motionManager= [super allocWithZone:zone];
    });
    return motionManager;
}
+(instancetype)shareMotionManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        motionManager = [[super alloc]init];
    });
    return motionManager;
}
@end
