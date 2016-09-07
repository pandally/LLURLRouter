//
//  UIViewController+LLURLRouter.h
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/3.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (LLURLRouter)

/** 跳转后控制器能拿到的url */
@property (nonatomic, strong) NSURL *originUrl;

/** url路径 */
@property (nonatomic, copy) NSString *path;

/** 跳转后控制器能拿到的参数 */
@property (nonatomic, strong) NSDictionary *params;

/**
 *  根据参数创建控制器
 *
 *  @param urlString  配置好的路径
 *  @param configDict 参数字典
 *
 *  @return 返回创建的控制器
 */
+ (UIViewController *)initWithString:(NSString *)urlString withConfig:(NSDictionary *)configDict;

/**
 *  根据参数创建控制器
 *
 *  @param urlString  配置好的路径
 *  @param configDict 参数字典
 *
 *  @return 返回创建的控制器
 */
+ (UIViewController *)initWithString:(NSString *)urlString withQuery:(NSDictionary *)query withConfig:(NSDictionary *)configDict;

@end

NS_ASSUME_NONNULL_END
