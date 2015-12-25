//
//  DLXMotionManager.h
//  CoreMotion
//
//  Created by admin on 15/9/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

@interface DLXMotionManager : CMMotionManager
+(instancetype)shareMotionManager;
@end
