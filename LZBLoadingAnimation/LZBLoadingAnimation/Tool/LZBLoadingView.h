//
//  LZBLoadingView.h
//  LZBLoadingAnimation
//
//  Created by zibin on 16/10/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZBLoadingView : UIView

/**
 *  加载Boss直聘动画
 */
+ (void)showLoadingViewFourRoundInView:(UIView *)superView;

/**
 *  加载Boss直聘动画
 */
+ (void)showLoadingFourRoundView;


/**
 *  加载常用圆形动画
 */
+ (void)showLoadingViewDefautRoundInView:(UIView *)superView;

/**
 *  加载常用圆形动画
 */
+ (void)showLoadingDefautRoundView;

/**
 *  移除动画
 */
+ (void)dismissLoadingView;

@end
