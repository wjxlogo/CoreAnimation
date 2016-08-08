//
//  ViewController.m
//  核心动画
//
//  Created by WJX on 16/8/1.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "ViewController.h"
#import "FoldImageViewController.h"
#import "VolumeShakeStripViewController.h"
#import "ActivityIndicateViewController.h"
#import "ParticleEffectsViewController.h"
#import "ReflectionViewController.h"
#import "ViscousButtonViewController.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
/** obj*/
@property (nonatomic, strong, nullable) UITableView  *tableView;

@end

@implementation ViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"核心动画";
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *dif = @"Cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:dif];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dif];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"折叠图片";
            break;
        case 1:
            cell.textLabel.text = @"音量震动条";
            break;
        case 2:
            cell.textLabel.text = @"活动指示器";
            break;
        case 3:
            cell.textLabel.text = @"粒子效果";
            break;
        case 4:
            cell.textLabel.text = @"倒影效果";
            break;
        case 5:
            cell.textLabel.text = @"QQ粘性按钮效果";
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {

        [ self.navigationController  pushViewController:[FoldImageViewController new] animated:YES];

    }else if (indexPath.row == 1){
        [ self.navigationController  pushViewController:[VolumeShakeStripViewController new] animated:YES];
    }else if (indexPath.row == 2){
        [ self.navigationController  pushViewController:[ActivityIndicateViewController new] animated:YES];
    }else if (indexPath.row == 3){
        [ self.navigationController  pushViewController:[ParticleEffectsViewController new] animated:YES];
    }else if (indexPath.row == 4){
        [ self.navigationController  pushViewController:[ReflectionViewController new] animated:YES];
    }else if (indexPath.row == 5){
        [ self.navigationController  pushViewController:[ViscousButtonViewController new] animated:YES];
    }else if (indexPath.row == 6){
//        [ self.navigationController  pushViewController:[ImageWatermarkViewController new] animated:YES];
    }else if (indexPath.row == 7){
//        [ self.navigationController  pushViewController:[ImageClipViewController new] animated:YES];
    }else if (indexPath.row == 8){
//        [ self.navigationController  pushViewController:[ScreenCaptureViewController new] animated:YES];
    }else if (indexPath.row == 9){
//        [ self.navigationController  pushViewController:[ImageCaptureViewController new] animated:YES];
    }else if (indexPath.row == 10){
//        [ self.navigationController  pushViewController:[LockViewController new] animated:YES];
    }
    
    
    
}


#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
