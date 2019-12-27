//
//  FMAnimationTransform3DItem.h
//  FMAnimation
//
//  Created by 郑桂华 on 2019/12/25.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationTransform3DItem : FMAnimationItem

@property(nonatomic, assign)BOOL isAdd;

@property(nonatomic, assign)CGFloat _translateX;
@property(nonatomic, assign)CGFloat _translateY;
@property(nonatomic, assign)CGFloat _translateZ;

@property(nonatomic, assign)CGFloat _scaleX;
@property(nonatomic, assign)CGFloat _scaleY;
@property(nonatomic, assign)CGFloat _scaleZ;

@property(nonatomic, assign)CGFloat _rotation;
@property(nonatomic, assign)CGFloat _rotationX;
@property(nonatomic, assign)CGFloat _rotationY;
@property(nonatomic, assign)CGFloat _rotationZ;

@property(nonatomic, assign)CGFloat _m34;
@property(readonly)FMAnimationTransform3DItem *(^m34)(CGFloat);
@property(nonatomic, assign)CATransform3D endTransform3D;

@end

NS_ASSUME_NONNULL_END
