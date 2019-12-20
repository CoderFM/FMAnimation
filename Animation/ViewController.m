//
//  ViewController.m
//  Animation
//
//  Created by 郑桂华 on 2019/11/22.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FMAnimation.h"
#import "FMView.h"

@interface ViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet FMView *redView;
@property (weak, nonatomic) IBOutlet FMView *blueView;
@property(nonatomic, weak)FMView *cyanView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    FMView *view = [[FMView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:view];
//    self.cyanView = view;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.redView.animator.addX(50).next.addY(100).next.toX(200).next.toY(200).next.addW(200).next.toH(300).start();
    
//    self.redView.animator.addW(50).next.toH(300).start();
//    [UIView animateWithDuration:3 animations:^{
//        self.cyanView.frame = CGRectMake(100, 100, 200, 200);
//    }];
    //.next.scaleX(1.3).next.scaleY(1.5)
//    self.redView.animator.translateY(100).next.translateX(100).start();
//    self.redView.animator.scaleX(1.5).next.scaleY(2).start();
//    self.redView.animator.rotation(M_PI_4).start();
   //
//    self.redView.animator.type(FMAnimationGroupTypeConcurrent).transformX(100).next.transformY(100).next.rotation(M_PI_4).start();
    
   
    
//    self.redView.animator.bgColor(UIColor.purpleColor).
    self.redView.animator.bgColor(UIColor.purpleColor).cornerRadius(10).start();
}


- (void)makeKeyFrameAnimation{
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animation];
    ani.duration = 2;
    ani.keyPath = kCAPosition;
    ani.path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)].CGPath;
    ani.repeatCount = 1;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    [self.redView.layer addAnimation:ani forKey:@""];
}


@end
