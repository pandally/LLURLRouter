//
//  ThreeViewController.m
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/7.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import "ThreeViewController.h"
#import "LLURLRouter.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"ThreeViewController";
    
    UILabel *title = [[UILabel alloc] init];
    title.text = NSStringFromClass([self class]);
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor lightGrayColor];
    title.numberOfLines = 0;
    [title sizeToFit];
    [self.view addSubview:title];
    title.center = self.view.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [LLURLRouter pushURLString:@"hailang://fourVc" animated:YES replace:NO];
    
    //    [LLURLRouter presentURLString:@"hailang://fourVc" animated:YES completion:nil];
    
}

@end
