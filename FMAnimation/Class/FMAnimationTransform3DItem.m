//
//  FMAnimationTransform3DItem.m
//  FMAnimation
//
//  Created by 郑桂华 on 2019/12/25.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationTransform3DItem.h"
#import "FMAnimation.h"

@implementation FMAnimationTransform3DItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._rotationX = 0;
        self._rotationY = 0;
        self._rotationZ = 0;
        self._rotation = 0;
        self._m34 = 0;
        self._scaleX = 1;
        self._scaleY = 1;
        self._scaleZ = 1;
        self._translateX = 0;
        self._translateY = 0;
        self._translateZ = 0;
    }
    return self;
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))m34{
    WeakSelf;
    return ^(CGFloat m34){
        weakSelf._m34 = m34;
        return weakSelf;
    };
}

- (void)startAnimation{
    [self caculateWithBaseValue:[NSValue valueWithCATransform3D:self.next.baseTransform3D]];
    self.next.baseTransform3D = self.endTransform3D;
    [UIView animateWithDuration:self.aniDuration delay:self.aniDelay options:UIViewAnimationOptionCurveLinear animations:^{
        self.next.target.transform3D = self.endTransform3D;
    } completion:^(BOOL finished){
        
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue{
    CATransform3D base = [baseValue CATransform3DValue];
    __block CATransform3D endTransform3D = base;
    if (self.isAdd) {
        endTransform3D.m34 = self._m34;
        endTransform3D = CATransform3DRotate(endTransform3D, self._rotation, self._rotationX, self._rotationY, self._rotationZ);
        endTransform3D = CATransform3DScale(endTransform3D, self._scaleX, self._scaleY, self._scaleZ);
        endTransform3D = CATransform3DTranslate(endTransform3D, self._translateX, self._translateY, self._translateX);
    }
    self.endTransform3D = endTransform3D;
}

@end
