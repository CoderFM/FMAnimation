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
#import "FMAnimationDelegate.h"
#import "FMAnimationItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern void FMAnimationVerify(CGFloat original, void(^handle)(void));
static CGFloat const FMAnimationDefault = 0.000001;
@class FMAnimation;
@interface FMAnimationItem : NSObject<FMAnimationItemProtocol>

@property(nonatomic, assign)NSTimeInterval aniDuration;
@property(nonatomic, assign)NSTimeInterval aniDelay;

- (void)caculateWithBaseValue:(NSValue *)baseValue;

@property(nonatomic, weak)FMAnimation *next;

@property(nonatomic, copy)void(^start)(void);

@property(nonatomic, copy)void(^_startBlock)(void);

@property(nonatomic, copy, readonly)FMAnimationItem *(^duration)(NSTimeInterval interval);
@property(nonatomic, copy, readonly)FMAnimationItem *(^delay)(NSTimeInterval interval);

- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
