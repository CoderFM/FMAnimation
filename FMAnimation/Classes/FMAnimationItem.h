//
//  FMAnimationItem.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/7.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMAnimationConstant.h"
#import "FMAnimationItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern void FMAnimationVerify(CGFloat original, void(^handle)(void));
static CGFloat const FMAnimationDefault = 0.000001;
@class FMAnimation;
@interface FMAnimationItem : NSObject<FMAnimationItemProtocol>

@property(nonatomic, assign)NSTimeInterval aniDuration;
@property(nonatomic, assign)NSTimeInterval aniDelay;
@property(nonatomic, assign)CGFloat aniDamping;
@property(nonatomic, assign)CGFloat aniVelocity;
@property(nonatomic, assign)UIViewAnimationOptions aniOptions;

- (void)caculateWithBaseValue:(NSValue *)baseValue reverse:(BOOL)reverse;

@property(nonatomic, weak)FMAnimation *next;
/// 是否执行完动画反向执行
@property(nonatomic, copy)void(^start)(BOOL reverse);

@property(nonatomic, copy)void(^_startBlock)(BOOL reverse);

@property(nonatomic, copy, readonly)FMAnimationItem *(^duration)(NSTimeInterval interval);
@property(nonatomic, copy, readonly)FMAnimationItem *(^delay)(NSTimeInterval interval);
@property(nonatomic, copy, readonly)FMAnimationItem *(^damping)(CGFloat damping);
@property(nonatomic, copy, readonly)FMAnimationItem *(^velocity)(CGFloat velocity);
@property(nonatomic, copy, readonly)FMAnimationItem *(^options)(UIViewAnimationOptions options);

- (void)startAnimation:(BOOL)reverse;
- (void)startAnimationWithBlock:(void(^)(void))animations;
@end

NS_ASSUME_NONNULL_END
