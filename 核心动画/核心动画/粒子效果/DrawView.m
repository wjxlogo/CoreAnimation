//
//  DrawView.m
//  核心动画
//
//  Created by WJX on 16/8/1.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "DrawView.h"
@interface DrawView()

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) CGPoint startP;

@property (nonatomic, weak)  CALayer *dotLayer;

//@property (nonatomic, assign) CGPoint oriP;

@end
@implementation DrawView
#pragma mark - --- init 视图初始化 ---
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];

    }
    return self;
}
#pragma mark - --- delegate 视图委托 ---
- (void)setupUI{

    self.backgroundColor = [UIColor lightGrayColor];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    // 创建复制图层
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];

    repLayer.frame = self.bounds;

    [self.layer addSublayer:repLayer];

    [self particle:repLayer];
    repLayer.instanceCount = 20;
    repLayer.instanceDelay = 4 / 20.0;

    // 设置子层颜色
    repLayer.instanceColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1].CGColor;

    // 设置子层颜色绿色通道偏移量
    repLayer.instanceGreenOffset = -0.03;

}
- (void)drawRect:(CGRect)rect{
     [self.path stroke];
}
#pragma mark - --- event response 事件相应 ---
- (void)pan:(UIPanGestureRecognizer *)pan{
      CGPoint curP = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        _startP = curP;
        [self.path moveToPoint:_startP];
    }
    [self.path addLineToPoint:curP];
    [self setNeedsDisplay];
}
#pragma mark - --- private methods 私有方法 ---
- (void)startAnim{
    CAKeyframeAnimation * anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.duration = 4;
    anim.path = self.path.CGPath;
    anim.repeatCount = MAXFLOAT;
    [_dotLayer addAnimation:anim forKey:@"anim"];
    anim.delegate = self;

}
- (void)reDraw{
    _path = nil;
    [_dotLayer removeAnimationForKey:@"anim"];
    [self setNeedsDisplay];
}
- (void)particle:(CALayer *)repLayer{
    CALayer *layer = [CALayer layer];

    layer.cornerRadius = 5;

    layer.frame = CGRectMake(-100, 10, 10, 10);

    layer.backgroundColor = [UIColor whiteColor].CGColor;

    [repLayer addSublayer:layer];
    _dotLayer = layer;

}
#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 —--
- (UIBezierPath *)path{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}


@end
