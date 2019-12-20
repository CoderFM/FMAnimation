//
//  FMAnimationDelegate.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/9.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationDelegate.h"

@implementation FMAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    !self.start ?: self.start(anim);
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    !self.stop ?: self.stop(anim, flag);
}

@end
