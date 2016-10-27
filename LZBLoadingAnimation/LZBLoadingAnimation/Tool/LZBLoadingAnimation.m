//
//  LZBLoadingAnimation.m
//  LZBLoadingAnimation
//
//  Created by zibin on 16/10/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBLoadingAnimation.h"
#import <UIKit/UIKit.h>

@implementation LZBLoadingAnimation
+ (CALayer *)loadingReplicatorLayer_SquareWithWidth:(CGFloat)width
{
    //创建单个圆
    CGFloat sigleSquareDiameter = 20;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, sigleSquareDiameter, sigleSquareDiameter);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sigleSquareDiameter, sigleSquareDiameter)].CGPath;
    shape.strokeColor = [UIColor blackColor].CGColor;
    shape.fillColor = [UIColor blackColor].CGColor;
    [shape addAnimation:[self addReplicatorLayerRotationAnimaitonWithTranslateX:width - sigleSquareDiameter] forKey:@"rotation"];
    
    //复制多个同样的圆
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = 4;
    replicatorLayer.instanceDelay = 0.0;
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D = CATransform3DRotate(transform3D, 90.0*M_PI/180.0, 0, 0, 1.0);
    replicatorLayer.instanceTransform = transform3D;
    replicatorLayer.frame = shape.frame;
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
}

+ (CABasicAnimation *)addReplicatorLayerRotationAnimaitonWithTranslateX:(CGFloat)translateX
{
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0, 0, 0, 0);
    basic.fromValue = [NSValue valueWithCATransform3D:fromValue];
    
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, translateX, 0, 0);
     toValue = CATransform3DRotate(toValue, 90.0*M_PI/180.0, 0, 0, 1.0);
    basic.toValue = [NSValue valueWithCATransform3D:toValue];
    basic.autoreverses = NO;
    basic.repeatCount = HUGE;
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basic.duration = 1.5;
    return basic;
}
@end
