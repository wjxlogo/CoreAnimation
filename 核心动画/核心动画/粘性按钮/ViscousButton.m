                                              //
//  ViscousButton.m
//  核心动画
//
//  Created by WJX on 16/8/4.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "ViscousButton.h"
#import "NSObject+GooView.h"
@interface ViscousButton ()

/** 小圆半径*/
@property (nonatomic, assign) CGFloat  smallCircleR;

/** 大圆半径*/
@property (nonatomic, assign) CGFloat  bigCircleR;

/** 小圆的视图*/
@property (nonatomic, weak) UIView  *smallCircleView;

/** 圆的中心点*/
@property (nonatomic, assign) CGPoint  oriCenter;

/** 是否过界*/
@property (nonatomic, assign) BOOL isOverBorder;

@property (nonatomic, weak) CAShapeLayer *shapeLayer;;
@end

@implementation ViscousButton

#define maxDistance 90

// 粘性比例 0.9
#define gooRatio 0.7
#pragma mark - --- init 视图初始化 ---
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    CGFloat w =  self.bounds.size.width;
    self.layer.cornerRadius = w/2;
    self.clipsToBounds = YES;


    _smallCircleR = w/2;
    _bigCircleR = _smallCircleR;
    _oriCenter = self.center;
    self.titleLabel.font = [UIFont systemFontOfSize:11];

    UIPanGestureRecognizer  *pan  = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    // 设置小圆位置和尺寸
    self.smallCircleView.center = _oriCenter;
    self.smallCircleView.bounds = self.bounds;
    self.smallCircleView.layer.cornerRadius = w / 2;

}
#pragma mark - --- delegate 视图委托 ---

#pragma mark - --- event response 事件相应 ---
- (void)pan:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat d = [self centerDistanceWithBigCenter:self.center smallCenter:self.smallCircleView.center ];
        // 判断是否超出最大圆心距离
        if (d > maxDistance) {
            [self setUpBoom];
        }else{
            [self setUpRestore];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){
        // 获取手指偏移量
        CGPoint transP = [pan translationInView:self];
        CGPoint center = self.center;
        center.x += transP.x;
        center.y += transP.y;
        self.center = center;
        // 获取圆心距离
        CGFloat d = [self centerDistanceWithBigCenter:self.center smallCenter:self.smallCircleView.center];
        // 计算小圆半径：随机搞个比例，随着圆心距离增加，圆心半径不断减少。
        CGFloat smallRadius = _bigCircleR - d / 10;

        self.smallCircleView.bounds = CGRectMake(0, 0, smallRadius * 2, smallRadius * 2);
        self.smallCircleView.layer.cornerRadius = smallRadius;

        // 超过最大圆心距离,不需要描述形变矩形
        if (d > maxDistance ) {

            // 超过边界
            _isOverBorder = YES;

            // 隐藏小圆
            self.smallCircleView.hidden = YES;

            // 没有弹性效果
            [self.shapeLayer removeFromSuperlayer];


        }else if(d > 0 && _isOverBorder == NO){ // 否则设置小圆圆心，并且描述形变矩形

            self.smallCircleView.hidden = NO;
            self.smallCircleView.center = _oriCenter;
            self.shapeLayer.path = [self pathWithBigCenter:self.center bigRadius:_bigCircleR smallCenter:self.smallCircleView.center smallRadius:smallRadius].CGPath;

            [self.superview.layer insertSublayer:self.shapeLayer below:_smallCircleView.layer];
        }

        [pan setTranslation:CGPointZero inView:self];



    }
}

#pragma mark - --- private methods 私有方法 ---
// 还原
- (void)setUpRestore
{
    [self.shapeLayer removeFromSuperlayer];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        self.center = _oriCenter;

    } completion:^(BOOL finished) {
        _isOverBorder = NO;
        self.smallCircleView.hidden = NO;

    }];

}


// 爆炸效果
- (void)setUpBoom
{
    // 变成气泡消失
    UIImageView *imageView = [[UIImageView alloc] init];

    imageView.frame = CGRectMake(0, 0, _bigCircleR * 2, _bigCircleR * 2);

    [self addSubview:imageView];

    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [arr addObject:image];

    }

    imageView.animationImages = arr;

    imageView.animationDuration = 1.2;
    imageView.animationRepeatCount = 1;
    [imageView startAnimating];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
        [self removeFromSuperview];
    });
}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 —--

- (UIView *)smallCircleView
{
    if (_smallCircleView == nil) {

        UIView *smallCircleView = [[UIView alloc] init];

        _smallCircleView = smallCircleView;
        _smallCircleView.center = self.center;
        _smallCircleView.layer.cornerRadius = _smallCircleR;
        _smallCircleView.hidden = YES;
        _smallCircleView.backgroundColor = [UIColor redColor];

//        [self.superview addSubview:_smallCircleView];
//
        [self.superview insertSubview:smallCircleView belowSubview:self];

    }

    return _smallCircleView;
}
- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil) {

        CAShapeLayer *shapeL = [CAShapeLayer layer];

        shapeL.fillColor = [UIColor redColor].CGColor;

        _shapeLayer = shapeL;

    }
    return _shapeLayer;
}
@end
