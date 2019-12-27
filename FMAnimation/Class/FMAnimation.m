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
#import "FMAnimationCenterItem.h"
#import "FMAnimationTransform3DItem.h"

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

- (void)resetBaseProperty{
    self.baseFrame = self.target.frame;
    self.baseCenter = self.target.center;
    self.baseTransform = self.target.transform;
    self.baseTransform3D = self.target.transform3D;
}

- (void)dealloc{
//    [[FMAnimationExecutor shareExecutor] startAnimationWithType:self.groupType animations:self.animations];
//    [[FMAnimationExecutor shareExecutor] startAnimationWithType:self.groupType animations:self.animations];
//    [self startAnimation];
}

- (void)startAnimation
{
    if (self.groupType == FMAnimationGroupTypeSeries) { //连续的
        CGFloat delay = 0;
        FMAnimationItem *lastItem = nil;
        for (FMAnimationItem *item in self.animations) {
            item.aniDelay += delay;
            delay = item.aniDuration + item.aniDelay;
            [item startAnimation];
            if (lastItem == nil) {
                lastItem = item;
            }
        }
        [self.animations removeAllObjects];
    } else { // 同时的
        for (FMAnimationItem *item in self.animations) {
            if ([item isKindOfClass:[FMAnimationTransformItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCGAffineTransform:self.baseTransform]];
                self.baseTransform = ((FMAnimationTransformItem *)item).endTransform;
            } else if ([item isKindOfClass:[FMAnimationCenterItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCGPoint:self.baseCenter]];
                self.baseCenter = ((FMAnimationCenterItem *)item).endCenter;
            } else if ([item isKindOfClass:[FMAnimationFrameItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCGRect:self.baseFrame]];
                self.baseFrame = ((FMAnimationFrameItem *)item).endFrame;
            } else if ([item isKindOfClass:[FMAnimationTransform3DItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCATransform3D:self.baseTransform3D]];
                self.baseTransform3D = ((FMAnimationTransform3DItem *)item).endTransform3D;
            } else {
                [item startAnimation];
            }
        }
        [UIView animateWithDuration:1 animations:^{
            self.target.transform = self.baseTransform;
            self.target.transform3D = self.baseTransform3D;
            self.target.frame = self.baseFrame;
            self.target.center = self.baseCenter;
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
        item._translateX = x;
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
        item._translateY = y;
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
        item._scaleX = x;
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
        item._scaleY = y;
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
        item._rotation = rotation;
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

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationShadow * _Nonnull))shadow{
    WeakSelf;
    return ^(FMAnimationShadow *model){
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

- (FMAnimationOtherItem * _Nonnull (^)(FMAnimationBorder * _Nonnull))border{
    WeakSelf;
    return ^(FMAnimationBorder *model){
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


- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationCenterItem *item = [[FMAnimationCenterItem alloc] init];
        item.isAdd = YES;
        item._centerX = x;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationCenterItem *item = [[FMAnimationCenterItem alloc] init];
        item.isAdd = YES;
        item._centerY = y;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveToX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationCenterItem *item = [[FMAnimationCenterItem alloc] init];
        item.isAdd = NO;
        item._centerX = x;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat))moveToY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationCenterItem *item = [[FMAnimationCenterItem alloc] init];
        item.isAdd = NO;
        item._centerY = y;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

// tranform3D
- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))rotate3D{
    WeakSelf;
    return ^(CGFloat roration, CGFloat x, CGFloat y, CGFloat z){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item.isAdd = YES;
        item._rotation = roration;
        item._rotationX = x;
        item._rotationY = y;
        item._rotationZ = z;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DX{
    WeakSelf;
    return ^(CGFloat roration){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item.isAdd = YES;
        item._rotation = roration;
        item._rotationX = 1;
        item._rotationY = 0;
        item._rotationZ = 0;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DY{
    WeakSelf;
    return ^(CGFloat roration){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item.isAdd = YES;
        item._rotation = roration;
        item._rotationX = 0;
        item._rotationY = 1;
        item._rotationZ = 0;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DZ{
    WeakSelf;
    return ^(CGFloat roration){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item.isAdd = YES;
        item._rotation = roration;
        item._rotationX = 0;
        item._rotationY = 0;
        item._rotationZ = 1;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))scale3DX{
    WeakSelf;
    return ^(CGFloat scale){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item.isAdd = YES;
        item._scaleX = scale;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))scale3DY{
    WeakSelf;
    return ^(CGFloat scale){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item.isAdd = YES;
        item._scaleY = scale;
        item.next = weakSelf;
        [item set_startBlock:^{
            [weakSelf startAnimation];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

@end

