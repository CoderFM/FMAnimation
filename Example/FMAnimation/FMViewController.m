//
//  FMViewController.m
//  FMAnimation
//
//  Created by zhoufaming251@163.com on 06/19/2020.
//  Copyright (c) 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMViewController.h"
#import <UIView+FMAnimation.h>

@interface FMViewController ()
@property(nonatomic, weak)UIView *cyanView;
@end

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
    self.cyanView = view;
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg.jpeg"]];
    [view addSubview:imageV];
    imageV.frame = view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    NSLog(@"111  %@", self.cyanView.animator);
//    NSLog(@"222  %@", self.cyanView.animator);
    
//    self.cyanView.animator.border([FMAnimationBorder modelWithWidth:2 color:[UIColor orangeColor]]).cornerRadius(10).toH(200).toX(150).translateX(100).translateY(66).start();
//    self.cyanView.animator.border([FMAnimationBorder modelWithWidth:2 color:[UIColor orangeColor]]).start();
    
//    self.cyanView.animator.shadow([FMAnimationShadow modelWithColor:[UIColor blackColor] opacity:0.5 radius:10].offset(CGSizeMake(0, 0))).duration(0.5).delay(1).cornerRadius(10).translateY(100).duration(0.5).delay(1).translateX(50).translateY(-100).translateX(-50).start();
    
//    self.cyanView.animator.border([FMAnimationBorder modelWithWidth:1 color:[UIColor orangeColor]]).start();
    
//    self.cyanView.animator.moveY(100).duration(0.25).moveX(100).duration(0.5).start(YES);
//    [self testAnimation];
    
    self.cyanView.animator.duration(3).damping(0.95).velocity(5).type(1).scale3D(0.5, 0.5, 1).m34(1.0/100).rotate3DY(M_PI).start(YES);
    
//    self.cyanView.animator.translate(100, 100).damping(0.9).velocity(10).duration(1).start(YES);
    
//    self.cyanView.animator.type(1).scale3DX(0.5).scale3DY(0.5).m34(1.0/100).rotate3DY(M_PI).start(YES);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.cyanView.animator.type(1).rotate3DY(M_PI).scale3DX(2).scale3DY(2).start();
//    });

//    [self.cyanView removeFromSuperview];
//
//    NSLog(@"333  %@", self.cyanView.animator);
//    NSLog(@"444  %@", self.cyanView.animator);
}

- (void)testAnimation{
    [UIView animateWithDuration:2 animations:^{
        CATransform3D trans = CATransform3DIdentity;
        trans.m34 = 1.0/100;
        trans = CATransform3DRotate(trans, M_PI, 0, 1, 0);
        trans = CATransform3DScale(trans, 0.5, 0.5, 1);
        trans = CATransform3DTranslate(trans, -50, 50, 0);
        if (@available(iOS 12.0, *)) {
            self.cyanView.transform3D = trans;
        } else {
            // Fallback on earlier versions
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            if (@available(iOS 12.0, *)) {
                self.cyanView.transform3D = CATransform3DIdentity;
            } else {
                // Fallback on earlier versions
            }
        }];
    }];
}


@end
