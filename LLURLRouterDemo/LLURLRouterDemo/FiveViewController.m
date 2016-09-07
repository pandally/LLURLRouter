//
//  FiveViewController.m
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/7.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import "FiveViewController.h"

@interface FiveViewController ()

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"FivewViewController";
    
    
    UILabel *title = [[UILabel alloc] init];
    title.text = NSStringFromClass([self class]);
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor lightGrayColor];
    title.numberOfLines = 0;
    [title sizeToFit];
    [self.view addSubview:title];
    title.center = self.view.center;
    
}



@end
