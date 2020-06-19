//
//  FMAnimationTransformItem.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/18.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationTransformItem.h"
#import "FMAnimation.h"

@implementation FMAnimationTransformItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._translateX = FMAnimationDefault;
        self._translateY = FMAnimationDefault;
        self._scaleX = FMAnimationDefault;
        self._scaleY = FMAnimationDefault;
        self._rotation = FMAnimationDefault;
    }
    return self;
}

- (void)startAnimation:(BOOL)reverse{
    [self caculateWithBaseValue:[NSValue valueWithCGAffineTransform:self.next.lastTransform] reverse:reverse];
    self.next.lastTransform = self.endTransform;
    [self startAnimationWithBlock:^{
        self.next.target.transform = self.endTransform;
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue reverse:(BOOL)reverse{
    CGAffineTransform baseTransform = [baseValue CGAffineTransformValue];
    __block CGAffineTransform endTransform;
    FMAnimationVerify(self._translateX, ^{
        endTransform = CGAffineTransformTranslate(baseTransform, reverse?-self._translateX:self._translateX, 0);
    });
    FMAnimationVerify(self._translateY, ^{
        endTransform = CGAffineTransformTranslate(baseTransform, 0, reverse?-self._translateY:self._translateY);
    });
    FMAnimationVerify(self._scaleX, ^{
        endTransform = CGAffineTransformScale(baseTransform, reverse?1.0/self._scaleX:self._scaleX, 1);
    });
    FMAnimationVerify(self._scaleY, ^{
        endTransform = CGAffineTransformScale(baseTransform, 1, reverse?1.0/self._scaleY:self._scaleY);
    });
    FMAnimationVerify(self._rotation, ^{
        endTransform = CGAffineTransformRotate(baseTransform, reverse?-self._rotation:self._rotation);
    });
    self.endTransform = endTransform;
}


@end
