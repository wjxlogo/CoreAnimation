//
//  VolumeShakeStripViewController.m
//  核心动画
//
//  Created by WJX on 16/8/1.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "VolumeShakeStripViewController.h"

@implementation VolumeShakeStripViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad{
    self.navigationItem.title = @"音量震动条";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];

}
#pragma mark - --- delegate 视图委托 ---
- (void)setupUI{
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];

    layer.frame = CGRectMake(100, 200, 200, 200);

    layer.backgroundColor = [UIColor lightGrayColor].CGColor;

    [self.view.layer addSublayer:layer];


    // 设置5个子层，4个复制层
    layer.instanceCount = 5;

    // 设置复制子层的相对位置，每个x轴相差40
    layer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);

    // 设置复制子层的延迟动画时长
    layer.instanceDelay = 0.3;
    
    [self setUpBar:layer];
}
#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---
- (void)setUpBar:(CALayer *)layer
{
    CALayer *bar = [CALayer layer];

    bar.backgroundColor = [UIColor redColor].CGColor;

    bar.bounds = CGRectMake(0, 0, 30, 100);

    bar.position = CGPointMake(15, 200);

    bar.anchorPoint = CGPointMake(0.5, 1);

    [layer addSublayer:bar];

    CABasicAnimation *anim = [CABasicAnimation animation];

    anim.keyPath = @"transform.scale.y";

    anim.toValue = @(0.1);

    anim.autoreverses = YES;

    anim.repeatCount = MAXFLOAT;

    [bar addAnimation:anim forKey:nil];
}
#pragma mark - --- getters and setters 属性 ---

@end
