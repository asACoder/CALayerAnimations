//
//  ViewController.m
//  CustomAnimation
//
//  Created by 付世健 on 14-11-9.
//  Copyright (c) 2014年 fsj. All rights reserved.
//

#import "ViewController.h"
#import "AnimationLayer.h"

#import "UIView+SJCustomBlockAnimation.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    [self customLayerAnimation];
    
    
    
    //objc.io View-Layer 协作
//    [self customViewAnimation];
}

-(void)customLayerAnimation
{
    // 自定义Layer动画
    AnimationLayer *layer = [[AnimationLayer alloc] init];
    layer.backgroundColor = [UIColor grayColor].CGColor;
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.progress = 1.0;
//    layer.progress = 0.75;
    [self.view.layer addSublayer:layer];

}


-(void)customViewAnimation
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    [UIView SJ_animationWithDuration:2 animation:^{
        
        view.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    }];
}


@end
