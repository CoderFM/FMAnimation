//
//  FMAnimationFrameItem.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/11.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationFrameItem.h"
#import "FMAnimation.h"

@implementation FMAnimationFrameItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frameX = FMAnimationDefault;
        self.frameY = FMAnimationDefault;
        self.sizeW = FMAnimationDefault;
        self.sizeH = FMAnimationDefault;
    }
    return self;
}

- (void)startAniamtion{
    
    [self caculateWithBaseValue:[NSValue valueWithCGRect:self.next.baseFrame]];
    self.next.baseFrame = self.endFrame;

    [UIView animateWithDuration:self.aniDuration delay:self.aniDelay options:UIViewAnimationOptionCurveLinear animations:^{
        self.next.target.frame = self.endFrame;
    } completion:^(BOOL finished){
        
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue{
    __block CGRect frame = baseValue.CGRectValue;
    
    if (self.isAdd) { // 增加到
        FMAnimationVerify(self.frameX, ^{
            frame.origin.x += self.frameX;
        });
        FMAnimationVerify(self.frameY, ^{
            frame.origin.y += self.frameY;
        });
        FMAnimationVerify(self.sizeW, ^{
            frame.size.width += self.sizeW;
        });
        FMAnimationVerify(self.sizeH, ^{
            frame.size.height += self.sizeH;
        });
    } else { // 目标值
        FMAnimationVerify(self.frameX, ^{
            frame.origin.x = self.frameX;
        });
        FMAnimationVerify(self.frameY, ^{
            frame.origin.y = self.frameY;
        });
        FMAnimationVerify(self.sizeW, ^{
            frame.size.width = self.sizeW;
        });
        FMAnimationVerify(self.sizeH, ^{
            frame.size.height = self.sizeH;
        });
    }
    
    self.endFrame = frame;
}

@end
