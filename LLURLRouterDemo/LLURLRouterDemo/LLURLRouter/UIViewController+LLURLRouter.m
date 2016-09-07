//
//  UIViewController+LLURLRouter.m
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/3.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import "UIViewController+LLURLRouter.h"
#import <objc/runtime.h>

@implementation UIViewController (LLURLRouter)

static char URLoriginUrl;
static char URLpath;
static char URLparams;

- (void)setOriginUrl:(NSURL *)originUrl
{
    //为分类设置属性值
    objc_setAssociatedObject(self, &URLoriginUrl, originUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)originUrl
{
    //获取分类属性值
    return objc_getAssociatedObject(self, &URLoriginUrl);
}

- (void)setPath:(NSString *)path
{
    objc_setAssociatedObject(self, &URLpath, path, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)path
{
    return objc_getAssociatedObject(self, &URLpath);
}

- (void)setParams:(NSDictionary *)params
{
    objc_setAssociatedObject(self, &URLparams, params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params
{
    return objc_getAssociatedObject(self, &URLparams);
}

+ (UIViewController *)initWithString:(NSString *)urlString withConfig:(NSDictionary *)configDict
{
    return [UIViewController initWithUrl:[NSURL URLWithString:urlString] withQuery:nil withConfig:configDict];
}

+ (UIViewController *)initWithString:(NSString *)urlString withQuery:(NSDictionary *)query withConfig:(NSDictionary *)configDict
{
    return [UIViewController initWithUrl:[NSURL URLWithString:urlString] withQuery:query withConfig:configDict];
}


+ (UIViewController *)initWithUrl:(NSURL *)url withQuery:(NSDictionary *)query withConfig:(NSDictionary *)configDict
{
    UIViewController *Vc = nil;
    NSString *home;
    if (url.path == nil) {  //处理url,去掉有可能会拼接的参数
        home = [NSString stringWithFormat:@"%@://%@",url.scheme,url.host];
    }else
    {
        home = [NSString stringWithFormat:@"%@://%@%@",url.scheme,url.path,url.host];
    }
    
    if ([configDict.allKeys containsObject:url.scheme]) {  //字典中的所有key是否包含传入的协议头
        id config = [configDict objectForKey:url.scheme];
        Class class = nil;
        if ([configDict isKindOfClass:[NSString class]]) {  //当协议头是http https的情况
            class = NSClassFromString(config);
        }else if ([config isKindOfClass:[NSDictionary class]]){  //自定义的url情况
            NSDictionary *dict = (NSDictionary *)config;
            if ([dict.allKeys containsObject:home]) {
                class = NSClassFromString([dict objectForKey:home]);  // 根据key拿到对应的控制器名称
            }
        }
        
        if (class != nil) {
            Vc = [[class alloc] init];
            if ([Vc respondsToSelector:@selector(open:withQuery:)]) {
                [Vc open:url withQuery:query];
            }
        }
        
        if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
            class = NSClassFromString([configDict objectForKey:url.scheme]);
            Vc.params = @{@"urlStr": [url absoluteString]};
        }
    }
    return Vc;
}

/**
 *  为控制器属性赋值
 *
 *  @param url   <#url description#>
 *  @param query <#query description#>
 */
- (void)open:(NSURL *)url withQuery:(NSDictionary *)query
{
    self.path = url.path;
    self.originUrl = url;
    if (query) {  // 如果自定义url后面有拼接参数,而且又通过query传入了参数,那么优先query传入了参数
        self.params = query;
    }else
    {
        self.params = [self paramsWithUrl:url];
    }
}

/**
 *  将url的参数部分转化为字典
 *
 *  @param url
 *
 *  @return 字典
 */
- (NSDictionary *)paramsWithUrl:(NSURL *)url
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (NSNotFound != [url.absoluteString rangeOfString:@"?"].location) {
        NSString *paramsString = [url.absoluteString substringFromIndex:[url.absoluteString rangeOfString:@"?"].location + 1];
        
        NSCharacterSet * delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner *scanner = [NSScanner scannerWithString:paramsString];
        
        while (![scanner isAtEnd]) {
            NSString *pair = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pair];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray *array = [pair componentsSeparatedByString:@"="];
            
            if (array.count == 2) {
                NSString *key = [array[0] stringByRemovingPercentEncoding];
                NSString *value = [array[1] stringByRemovingPercentEncoding];
                [dict setValue:value forKey:key];
            }
            
        }
    }
    return dict;
}

@end
