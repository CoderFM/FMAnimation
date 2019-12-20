//
//  ViewController.m
//  FMAnimation
//
//  Created by 郑桂华 on 2019/12/20.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FMAnimation.h"

@interface ViewController ()
@property(nonatomic, weak)UIView *cyanView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
    self.cyanView = view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
