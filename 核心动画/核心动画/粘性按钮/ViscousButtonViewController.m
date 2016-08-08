//
//  ViscousButtonViewController.m
//  核心动画
//
//  Created by WJX on 16/8/3.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "ViscousButtonViewController.h"
#import "ViscousButton.h"

@interface ViscousButtonViewController ()

/** obj*/
@property (nonatomic, strong, nullable) ViscousButton  *vButton;

@end

@implementation ViscousButtonViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad{
    [self setupUI];
}
#pragma mark - --- delegate 视图委托 ---
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.vButton];
}

#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---
- (ViscousButton *)vButton  {
    if (!_vButton ) {
        _vButton = [[ViscousButton alloc]initWithFrame:CGRectMake(100, 220, 20, 20)];
        _vButton.backgroundColor = [UIColor redColor];
        [_vButton setTitle:@"11" forState:UIControlStateNormal];
        [_vButton   setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _vButton;
}
@end
