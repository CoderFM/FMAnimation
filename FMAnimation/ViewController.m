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
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg.jpeg"]];
    [view addSubview:imageV];
    imageV.frame = view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.cyanView.animator.border([FMAnimationBorder modelWithWidth:2 color:[UIColor orangeColor]]).cornerRadius(10).toH(200).toX(150).translateX(100).translateY(66).start();
//    self.cyanView.animator.border([FMAnimationBorder modelWithWidth:2 color:[UIColor orangeColor]]).start();
    
//    self.cyanView.animator.shadow([FMAnimationShadow modelWithColor:[UIColor blackColor] opacity:0.5 radius:10].offset(CGSizeMake(0, 0))).duration(0.5).delay(1).cornerRadius(10).translateY(100).duration(0.5).delay(1).translateX(50).translateY(-100).translateX(-50).start();
    
//    self.cyanView.animator.border([FMAnimationBorder modelWithWidth:1 color:[UIColor orangeColor]]).start();
    
//    self.cyanView.animator.moveY(100).moveX(100).start();
//    [self testAnimation];
    
    self.cyanView.animator.type(1).rotate3DY(M_PI).scale3DX(0.5).scale3DY(0.5).start();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cyanView.animator.type(1).rotate3DY(M_PI).scale3DX(2).scale3DY(2).start();
    });
}

- (void)testAnimation{
    [UIView animateWithDuration:1 animations:^{
        CATransform3D trans = CATransform3DIdentity;
        trans.m34 = 1.0/100;
        trans = CATransform3DRotate(trans, M_PI, 1, 1, 0);
        trans = CATransform3DScale(trans, 0.5, 0.5, 1);
        self.cyanView.transform3D = trans;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.cyanView.transform3D = CATransform3DIdentity;
        }];
    }];
}

@end
