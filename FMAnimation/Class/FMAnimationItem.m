//
//  FMAnimationItem.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/7.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationItem.h"
#import "FMAnimation.h"

extern void FMAnimationVerify(CGFloat original, void(^handle)(void)){
    if (original == FMAnimationDefault) {
        return;
    }
    !handle ?: handle();
}

@interface FMAnimationItem ()

@end

@implementation FMAnimationItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.aniDelay = 0;
        self.aniDuration = 1;
    }
    return self;
}

- (void (^)(void))start{
    WeakSelf;
    return ^{
        !weakSelf._startBlock ?: weakSelf._startBlock();
    };
}

- (void)startAnimation{
    [UIView animateWithDuration:0.25 // 动画的持续时间
                          delay:0 // 动画执行的延迟时间
                        options:0 // 执行的动画选项，
                     animations:^{ // 要执行的动画代码
        
    } completion:^(BOOL finished) { // 动画执行完毕后的调用
        
    }];
}

- (void)startSpringAniamtion{
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)startKeyFrameAnimation{
    [UIView animateKeyframesWithDuration:0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0 animations:^{
            
        }];
    } completion:^(BOOL finished) {
        
    }];
}



- (void)transitionAnimation
{
//    [UIView transitionWithView:_redView duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        _redView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//    } completion:nil];
}

- (void)animation:(void(^)(void))animation complete:(void(^)(BOOL finished))complete{
    [UIView animateWithDuration:self.aniDuration delay:self.aniDelay options:UIViewAnimationOptionCurveLinear animations:animation completion:complete];
}

- (void)startAniamtion{
    
}

// protocol
// frame
- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addX{
    return self.next.addX;
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addY{
    return self.next.addY;
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addW{
    return self.next.addW;
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addH{
    return self.next.addH;
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toX{
    return self.next.toX;
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toY{
    return self.next.toY;
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toW{
    return self.next.toW;
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toH{
    return self.next.toH;
}


// transform
- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))translateX{
    return self.next.translateX;
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))translateY{
    return self.next.translateY;
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))scaleX{
    return self.next.scaleX;
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))scaleY{
    return self.next.scaleY;
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))rotation{
    return self.next.rotation;
}

// Other
- (FMAnimationOtherItem * _Nonnull (^)(UIColor * _Nonnull))bgColor{
    return self.next.bgColor;
}

- (FMAnimationOtherItem * _Nonnull (^)(CGFloat))cornerRadius{
    return self.next.cornerRadius;
}

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationShadowModel * _Nonnull))shadow{
    return self.next.shadow;
}

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationBorderModel * _Nonnull))border{
    return self.next.border;
}

- (FMAnimationOtherItem * _Nonnull (^)(CGFloat))opaque{
    return self.next.opaque;
}


@end
