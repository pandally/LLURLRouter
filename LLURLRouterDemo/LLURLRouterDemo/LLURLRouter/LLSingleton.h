//
//  LLSingleton.h
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/3.
//  Copyright © 2016年 Hailang. All rights reserved.
//  单例宏-arc环境

//.h文件
#define LLSingletonH(name) +(instancetype)share##name;

//.m文件
#define LLSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
\
+ (instancetype)share##name\
{\
    return [[self alloc] init];\
}\
\
- (id)copyWithone:(NSZone *)zone\
{\
    return _instance;\
}\
\
- (id)mutableCopyWithone:(NSZone *)zone\
{\
    return _instance;\
}\
