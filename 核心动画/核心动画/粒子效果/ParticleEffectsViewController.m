//
//  ParticleEffectsViewController.m
//  核心动画
//
//  Created by WJX on 16/8/1.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "ParticleEffectsViewController.h"
#import "DrawView.h"

@interface ParticleEffectsViewController ()
/** obj*/
@property (nonatomic, strong, nullable) DrawView *drawView;


@end
@implementation ParticleEffectsViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad{
    self.navigationItem.title = @"粒子效果";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

#pragma mark - --- delegate 视图委托 ---
- (void)setupUI{

   UIButton * startBtn =  [self setButton:CGRectMake(50, 100, 60, 30) title:@"开始动画" target:@selector(startAnim)];
    [self.view addSubview:startBtn];
    UIButton * reDrawBtn= [self setButton:CGRectMake(self.view.bounds.size.width - 110, 100, 60, 30) title:@"重绘" target:@selector(reDraw)];
    [self.view addSubview:reDrawBtn];
    self.drawView    = [[DrawView alloc]initWithFrame:CGRectMake(0, 140, self.view.bounds.size.width, self.view.bounds.size.height-140)];
    [self.view addSubview:self.drawView];

}
#pragma mark - --- event response 事件相应 ---
- (void)startAnim{
    [_drawView startAnim];
}
- (void)reDraw{
    [_drawView reDraw];
}
#pragma mark - --- private methods 私有方法 ---*
- (UIButton *)setButton:(CGRect )frame title:(NSString * )title target:(SEL)target{
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = frame;
    [startBtn setTitle:title forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [startBtn addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
    return startBtn;
}
#pragma mark - --- getters and setters 属性 ---

@end
