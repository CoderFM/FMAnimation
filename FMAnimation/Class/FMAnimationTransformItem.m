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

- (void)startAnimation{
    [self caculateWithBaseValue:[NSValue valueWithCGAffineTransform:self.next.baseTransform]];
    self.next.baseTransform = self.endTransform;
    [UIView animateWithDuration:self.aniDuration delay:self.aniDelay options:UIViewAnimationOptionCurveLinear animations:^{
        self.next.target.transform = self.endTransform;
    } completion:^(BOOL finished){
        
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue {
    CGAffineTransform baseTransform = [baseValue CGAffineTransformValue];
    __block CGAffineTransform endTransform;
    if (self.isAdd) {
        FMAnimationVerify(self._translateX, ^{
            endTransform = CGAffineTransformTranslate(baseTransform, self._translateX, 0);
        });
        FMAnimationVerify(self._translateY, ^{
            endTransform = CGAffineTransformTranslate(baseTransform, 0, self._translateY);
        });
        FMAnimationVerify(self._scaleX, ^{
            endTransform = CGAffineTransformScale(baseTransform, self._scaleX, 1);
        });
        FMAnimationVerify(self._scaleY, ^{
            endTransform = CGAffineTransformScale(baseTransform, 1, self._scaleY);
        });
        FMAnimationVerify(self._rotation, ^{
            endTransform = CGAffineTransformRotate(baseTransform, self._rotation);
        });
    } else {
        FMAnimationVerify(self._translateX, ^{
            endTransform = CGAffineTransformMake(baseTransform.a, baseTransform.b, baseTransform.c, baseTransform.d, self._translateX, baseTransform.ty);
        });
        FMAnimationVerify(self._translateY, ^{
            endTransform = CGAffineTransformMake(baseTransform.a, baseTransform.b, baseTransform.c, baseTransform.d, baseTransform.tx, self._translateY);
        });
        FMAnimationVerify(self._scaleX, ^{
            endTransform = CGAffineTransformMake(self._scaleX, baseTransform.b, baseTransform.c, baseTransform.d, baseTransform.tx, baseTransform.ty);
        });
        FMAnimationVerify(self._scaleY, ^{
            endTransform = CGAffineTransformMake(baseTransform.a, baseTransform.b, baseTransform.c, self._scaleY, baseTransform.tx, baseTransform.ty);
        });
        FMAnimationVerify(self._rotation, ^{
            endTransform = CGAffineTransformMake(cos(self._rotation), sin(self._rotation), -sin(self._rotation), cos(self._rotation), baseTransform.tx, baseTransform.ty);
        });
    }
    self.endTransform = endTransform;
}


@end
