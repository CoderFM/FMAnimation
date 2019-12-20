//
//  FMAnimation.m
//  Animation
//
//  Created by 郑桂华 on 2019/11/22.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimation.h"
#import "FMAnimationItem.h"
#import "FMAnimationTransformItem.h"
#import "FMAnimationFrameItem.h"
#import "FMAnimationOtherItem.h"


@interface FMAnimation ()
@property(nonatomic, strong)NSMutableArray<FMAnimationItem *> *animations;
@property(nonatomic, assign)FMAnimationGroupType groupType;
@end

FMAnimationItem* FMCreateAnimationItem(NSString *keyPath, id toValue, FMAnimation *animator);

@implementation FMAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animations = [NSMutableArray array];
    }
    return self;
}

- (void)clearAnimation{
    [self.animations removeAllObjects];
}

- (void)startAnimation
{
    if (self.groupType == FMAnimationGroupTypeSeries) { //连续的
        CGFloat delay = 0;
        FMAnimationItem *lastItem = nil;
        for (FMAnimationItem *item in self.animations) {
            item.aniDelay += delay;
            delay = item.aniDuration + item.aniDelay;
            [item startAniamtion];
            if (lastItem == nil) {
                lastItem = item;
            }
        }
        [self.animations removeAllObjects];
    } else { // 同时的
        CGAffineTransform lastValue = self.baseTransform;
        FMAnimationTransformItem *lastItem = nil;
        for (FMAnimationTransformItem *item in self.animations) {
            if ([item isKindOfClass:[FMAnimationTransformItem class]]) {
                if (lastItem == nil) {
                    [item caculateWithBaseValue:[NSValue valueWithCGAffineTransform:lastValue]];
                    lastValue = item.endTransform;
                    lastItem = item;
                } else {
                    [item caculateWithBaseValue:[NSValue valueWithCGAffineTransform:lastItem.endTransform]];
                    lastValue = item.endTransform;
                    lastItem = item;
                }
            }
        }
        [UIView animateWithDuration:1 animations:^{
            self.target.transform = lastValue;
        }];
    }
}

- (FMAnimation * _Nonnull (^)(FMAnimationGroupType))type{
    WeakSelf;
    return ^(FMAnimationGroupType type){
        weakSelf.groupType = type;
        return weakSelf;
    };
}
// frame
- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = YES;
        item.frameX = x;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = YES;
        item.frameY = y;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addW{
    WeakSelf;
    return ^(CGFloat w){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = YES;
        item.sizeW = w;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))addH{
    WeakSelf;
    return ^(CGFloat h){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = YES;
        item.sizeH = h;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = NO;
        item.frameX = x;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = NO;
        item.frameY = y;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toW{
    WeakSelf;
    return ^(CGFloat w){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = NO;
        item.sizeW = w;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGFloat))toH{
    WeakSelf;
    return ^(CGFloat h){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = NO;
        item.sizeH = h;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}


// transform
- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))translateX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item.isAdd = YES;
        item.translateX = x;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))translateY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item.isAdd = YES;
        item.translateY = y;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))scaleX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item.isAdd = YES;
        item.scaleX = x;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))scaleY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item.isAdd = YES;
        item.scaleY = y;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))rotation{
    WeakSelf;
    return ^(CGFloat rotation){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item.isAdd = YES;
        item.rotation = rotation;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

// Other
- (FMAnimationOtherItem * _Nonnull (^)(UIColor * _Nonnull))bgColor{
    WeakSelf;
    return ^(UIColor *color){
        FMAnimationOtherItem *item = [[FMAnimationOtherItem alloc] init];
        item.viewBgColor = color;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationOtherItem * _Nonnull (^)(CGFloat))cornerRadius{
    WeakSelf;
    return ^(CGFloat radius){
        FMAnimationOtherItem *item = [[FMAnimationOtherItem alloc] init];
        item.layerCornerRadius = radius;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationShadowModel * _Nonnull))shadow{
    WeakSelf;
    return ^(FMAnimationShadowModel *model){
        FMAnimationOtherItem *item = [[FMAnimationOtherItem alloc] init];
        item.layerShadow = model;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationBorderModel * _Nonnull))border{
    WeakSelf;
    return ^(FMAnimationBorderModel *model){
        FMAnimationOtherItem *item = [[FMAnimationOtherItem alloc] init];
        item.layerBorder = model;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationOtherItem * _Nonnull (^)(CGFloat))opaque{
    WeakSelf;
    return ^(CGFloat opaque){
        FMAnimationOtherItem *item = [[FMAnimationOtherItem alloc] init];
        item.viewOpaque = opaque;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

@end

