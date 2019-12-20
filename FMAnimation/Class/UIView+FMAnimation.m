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
    
    FMAnimation *anim = objc_getAssociatedObject(self, FMAnimationUIViewAnimatorKey);
    if (!anim) {
        anim = [[FMAnimation alloc] init];
        anim.target = self;
        objc_setAssociatedObject(self, FMAnimationUIViewAnimatorKey, anim, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    anim.baseFrame = self.frame;
    anim.baseCenter = self.center;
    anim.baseOpaque = self.opaque;
    anim.baseTransform = self.transform;
    
    
    
    [anim clearAnimation];
    
    return anim;
}

@end
