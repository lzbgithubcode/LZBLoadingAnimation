//
//  LZBLoadingAnimation.m
//  LZBLoadingAnimation
//
//  Created by zibin on 16/10/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBLoadingAnimation.h"
#import <UIKit/UIKit.h>

static CGFloat _progress = 0;

static CADisplayLink *_displayTimer;

@implementation LZBLoadingAnimation
+ (CALayer *)loadingReplicatorLayer_SquareWithWidth:(CGFloat)width
{
    //创建单个圆
    CGFloat sigleSquareDiameter = 20;
    CAShapeLayer *shape = [self creatShapeLayerWithRadius:sigleSquareDiameter];
    [shape addAnimation:[self addReplicatorLayerRotationAnimaitonWithTranslateX:width - sigleSquareDiameter] forKey:@"rotation"];
    
    //复制多个同样的圆
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D = CATransform3DRotate(transform3D, 90.0*M_PI/180.0, 0, 0, 1.0);
    CAReplicatorLayer *replicatorLayer = [self creatReplicatorLayerWithCount:4 tranform:transform3D copyLayer:shape];
    return replicatorLayer;
}


+ (CALayer *)loadingReplicatorLayer_RoundDot
{
    //创建单个圆
    CGFloat sigleSquareDiameter = 15;
    CAShapeLayer *shape = [self creatShapeLayerWithRadius:sigleSquareDiameter];
    [shape addAnimation:[self addReplicatorLayerScaleAnition] forKey:@"scale"];
    shape.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    //复制多个同样的圆
    NSInteger instanceCount = 10;
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D = CATransform3DRotate(transform3D, 2*M_PI/instanceCount, 0, 0, 1.0);
     CAReplicatorLayer *replicatorLayer = [self creatReplicatorLayerWithCount:instanceCount tranform:transform3D copyLayer:shape];
    replicatorLayer.instanceDelay = 1.0/instanceCount;
    
    return replicatorLayer;
}

+ (CALayer *)loadingReplicatorLayer_RoundLineRadius:(CGFloat)radius
{
    //创建圆弧
    CAShapeLayer *shapeCircle = [CAShapeLayer layer];
    shapeCircle.frame = CGRectMake(0, 0, radius, radius);
    UIBezierPath *bezierPath =[UIBezierPath bezierPathWithArcCenter:CGPointMake(radius * 0.5, radius * 0.5) radius:radius*0.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    shapeCircle.path = bezierPath.CGPath;
    shapeCircle.strokeColor = [UIColor blackColor].CGColor;
    shapeCircle.lineWidth = 5;
    shapeCircle.fillColor = [UIColor clearColor].CGColor;
    shapeCircle.strokeStart=0;
    shapeCircle.strokeEnd = 0;
    _progress = 0.0;
    
    //iOS10.0方法
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _progress +=0.033;
        if (_progress>=1.f) {
            _progress = 1.0;
            [timer invalidate];
            timer = nil;
        }
        shapeCircle.strokeEnd = _progress;
    }];
    
    return shapeCircle;
}

+ (CABasicAnimation *)addReplicatorLayerScaleAnition
{
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basic.repeatCount = MAXFLOAT;
    basic.fromValue = @1;
    basic.toValue = @0;
    basic.duration = 1.0;
    return basic;
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

#pragma mark - 创建Layer
+ (CAShapeLayer *)creatShapeLayerWithRadius:(CGFloat)radius
{
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.strokeColor = [UIColor blackColor].CGColor;
    shape.fillColor = [UIColor blackColor].CGColor;
    return shape;
}

+ (CAReplicatorLayer *)creatReplicatorLayerWithCount:(NSInteger)count tranform:(CATransform3D) transform  copyLayer:(CALayer*)copyLayer
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = count;
    replicatorLayer.instanceTransform = transform;
    replicatorLayer.frame = copyLayer.frame;
    [replicatorLayer addSublayer:copyLayer];
    return replicatorLayer;
}
@end
