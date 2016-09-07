//
//  LLURLNavgation.h
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/3.
//  Copyright © 2016年 Hailang. All rights reserved.
//  控制器 导航控制器管理

#import <UIKit/UIKit.h>
#import "LLSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLURLNavigation : NSObject

LLSingletonH(LLURLNavigation)

/**
 *  返回当前控制器
 */
- (UIViewController *)currentViewController;

/**
 *  返回当前的导航控制器
 */
- (UINavigationController *)currentNavigationViewController;

/**
 *  push到控制器
 *
 *  @param ViewController 控制器名称
 *  @param animated
 *  @param replace        跳转控制器是否是当前控制器
 */
+ (void)pushViewController:(UIViewController *)ViewController animated:(BOOL)animated replace:(BOOL)replace;

/**
 *  present控制器
 *
 *  @param ViewController 控制器名称
 *  @param animated       <#animated description#>
 *  @param complation     present结束后的回调
 */
+ (void)presentViewController:(UIViewController *)ViewController animated:(BOOL)animated completion:(void (^ __nullable)(void))complation;

+ (void)popTwiceViewControllerAnimated:(BOOL)animated;

+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated;

+ (void)popToRootViewControllerAnimated:(BOOL)animated;

+ (void)dismissTwiceViewControllerAnimated: (BOOL)animated completion:(void(^ __nullable)(void))completion;

+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated: (BOOL)animated completion: (void (^ __nullable)(void))completion;

+ (void)dismissToRootViewControllerAnimated: (BOOL)animated completion: (void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END