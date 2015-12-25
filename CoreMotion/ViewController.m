//
//  ViewController.m
//  CoreMotion
//
//  Created by admin on 15/9/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "DLXMotionManager.h"

@interface ViewController ()
{
    CMMotionManager *_motionManager;
    UIImageView *_ballView;
    NSOperationQueue *_queue;
    CGPoint _vt;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _motionManager = [DLXMotionManager shareMotionManager];
    
    _ballView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,50, 50)];
    [_ballView setCenter:self.view.center];
    [_ballView setImage:[UIImage imageNamed:@"black.png"]];
    [self.view addSubview:_ballView];
    _queue = [[NSOperationQueue alloc]init];
    
    [self startMotion];
    
}
#pragma mark -开始采样
-(void)startMotion
{
    if (![_motionManager isAccelerometerAvailable])
    {
        return;
    }
    //设置加速计更新频率
    [_motionManager setAccelerometerUpdateInterval:1/30.0];
    
    //开启加速计
    [_motionManager startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        _vt.x+=accelerometerData.acceleration.x;
        _vt.y-=accelerometerData.acceleration.y;
    }];
}
-(void)updateBallPosition
{
    CGPoint curPnt = _ballView.center;
    if (CGRectGetMinX(_ballView.frame)<0)
    {
        _vt.x*=(-1);
        curPnt.x = _ballView.bounds.size.width*0.5;
    }
    if (CGRectGetMaxX(_ballView.frame)>self.view.bounds.size.width) {
        _vt.x*=(-1);
        curPnt.x = self.view.bounds.size.width-_ballView.bounds.size.width*0.5;
    }
    if (CGRectGetMinY(_ballView.frame)<0) {
        _vt.y*=(-1);
        curPnt.y = _ballView.bounds.size.height*0.5;
    }
    if (CGRectGetMaxY(_ballView.frame)>self.view.bounds.size.height) {
        _vt.y*=(-1);
        curPnt.y = self.view.bounds.size.height-_ballView.bounds.size.height*0.5;
    }
    [_ballView setCenter:CGPointMake(curPnt.x+_vt.x, curPnt.y+_vt.y)];
}
@end
