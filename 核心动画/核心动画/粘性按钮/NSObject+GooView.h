//
//  NSObject+GooView.h
//  核心动画
//
//  Created by WJX on 16/8/8.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (GooView)
//圆心距离
- (CGFloat)centerDistanceWithBigCenter:(CGPoint)bigCenter smallCenter:(CGPoint)smallCenter;

// 描述形变路径
- (UIBezierPath *)pathWithBigCenter:(CGPoint)bigCenter bigRadius:(CGFloat)bigRadius smallCenter:(CGPoint)smallCenter smallRadius:(CGFloat)smallRadius;

@end
