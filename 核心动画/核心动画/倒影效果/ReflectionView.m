//
//  ReflectionView.m
//  核心动画
//
//  Created by WJX on 16/8/3.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "ReflectionView.h"

@implementation ReflectionView
+ (Class)layerClass{
    return [ CAReplicatorLayer class];
}
@end
