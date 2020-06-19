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

@property(nonatomic, assign)NSTimeInterval aniDuration;
@property(nonatomic, assign)NSTimeInterval aniDelay;
@property(nonatomic, assign)CGFloat aniDamping;
@property(nonatomic, assign)CGFloat aniVelocity;
@property(nonatomic, assign)UIViewAnimationOptions aniOptions;

@end

@implementation FMAnimation

- (void)dealloc{
    NSLog(@"FMAnimation dealloc");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animations = [NSMutableArray array];
        self.aniDelay = FMAnimationDefaultDelay;
        self.aniDuration = FMAnimationDefaultDuration;
        self.aniDamping = 1;
        self.aniVelocity = 0;
        self.aniOptions = UIViewAnimationOptionCurveLinear;
    }
    return self;
}

- (FMAnimation *(^)(NSTimeInterval))duration{
    WeakSelf;
    return ^(NSTimeInterval interval){
        weakSelf.aniDuration = interval;
        return weakSelf;
    };
}

- (FMAnimation *(^)(NSTimeInterval))delay{
    WeakSelf;
    return ^(NSTimeInterval interval){
        weakSelf.aniDelay = interval;
        return weakSelf;
    };
}

- (FMAnimation * _Nonnull (^)(CGFloat))damping{
    WeakSelf;
    return ^(CGFloat d){
        weakSelf.aniDamping = d;
        return weakSelf;
    };
}

- (FMAnimation * _Nonnull (^)(CGFloat))velocity{
    WeakSelf;
    return ^(CGFloat v){
        weakSelf.aniVelocity = v;
        return weakSelf;
    };
}

- (FMAnimation * _Nonnull (^)(UIViewAnimationOptions))options{
    WeakSelf;
    return ^(UIViewAnimationOptions o){
        weakSelf.aniOptions = o;
        return weakSelf;
    };
}

- (void (^)(void))backToOriginal{
    WeakSelf;
    return ^{
        [UIView animateWithDuration:weakSelf.aniDuration delay:weakSelf.aniDelay usingSpringWithDamping:weakSelf.aniDamping initialSpringVelocity:weakSelf.aniVelocity options:weakSelf.aniOptions animations:^{
            weakSelf.target.transform = weakSelf.baseTransform;
            if (@available(iOS 12.0, *)) {
                weakSelf.target.transform3D = weakSelf.baseTransform3D;
            } else {
                // Fallback on earlier versions
            }
            weakSelf.target.frame = weakSelf.baseFrame;
            weakSelf.target.center = weakSelf.baseCenter;
        } completion:^(BOOL finished) {
            [weakSelf resetLastProperty];
        }];
    };
}

- (void)setTarget:(UIView *)target{
    _target = target;
    [self.animations removeAllObjects];
    [self resetBaseProperty];
    [self resetLastProperty];
}

- (void)clearAnimation{
    [self.animations removeAllObjects];
}

- (void)resetBaseProperty{
    self.baseFrame = self.target.frame;
    self.baseCenter = self.target.center;
    self.baseTransform = self.target.transform;
    if (@available(iOS 12.0, *)) {
        self.baseTransform3D = self.target.transform3D;
    } else {
        // Fallback on earlier versions
    }
}

- (void)resetLastProperty{
    self.lastFrame = self.baseFrame;
    self.lastCenter = self.baseCenter;
    self.lastTransform = self.baseTransform;
    self.lastTransform3D = self.baseTransform3D;
}

- (void)startAnimation:(BOOL)reverse
{
    WeakSelf;
    if (self.groupType == FMAnimationGroupTypeSeries) { //连续的
        CGFloat delay = 0;
        FMAnimationItem *lastItem = nil;
        for (FMAnimationItem *item in self.animations) {
            item.aniDelay += delay;
            delay = item.aniDuration + item.aniDelay;
            [item startAnimation:NO];
            if (lastItem == nil) {
                lastItem = item;
            }
        }
        if (reverse) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CGFloat delay = 0;
                FMAnimationItem *lastItem = nil;
                for (int i = (int)(weakSelf.animations.count - 1); i>=0; i--) {
                    FMAnimationItem *item = weakSelf.animations[i];
                    item.aniDelay += delay;
                    delay = item.aniDuration + item.aniDelay;
                    [item startAnimation:YES];
                    if (lastItem == nil) {
                        lastItem = item;
                    }
                }
                [self.animations removeAllObjects];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf resetLastProperty];
                });
            });
        } else {
            [self.animations removeAllObjects];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf resetLastProperty];
            });
        }
    } else { // 同时的
        for (FMAnimationItem *item in self.animations) {
            if ([item isKindOfClass:[FMAnimationTransformItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCGAffineTransform:self.lastTransform] reverse:NO];
                self.lastTransform = ((FMAnimationTransformItem *)item).endTransform;
            } else if ([item isKindOfClass:[FMAnimationCenterItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCGPoint:self.lastCenter] reverse:NO];
                self.lastCenter = ((FMAnimationCenterItem *)item).endCenter;
            } else if ([item isKindOfClass:[FMAnimationFrameItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCGRect:self.lastFrame] reverse:NO];
                self.lastFrame = ((FMAnimationFrameItem *)item).endFrame;
            } else if ([item isKindOfClass:[FMAnimationTransform3DItem class]]) {
                [item caculateWithBaseValue:[NSValue valueWithCATransform3D:self.lastTransform3D] reverse:NO];
                self.lastTransform3D = ((FMAnimationTransform3DItem *)item).endTransform3D;
            } else {
                [item startAnimation:NO];
            }
        }
        [UIView animateWithDuration:self.aniDuration delay:self.aniDelay usingSpringWithDamping:self.aniDamping initialSpringVelocity:self.aniVelocity options:self.aniOptions animations:^{
            weakSelf.target.transform = weakSelf.lastTransform;
            if (@available(iOS 12.0, *)) {
                weakSelf.target.transform3D = weakSelf.lastTransform3D;
            } else {
                // Fallback on earlier versions
            }
            weakSelf.target.frame = weakSelf.lastFrame;
            weakSelf.target.center = weakSelf.lastCenter;
        } completion:^(BOOL finished) {
            [weakSelf.animations removeAllObjects];
            if (reverse) {
                [UIView animateWithDuration:weakSelf.aniDuration delay:weakSelf.aniDelay usingSpringWithDamping:weakSelf.aniDamping initialSpringVelocity:weakSelf.aniVelocity options:weakSelf.aniOptions animations:^{
                    weakSelf.target.transform = weakSelf.baseTransform;
                    if (@available(iOS 12.0, *)) {
                        weakSelf.target.transform3D = weakSelf.baseTransform3D;
                    } else {
                        // Fallback on earlier versions
                    }
                    weakSelf.target.frame = weakSelf.baseFrame;
                    weakSelf.target.center = weakSelf.baseCenter;
                } completion:^(BOOL finished) {
                    [weakSelf resetLastProperty];
                }];
            } else {
                [weakSelf resetLastProperty];
            }
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGRect))toFrame{
    WeakSelf;
    return ^(CGRect frame){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = NO;
        item.frameX = frame.origin.x;
        item.frameY = frame.origin.y;
        item.sizeW = frame.size.height;
        item.sizeH = frame.size.height;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGSize))toSize{
    WeakSelf;
    return ^(CGSize size){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = NO;
        item.sizeW = size.height;
        item.sizeH = size.height;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationFrameItem * _Nonnull (^)(CGPoint))toOrigin{
    WeakSelf;
    return ^(CGPoint origin){
        FMAnimationFrameItem *item = [[FMAnimationFrameItem alloc] init];
        item.isAdd = NO;
        item.frameX = origin.x;
        item.frameY = origin.y;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

// transform

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat, CGFloat))translate{
    WeakSelf;
    return ^(CGFloat x, CGFloat y){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item._translateX = x;
        item._translateY = y;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))translateX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item._translateX = x;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))translateY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item._translateY = y;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat, CGFloat))scale{
    WeakSelf;
    return ^(CGFloat x, CGFloat y){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item._scaleX = x;
        item._scaleY = y;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))scaleX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item._scaleX = x;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))scaleY{
    WeakSelf;
    return ^(CGFloat y){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item._scaleY = y;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransformItem * _Nonnull (^)(CGFloat))rotation{
    WeakSelf;
    return ^(CGFloat rotation){
        FMAnimationTransformItem *item = [[FMAnimationTransformItem alloc] init];
        item._rotation = rotation;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationCenterItem * _Nonnull (^)(CGFloat, CGFloat))move{
    WeakSelf;
    return ^(CGFloat x, CGFloat y){
        FMAnimationCenterItem *item = [[FMAnimationCenterItem alloc] init];
        item.isAdd = YES;
        item._centerX = x;
        item._centerY = y;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
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
        item._rotation = roration;
        item._rotationX = x;
        item._rotationY = y;
        item._rotationZ = z;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DX{
    WeakSelf;
    return ^(CGFloat roration){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._rotation = roration;
        item._rotationX = 1;
        item._rotationY = 0;
        item._rotationZ = 0;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DY{
    WeakSelf;
    return ^(CGFloat roration){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._rotation = roration;
        item._rotationX = 0;
        item._rotationY = 1;
        item._rotationZ = 0;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))rotate3DZ{
    WeakSelf;
    return ^(CGFloat roration){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._rotation = roration;
        item._rotationX = 0;
        item._rotationY = 0;
        item._rotationZ = 1;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat, CGFloat, CGFloat))scale3D{
    WeakSelf;
    return ^(CGFloat x,CGFloat y,CGFloat z){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._scaleX = x;
        item._scaleY = y;
        item._scaleZ = z;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))scale3DX{
    WeakSelf;
    return ^(CGFloat scale){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._scaleX = scale;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))scale3DY{
    WeakSelf;
    return ^(CGFloat scale){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._scaleY = scale;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))scale3DZ{
    WeakSelf;
    return ^(CGFloat scale){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._scaleZ = scale;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat, CGFloat, CGFloat))translate3D{
    WeakSelf;
    return ^(CGFloat x, CGFloat y, CGFloat z){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._translateX = x;
        item._translateY = y;
        item._translateZ = z;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))translate3DX{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._translateX = x;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))translate3DY{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._translateY = x;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

- (FMAnimationTransform3DItem * _Nonnull (^)(CGFloat))translate3DZ{
    WeakSelf;
    return ^(CGFloat x){
        FMAnimationTransform3DItem *item = [[FMAnimationTransform3DItem alloc] init];
        item._translateZ = x;
        item.next = weakSelf;
        [item set_startBlock:^(BOOL reverse){
            [weakSelf startAnimation:reverse];
        }];
        [weakSelf.animations addObject:item];
        return item;
    };
}

@end

