//
//  OneChildView.m
//  LLURLRouterDemo
//
//  Created by leiliao lai on 16/9/7.
//  Copyright © 2016年 Hailang. All rights reserved.
//

#import "OneChildView.h"
#import "LLURLRouter.h"

@implementation OneChildView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChildView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)clickChildView:(UITapGestureRecognizer *)clickChildView
{
    NSString *urlString = @"hailang://twoVc?name=hailang&userid=123456";
    [LLURLRouter pushURLString:urlString animated:YES];
}


@end
