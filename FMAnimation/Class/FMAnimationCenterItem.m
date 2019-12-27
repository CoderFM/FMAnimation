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

- (void)startAnimation{
    [self caculateWithBaseValue:[NSValue valueWithCGPoint:self.next.baseCenter]];
    self.next.baseCenter = self.endCenter;
    [UIView animateWithDuration:self.aniDuration delay:self.aniDelay options:UIViewAnimationOptionCurveLinear animations:^{
        self.next.target.center = self.endCenter;
    } completion:^(BOOL finished){
        
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue{
    __block CGPoint point = baseValue.CGPointValue;
    if (self.isAdd) {
        FMAnimationVerify(self._centerX, ^{
            point.x += self._centerX;
        });
        FMAnimationVerify(self._centerY, ^{
            point.y += self._centerY;
        });
    } else {
        FMAnimationVerify(self._centerX, ^{
            point.x = self._centerX;
        });
        FMAnimationVerify(self._centerY, ^{
            point.y = self._centerY;
        });
    }
    self.endCenter = point;
}

@end
