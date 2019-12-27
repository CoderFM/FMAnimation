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
        self.aniDelay = FMAnimationDefaultDelay;
        self.aniDuration = FMAnimationDefaultDuration;
    }
    return self;
}

- (void)caculateWithBaseValue:(NSValue *)baseValue{
    NSString *text = [NSString stringWithFormat:@"%@来实现- (void)caculateWithBaseValue", NSStringFromClass([self class])];
    @throw [NSException exceptionWithName:@"需要子类实现该方法" reason:text userInfo:nil];
}

- (void (^)(void))start{
    WeakSelf;
    return ^{
        !weakSelf._startBlock ?: weakSelf._startBlock();
    };
}

- (FMAnimationItem *(^)(NSTimeInterval))duration{
    WeakSelf;
    return ^(NSTimeInterval interval){
        weakSelf.aniDuration = interval;
        return weakSelf;
    };
}

- (FMAnimationItem *(^)(NSTimeInterval))delay{
    WeakSelf;
    return ^(NSTimeInterval interval){
        weakSelf.aniDelay = interval;
        return weakSelf;
    };
}

- (void)startAnimation{
    NSString *text = [NSString stringWithFormat:@"%@来实现- (void)startAnimation", NSStringFromClass([self class])];
    @throw [NSException exceptionWithName:@"需要子类实现该方法" reason:text userInfo:nil];
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

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationShadow * _Nonnull))shadow{
    return self.next.shadow;
}

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationBorder * _Nonnull))border{
    return self.next.border;
}

- (FMAnimationOtherItem * _Nonnull (^)(CGFloat))opaque{
    return self.next.opaque;
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveX{
    return self.next.moveX;
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveY{
    return self.next.moveY;
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveToX{
    return self.next.moveToX;
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveToY{
    return self.next.moveToY;
}

// tranform3D
- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))rotate3D{
    return self.next.rotate3D;
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DX{
    return self.next.rotate3DX;
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DY{
    return self.next.rotate3DY;
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DZ{
    return self.next.rotate3DZ;
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))scale3DX{
    return self.next.scale3DX;
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))scale3DY{
    return self.next.scale3DY;
}

@end
