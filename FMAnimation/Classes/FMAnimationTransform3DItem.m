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
        self._rotationX = FMAnimationDefault;
        self._rotationY = FMAnimationDefault;
        self._rotationZ = FMAnimationDefault;
        self._rotation = FMAnimationDefault;
        self._m34 = FMAnimationDefault;
        self._scaleX = FMAnimationDefault;
        self._scaleY = FMAnimationDefault;
        self._scaleZ = FMAnimationDefault;
        self._translateX = FMAnimationDefault;
        self._translateY = FMAnimationDefault;
        self._translateZ = FMAnimationDefault;
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

- (void)startAnimation:(BOOL)reverse{
    [self caculateWithBaseValue:[NSValue valueWithCATransform3D:self.next.lastTransform3D] reverse:reverse];
    self.next.lastTransform3D = self.endTransform3D;
    [self startAnimationWithBlock:^{
        self.next.target.transform3D = self.endTransform3D;
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue reverse:(BOOL)reverse{
    CATransform3D base = [baseValue CATransform3DValue];
    __block CATransform3D endTransform3D = base;
    endTransform3D.m34 = self._m34;
    FMAnimationVerify(self._rotation, ^{
        FMAnimationVerify(self._rotationX, ^{
            endTransform3D = CATransform3DRotate(endTransform3D, reverse?-self._rotation:self._rotation, self._rotationX, 0, 0);
        });
        FMAnimationVerify(self._rotationY, ^{
            endTransform3D = CATransform3DRotate(endTransform3D, reverse?-self._rotation:self._rotation, 0, self._rotationY, 0);
        });
        FMAnimationVerify(self._rotationZ, ^{
            endTransform3D = CATransform3DRotate(endTransform3D, reverse?-self._rotation:self._rotation, 0, 0, self._rotationZ);
        });
    });
    FMAnimationVerify(self._scaleX, ^{
        endTransform3D = CATransform3DScale(endTransform3D, reverse?1.0/self._scaleX:self._scaleX, 1, 1);
    });
    FMAnimationVerify(self._scaleY, ^{
        endTransform3D = CATransform3DScale(endTransform3D, 1, reverse?1.0/self._scaleY:self._scaleY, 1);
    });
    FMAnimationVerify(self._scaleZ, ^{
        endTransform3D = CATransform3DScale(endTransform3D, 1, 1, reverse?1.0/self._scaleZ:self._scaleZ);
    });
    FMAnimationVerify(self._translateX, ^{
        endTransform3D = CATransform3DTranslate(endTransform3D, reverse?-self._translateX:self._translateX, 0, 0);
    });
    FMAnimationVerify(self._translateY, ^{
        endTransform3D = CATransform3DTranslate(endTransform3D, 0, reverse?-self._translateY:self._translateY, 0);
    });
    FMAnimationVerify(self._translateZ, ^{
        endTransform3D = CATransform3DTranslate(endTransform3D, 0, 0, reverse?-self._translateZ:self._translateZ);
    });
    self.endTransform3D = endTransform3D;
}

@end
