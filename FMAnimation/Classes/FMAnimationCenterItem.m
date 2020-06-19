//
//  FMAnimationCenterItem.m
//  FMAnimation
//
//  Created by 郑桂华 on 2019/12/23.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationCenterItem.h"
#import "FMAnimation.h"

@implementation FMAnimationCenterItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._centerX = FMAnimationDefault;
        self._centerY = FMAnimationDefault;
    }
    return self;
}

- (void)startAnimation:(BOOL)reverse{
    [self caculateWithBaseValue:[NSValue valueWithCGPoint:self.next.lastCenter]  reverse:reverse];
    self.next.lastCenter = self.endCenter;
    [self startAnimationWithBlock:^{
        self.next.target.center = self.endCenter;
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue reverse:(BOOL)reverse{
    __block CGPoint point = baseValue.CGPointValue;
    if (self.isAdd) {
        FMAnimationVerify(self._centerX, ^{
            if (reverse) {
                point.x -= self._centerX;
            } else {
                point.x += self._centerX;
            }
        });
        FMAnimationVerify(self._centerY, ^{
            if (reverse) {
                point.y -= self._centerY;
            } else {
                point.y += self._centerY;
            }
        });
    } else {
        FMAnimationVerify(self._centerX, ^{
            point.x = reverse?self.next.baseCenter.x:self._centerX;
        });
        FMAnimationVerify(self._centerY, ^{
            point.y = reverse?self.next.baseCenter.y:self._centerY;
        });
    }
    self.endCenter = point;
}

@end
