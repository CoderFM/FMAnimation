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
        self.translateX = FMAnimationDefault;
        self.translateY = FMAnimationDefault;
        self.scaleX = FMAnimationDefault;
        self.scaleY = FMAnimationDefault;
        self.rotation = FMAnimationDefault;
    }
    return self;
}

- (void)startAniamtion{
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
        FMAnimationVerify(self.translateX, ^{
            endTransform = CGAffineTransformTranslate(baseTransform, self.translateX, 0);
        });
        FMAnimationVerify(self.translateY, ^{
            endTransform = CGAffineTransformTranslate(baseTransform, 0, self.translateY);
        });
        FMAnimationVerify(self.scaleX, ^{
            endTransform = CGAffineTransformScale(baseTransform, self.scaleX, 1);
        });
        FMAnimationVerify(self.scaleY, ^{
            endTransform = CGAffineTransformScale(baseTransform, 1, self.scaleY);
        });
        FMAnimationVerify(self.rotation, ^{
            endTransform = CGAffineTransformRotate(baseTransform, self.rotation);
        });
    } else {
        FMAnimationVerify(self.translateX, ^{
            endTransform = CGAffineTransformMake(baseTransform.a, baseTransform.b, baseTransform.c, baseTransform.d, self.translateX, baseTransform.ty);
        });
        FMAnimationVerify(self.translateY, ^{
            endTransform = CGAffineTransformMake(baseTransform.a, baseTransform.b, baseTransform.c, baseTransform.d, baseTransform.tx, self.translateY);
        });
        FMAnimationVerify(self.scaleX, ^{
            endTransform = CGAffineTransformMake(self.scaleX, baseTransform.b, baseTransform.c, baseTransform.d, baseTransform.tx, baseTransform.ty);
        });
        FMAnimationVerify(self.scaleY, ^{
            endTransform = CGAffineTransformMake(baseTransform.a, baseTransform.b, baseTransform.c, self.scaleY, baseTransform.tx, baseTransform.ty);
        });
        FMAnimationVerify(self.rotation, ^{
            endTransform = CGAffineTransformMake(cos(self.rotation), sin(self.rotation), -sin(self.rotation), cos(self.rotation), baseTransform.tx, baseTransform.ty);
        });
    }
    self.endTransform = endTransform;
}


@end
