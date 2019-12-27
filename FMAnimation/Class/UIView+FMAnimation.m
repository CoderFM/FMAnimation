//
//  UIView+FMAnimation.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/7.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "UIView+FMAnimation.h"
#import <objc/runtime.h>

static void *FMAnimationUIViewAnimatorKey = &FMAnimationUIViewAnimatorKey;

@implementation UIView (FMAnimation)

- (FMAnimation *)animator{
    
    FMAnimation *anim= [[FMAnimation alloc] init];
    anim.target = self;
    
    anim.baseFrame = self.frame;
    anim.baseCenter = self.center;
    anim.baseTransform = self.transform;
    anim.baseTransform3D = self.transform3D;

    return anim;
}

@end
