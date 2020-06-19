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

- (void)startAnimation:(BOOL)reverse{
    
    [self caculateWithBaseValue:[NSValue valueWithCGRect:self.next.lastFrame] reverse:reverse];
    self.next.lastFrame = self.endFrame;
    [self startAnimationWithBlock:^{
        self.next.target.frame = self.endFrame;
    }];
}

- (void)caculateWithBaseValue:(NSValue *)baseValue reverse:(BOOL)reverse{
    __block CGRect frame = baseValue.CGRectValue;
    
    if (self.isAdd) { // 增加到
        FMAnimationVerify(self.frameX, ^{
            if (reverse) {
                frame.origin.x -= self.frameX;
            } else {
                frame.origin.x += self.frameX;
            }
        });
        FMAnimationVerify(self.frameY, ^{
            if (reverse) {
                frame.origin.y -= self.frameY;
            } else {
                frame.origin.y += self.frameY;
            }
        });
        FMAnimationVerify(self.sizeW, ^{
            if (reverse) {
                frame.size.width -= self.sizeW;
            } else {
                frame.size.width += self.sizeW;
            }
        });
        FMAnimationVerify(self.sizeH, ^{
            if (reverse) {
                frame.size.height -= self.sizeH;
            } else {
                frame.size.height += self.sizeH;
            }
        });
    } else { // 目标值
        FMAnimationVerify(self.frameX, ^{
            frame.origin.x = reverse?self.next.baseFrame.origin.x:self.frameX;
        });
        FMAnimationVerify(self.frameY, ^{
            frame.origin.y = reverse?self.next.baseFrame.origin.y:self.frameY;
        });
        FMAnimationVerify(self.sizeW, ^{
            frame.size.width = reverse?self.next.baseFrame.size.width:self.sizeW;
        });
        FMAnimationVerify(self.sizeH, ^{
            frame.size.height = reverse?self.next.baseFrame.size.height:self.sizeH;
        });
    }
    
    self.endFrame = frame;
}

@end
