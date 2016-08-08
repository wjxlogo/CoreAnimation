//
//  ActivityIndicateViewController.m
//  核心动画
//
//  Created by WJX on 16/8/1.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "ActivityIndicateViewController.h"

@implementation ActivityIndicateViewController
static     CGFloat durtion = 1;
#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad{
    self.navigationItem.title = @"活动指示器";
    self.view.backgroundColor = [UIColor  whiteColor];
    [self setupUI];

}

#pragma mark - --- delegate 视图委托 ---
- (void)setupUI{
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = CGRectMake(100, 200, 200, 200);

    replicator.backgroundColor = [UIColor lightGrayColor].CGColor;

    [self.view.layer addSublayer:replicator];

    int count = 20;
    // 设置子层次数
    replicator.instanceCount = count;

    // 设置子层动画延长时间
    replicator.instanceDelay = durtion / count;
    // 设置子层形变角度
    CGFloat angle = M_PI * 2 / count;
    replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [self indicator:replicator];
}
#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---
- (void)indicator:(CALayer *)layer
{

    CALayer *indicator = [CALayer layer];

    indicator.transform = CATransform3DMakeScale(0, 0, 0);

    indicator.position = CGPointMake(100, 20);

    indicator.bounds = CGRectMake(0, 0, 10, 10);

    indicator.backgroundColor = [UIColor whiteColor].CGColor;

    [layer addSublayer:indicator];


    CABasicAnimation *anim = [CABasicAnimation animation];

    anim.keyPath = @"transform.scale";
    anim.fromValue = @1;
    anim.toValue = @0.1;

    anim.repeatCount = MAXFLOAT;

    anim.duration = durtion;

    [indicator addAnimation:anim forKey:nil];
}
#pragma mark - --- getters and setters 属性 ---
@end
