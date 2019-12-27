//
//  FMAnimationShadow.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationShadow.h"
#import "FMAnimationConstant.h"

@implementation FMAnimationShadow

+ (instancetype)shadowColor:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius{
    FMAnimationShadow *model = [[FMAnimationShadow alloc] init];
    model.shadowColor = color;
    model.shadowOpacity = opacity;
    model.shadowRadius = radius;
    return model;
}

- (FMAnimationShadow * _Nonnull (^)(UIBezierPath * _Nonnull))path{
    WeakSelf;
    return ^(UIBezierPath *path){
        weakSelf.shadowPath = path;
        return weakSelf;
    };
}

- (FMAnimationShadow * _Nonnull (^)(CGSize))offset{
    WeakSelf;
    return ^(CGSize offset){
        weakSelf.shadowOffset = offset;
        return weakSelf;
    };
}

@end
