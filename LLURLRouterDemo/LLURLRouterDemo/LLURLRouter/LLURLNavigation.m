//
//  LLURLNavigation.m
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/3.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import "LLURLNavigation.h"

@implementation LLURLNavigation
LLSingletonM(LLURLNavigation)

- (id<UIApplicationDelegate>)applicationDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (UIViewController *)currentViewController
{
    UIViewController *rootViewController = self.applicationDelegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

- (UINavigationController *)currentNavigationViewController
{
    UIViewController *currentViewController= self.currentViewController;
    
    return currentViewController.navigationController;
}

+ (void)pushViewController:(UIViewController *)ViewController animated:(BOOL)animated replace:(BOOL)replace
{
    if (!ViewController) {
        NSAssert(0, @"请添加与url相匹配的控制器到plist文件中,或者协议头可能写错了!");
    }
    else
    {
        if ([ViewController isKindOfClass:[UINavigationController class]]) {
            // 如果是导航控制器直接设置为根控制器
            [LLURLNavigation setRootNavigationController:ViewController];
        }
        else
        {
            UINavigationController *navigationController = [LLURLNavigation shareLLURLNavigation].currentNavigationViewController;
            if (navigationController) {  // 导航控制器存在
                if (replace && [navigationController.viewControllers.lastObject isKindOfClass:[ViewController class]]) {
                    NSArray *viewControllers = [navigationController.viewControllers subarrayWithRange:NSMakeRange(0, navigationController.viewControllers.count - 1)];
                    [navigationController setViewControllers:[viewControllers arrayByAddingObject:ViewController] animated:animated];
                }// 切换当前导航控制器 需要把原来的子控制器都取出来重新添加
                else   //进行push
                {
                    [navigationController pushViewController:ViewController animated:animated];
                }
            }
            else  // 如果导航控制器不存在,就会创建一个新的,设置为根控制器
            {
                navigationController = [[UINavigationController alloc] initWithRootViewController:ViewController];
                [LLURLNavigation shareLLURLNavigation].applicationDelegate.window.rootViewController = navigationController;
            }
        }
    }
}

+ (void)presentViewController:(UIViewController *)ViewController animated:(BOOL)animated completion:(void (^ __nullable)(void))complation
{
    if (!ViewController) {
        NSAssert(0, @"请添加与url相匹配的控制器到plist文件中,或者协议头可能写错了!");
    }
    else
    {
        UIViewController *currentViewController = [LLURLNavigation shareLLURLNavigation].currentViewController;
        if (currentViewController) {  // 当前控制器存在
            [currentViewController presentViewController:ViewController animated:animated completion:complation];
        }
        else  // 将控制器设置为根控制器
        {
            [LLURLNavigation shareLLURLNavigation].applicationDelegate.window.rootViewController = ViewController;
        }
    }
}

+ (void)popTwiceViewControllerAnimated:(BOOL)animated
{
    [LLURLNavigation popViewControllerWithTimes:2 animated:animated];
}

+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated
{
    UIViewController *currentViewController = [LLURLNavigation shareLLURLNavigation].currentViewController;
    if (currentViewController) {
        if (currentViewController.navigationController) {
            NSUInteger count = currentViewController.navigationController.viewControllers.count;
            if (count > times) {
                [currentViewController.navigationController popToViewController:[currentViewController.navigationController.viewControllers objectAtIndex:count - times - 1] animated:animated];
            }else
            {
                NSAssert(0, @"没有足够的控制器去pop");
            }
        }
    }
}

+ (void)popToRootViewControllerAnimated:(BOOL)animated
{
    UIViewController *currentViewController = [LLURLNavigation shareLLURLNavigation].currentViewController;
    if (currentViewController.navigationController) {
       NSUInteger count = currentViewController.navigationController.viewControllers.count;
        [LLURLNavigation popViewControllerWithTimes:count - 1 animated:animated];
    }
}

+ (void)dismissTwiceViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self dismissViewControllerWithTimes:2 animated:animated completion:completion];
}

+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *rootVc = [[LLURLNavigation shareLLURLNavigation] currentViewController];
    if (rootVc) {
        while (times > 0) {
            rootVc = rootVc.presentingViewController;
            times -= 1;
            [rootVc dismissViewControllerAnimated:animated completion:completion];
        }
    }
    if (!rootVc.presentingViewController) {
        NSAssert(0, @"确定能dismiss掉这么多控制器?");
    }
}

+ (void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *currentViewController = [LLURLNavigation shareLLURLNavigation].currentViewController;
    while (currentViewController.presentingViewController) {
        currentViewController = currentViewController.presentingViewController;
    }
    [currentViewController dismissViewControllerAnimated:animated completion:completion];
}

#pragma mark - private method

// 设置为根控制器
+ (void)setRootNavigationController:(UIViewController *)viewController
{
    [LLURLNavigation shareLLURLNavigation].applicationDelegate.window.rootViewController = viewController;
}

// 通过递归拿到当前控制器
- (UIViewController *)currentViewControllerFrom:(UIViewController *)viewController
{
    // 如果传入的控制器是导航控制器,则返回最后一个
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if ([viewController isKindOfClass:[UITabBarController class]])// 如果传入的控制器是tabBar控制器,则返回选中的那个
    {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) // 如果传入的控制器发生了modal,则就可以拿到modal的那个控制器
    {
        return [self currentViewControllerFrom:viewController.presentingViewController];
    }
    else
    {
        return viewController;
    }
}

@end
