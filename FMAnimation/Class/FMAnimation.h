//
//  FMAnimation.h
//  Animation
//
//  Created by 郑桂华 on 2019/11/22.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMAnimationConstant.h"
#import "FMAnimationItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimation : NSObject<FMAnimationItemProtocol>

@property(nonatomic, weak)UIView *target;
@property(nonatomic, assign)CGRect baseFrame;
@property(nonatomic, assign)CGPoint baseCenter;
@property(nonatomic, assign)CGAffineTransform baseTransform;
@property(nonatomic, assign)CATransform3D baseTransform3D;
@property(nonatomic, assign)CGFloat baseOpaque;

- (void)clearAnimation;

@property(nonatomic, copy, readonly)FMAnimation *(^type)(FMAnimationGroupType type);

@end

NS_ASSUME_NONNULL_END
