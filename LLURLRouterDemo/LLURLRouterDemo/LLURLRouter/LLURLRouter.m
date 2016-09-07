//
//  LLURLRouter.m
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/3.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import "LLURLRouter.h"
#import "LLURLNavigation.h"

@interface LLURLRouter ()

/** 存储读取的plist文件数据 */
@property (nonatomic, strong) NSDictionary *configDict;

@end


@implementation LLURLRouter

LLSingletonM(LLURLRouter)

+ (void)initialize
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LLURLRouter.plist" ofType:nil];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDict) {
        [LLURLRouter shareLLURLRouter].configDict = configDict;
    }
    else
    {
        NSAssert(0, @"请按照说明添加对应的plist文件");
    }
}

+ (void)loadConfigDictWithPlistName:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSLog(@"configDict = %@",configDict);
    
    if (configDict) {
        [LLURLRouter shareLLURLRouter].configDict = configDict;
    }
    else
    {
        NSAssert(0, @"请按照说明添加对应的plist文件");
    }
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [LLURLNavigation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace
{
    [LLURLNavigation pushViewController:viewController animated:animated replace:replace];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated
{
    [self pushURLString:urlString animated:animated replace:NO];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replace:(BOOL)replace
{
    UIViewController *viewController = [UIViewController initWithString:urlString withConfig:[LLURLRouter shareLLURLRouter].configDict];
    
    [LLURLNavigation pushViewController:viewController animated:animated replace:replace];
}

+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated replace:(BOOL)replace
{
    UIViewController *viewController = [UIViewController initWithString:urlString withQuery:query withConfig:[LLURLRouter shareLLURLRouter].configDict];
    [LLURLNavigation pushViewController:viewController animated:animated replace:replace];
}

+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated
{
    [self pushURLString:urlString query:query animated:animated replace:NO];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)(void))completion
{
    [LLURLNavigation presentViewController:viewControllerToPresent animated:animated completion:completion];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^)(void))completion
{
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewControllerToPresent];
        [self presentViewController:navController animated:animated completion:completion];
    }
}

+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *viewController = [UIViewController initWithString:urlString withConfig:[LLURLRouter shareLLURLRouter].configDict];
    [LLURLNavigation pushViewController:viewController animated:animated replace:NO];
}

+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *viewController = [UIViewController initWithString:urlString withQuery:query withConfig:[LLURLRouter shareLLURLRouter].configDict];
    [LLURLNavigation pushViewController:viewController animated:animated replace:NO];
}

+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^)(void))completion
{
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        
        UIViewController *viewController = [UIViewController initWithString:urlString withConfig:[LLURLRouter shareLLURLRouter].configDict];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [LLURLRouter presentViewController:navController animated:animated completion:completion];
    }
}

+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^)(void))completion
{
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        
        UIViewController *viewController = [UIViewController initWithString:urlString withQuery:query withConfig:[LLURLRouter shareLLURLRouter].configDict];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [LLURLRouter presentViewController:navController animated:animated completion:completion];
    }
}

+ (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [LLURLNavigation popToRootViewControllerAnimated:animated];
}

+ (void)popTwiceViewControllerAnimated:(BOOL)animated
{
    [LLURLNavigation popViewControllerWithTimes:2 animated:animated];
}

+ (void)popViewControllerAnimated:(BOOL)animated
{
    [LLURLNavigation popViewControllerWithTimes:1 animated:animated];
}

+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated
{
    [LLURLNavigation popViewControllerWithTimes:times animated:animated];
}

+ (void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [LLURLNavigation dismissToRootViewControllerAnimated:animated completion:completion];
}

+ (void)dismissTwiceViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [LLURLNavigation dismissTwiceViewControllerAnimated:animated completion:completion];
}

+ (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [LLURLNavigation dismissViewControllerWithTimes:1 animated:animated completion:completion];
}

+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated completion:(void (^)(void))completion
{
    [LLURLNavigation dismissViewControllerWithTimes:times animated:animated completion:completion];
}

+ (UIViewController *)currentViewController
{
    return [LLURLNavigation shareLLURLNavigation].currentViewController;
}

+ (UINavigationController *)currentNavigationViewController
{
    return [LLURLNavigation shareLLURLNavigation].currentNavigationViewController;
}
@end

