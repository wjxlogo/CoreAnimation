//
//  ReflectionViewController.m
//  核心动画
//
//  Created by WJX on 16/8/3.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "ReflectionViewController.h"
#import "ReflectionView.h"
@interface ReflectionViewController ()
/** obj*/
@property (nonatomic, strong, nullable) ReflectionView  *reView;

@end

@implementation ReflectionViewController

#pragma mark - --- lift cycle 生命周期 ---
-(void)viewDidLoad{
    self.navigationItem.title = @"倒影效果";
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.reView ];

    [self setupUI];
}
#pragma mark - --- delegate 视图委托 ---
- (void)setupUI{
     CAReplicatorLayer *layer = (CAReplicatorLayer *)self.reView.layer;
     layer.instanceCount = 2 ;
    CATransform3D tranform = CATransform3DMakeTranslation(0, self.reView.bounds.size.height, 0);
    tranform  = CATransform3DRotate(tranform, M_PI, 1, 0, 0);
    layer.instanceTransform = tranform;
    layer.instanceRedOffset = - 0.1;
    layer.instanceGreenOffset = - 0.1;
    layer.instanceBlueOffset = - 0.1;
    layer.instanceAlphaOffset = - 0.1;

}
#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---

- (ReflectionView *)reView{
    if (!_reView) {
        _reView =  [[ReflectionView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        imageView.image = [UIImage imageNamed:@"头像"];
        [_reView addSubview:imageView];
    }
    return _reView;
}
@end
