//
//  FMAnimationItem.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/7.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMBaseAnimation.h"
#import "FMAnimationConstant.h"
#import "FMAnimationDelegate.h"
#import "FMAnimationItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern void FMAnimationVerify(CGFloat original, void(^handle)(void));

@class FMAnimation;
@interface FMAnimationItem : NSObject<FMAnimationItemProtocol>

@property(nonatomic, assign)NSTimeInterval aniDuration;
@property(nonatomic, assign)NSTimeInterval aniDelay;

- (void)caculateWithBaseValue:(NSValue *)baseValue;

@property(nonatomic, weak)FMAnimation *next;

@property(nonatomic, copy)void(^start)(void);

@property(nonatomic, copy)void(^_startBlock)(void);

- (void)animation:(void(^)(void))animation complete:(void(^)(BOOL finished))complete;

- (void)startAniamtion;

@end

NS_ASSUME_NONNULL_END
