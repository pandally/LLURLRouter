//
//  TwoViewController.m
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/7.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import "TwoViewController.h"
#import "LLURLRouter.h"
#import "UIViewController+LLURLRouter.h"
#import "ThreeViewController.h"

@interface TwoViewController ()

/** <#注释#> */
@property (nonatomic, copy) NSString *name;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"TwoViewController";
    
    UILabel *title = [[UILabel alloc] init];
    title.text = NSStringFromClass([self class]);
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor lightGrayColor];
    title.numberOfLines = 0;
    [title sizeToFit];
    [self.view addSubview:title];
    title.center = self.view.center;
    
    NSLog(@"接收的参数%@", self.params);
    NSLog(@"拿到URL:%@", self.originUrl);
    NSLog(@"URL路径:%@", self.path);
    
    
    NSLog(@"%@", self.name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [LLURLRouter presentURLString:@"hailang://threeVc" animated:YES completion:nil];
}


@end
