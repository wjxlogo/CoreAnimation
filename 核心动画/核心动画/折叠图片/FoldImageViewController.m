//
//  FoldImageViewController.m
//  核心动画
//
//  Created by WJX on 16/8/1.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "FoldImageViewController.h"
@interface FoldImageViewController()
/** obj*/
@property (nonatomic, strong, nullable) UIView  *containView;


/** obj*/
@property (nonatomic, strong, nullable) UIImageView  *topImageView;

@property (nonatomic, strong, nullable) UIImageView  *bottomImageView;

/** obj*/
@property (nonatomic, strong, nullable) CAGradientLayer  *shadowLayer;


@end
@implementation FoldImageViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad{
    self.navigationItem.title = @"图片折叠";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupUI];
}

#pragma mark - --- delegate 视图委托 ---
- (void)setupUI{
    [self.view addSubview:self.bottomImageView];
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.containView];
    UIPanGestureRecognizer   *pan = [[UIPanGestureRecognizer  alloc]initWithTarget:self action:@selector(pan:)];
    [self.containView addGestureRecognizer:pan];


    CAGradientLayer  *shadowLayer = [CAGradientLayer layer ];
    shadowLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    shadowLayer.frame = self.bottomImageView.bounds;
    _shadowLayer = shadowLayer;
    shadowLayer.opacity   = 0;
    [self.bottomImageView.layer addSublayer:shadowLayer];

}

#pragma mark - --- event response 事件相应 ---
- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint transP = [pan translationInView:self.containView];
    CATransform3D transform3D = CATransform3DIdentity;

    // 设置M34就有立体感(近大远小)。 -1 / z ,z表示观察者在z轴上的值,z越小，看起来离我们越近，东西越大。
    transform3D.m34 = -1/1000.0;
    // 注意角度需要为负，逆时针旋转，往里是顺时针，我们需要往外。
    CGFloat angle = -transP.y/200.0 *M_PI;
    self.topImageView.layer.transform   = CATransform3DRotate(transform3D, angle, 1, 0, 0);
    self.shadowLayer.opacity   = transP.y/200.0;

    if (pan.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.topImageView.layer.transform = CATransform3DIdentity;
            self.shadowLayer.opacity   = 0;
        } completion:^(BOOL finished) {

        }];
    }


}
#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---
- (UIView *)containView{
    if (!_containView) {
        _containView = [[UIView alloc]initWithFrame:CGRectMake(100, 150, 200, 200)];
    }
    return _containView;

}
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 100)];
        _topImageView.image = [UIImage imageNamed:@"头像"];
//        CGRectMake(0, 0, 1, 0.5) : 表示显示上半部分
        _topImageView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
        _topImageView.layer.anchorPoint = CGPointMake(0.5, 1);

    }

    return _topImageView;
}

- (UIImageView *)bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 100)];
        _bottomImageView.image = [UIImage imageNamed:@"头像"];
//                CGRectMake(0, 0.5, 1, 0.5) : 表示显示下半部分
        _bottomImageView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
        _bottomImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    }

    return _bottomImageView;
}

@end
