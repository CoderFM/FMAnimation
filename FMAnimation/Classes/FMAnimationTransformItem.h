//
//  FMAnimationTransformItem.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/18.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationTransformItem : FMAnimationItem

@property(nonatomic, assign)CGFloat _translateX;
@property(nonatomic, assign)CGFloat _translateY;
@property(nonatomic, assign)CGFloat _scaleX;
@property(nonatomic, assign)CGFloat _scaleY;
@property(nonatomic, assign)CGFloat _rotation;

@property(nonatomic, assign)CGAffineTransform endTransform;

@end

NS_ASSUME_NONNULL_END
