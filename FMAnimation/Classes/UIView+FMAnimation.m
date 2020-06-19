//
//  UIView+FMAnimation.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/7.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "UIView+FMAnimation.h"
#import <objc/runtime.h>

@implementation UIView (FMAnimation)

- (FMAnimation *)animator{
    FMAnimation *animator = objc_getAssociatedObject(self, _cmd);
    if (animator == nil) {
        animator= [[FMAnimation alloc] init];
        animator.target = self;
        objc_setAssociatedObject(self, _cmd, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return animator;
}

@end
