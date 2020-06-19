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
///动画对象
@property(nonatomic, weak)UIView *target;
///创建时  动画最初始的属性
@property(nonatomic, assign)CGRect baseFrame;
///创建时  动画最初始的属性
@property(nonatomic, assign)CGPoint baseCenter;
///创建时  动画最初始的属性
@property(nonatomic, assign)CGAffineTransform baseTransform;
///创建时  动画最初始的属性
@property(nonatomic, assign)CATransform3D baseTransform3D;

///动画执行完的属性   但并不一定就是动画完最终的属性
@property(nonatomic, assign)CGRect lastFrame;
///动画执行完的属性
@property(nonatomic, assign)CGPoint lastCenter;
///动画执行完的属性
@property(nonatomic, assign)CGAffineTransform lastTransform;
///动画执行完的属性
@property(nonatomic, assign)CATransform3D lastTransform3D;

///动画时间  仅当同时执行时有效或者回到最初始位置时 FMAnimationGroupTypeConcurrent
@property(nonatomic, copy, readonly)FMAnimation *(^duration)(NSTimeInterval interval);
///动画延迟时间  仅当同时执行时有效或者回到最初始位置时 FMAnimationGroupTypeConcurrent
@property(nonatomic, copy, readonly)FMAnimation *(^delay)(NSTimeInterval interval);
///动画弹性系数  仅当同时执行时有效或者回到最初始位置时 FMAnimationGroupTypeConcurrent
@property(nonatomic, copy, readonly)FMAnimation *(^damping)(CGFloat damping);
///动画初始速度  仅当同时执行时有效或者回到最初始位置时 FMAnimationGroupTypeConcurrent
@property(nonatomic, copy, readonly)FMAnimation *(^velocity)(CGFloat velocity);
///动画过程  仅当同时执行时有效或者回到最初始位置时 FMAnimationGroupTypeConcurrent
@property(nonatomic, copy, readonly)FMAnimation *(^options)(UIViewAnimationOptions options);

- (void)clearAnimation;
///动画类型 FMAnimationGroupTypeSeries 一个一个串联执行 FMAnimationGroupTypeConcurrent 同时执行需设置duration,delay等属性
@property(nonatomic, copy, readonly)FMAnimation *(^type)(FMAnimationGroupType type);
///回到最初始位置
@property(nonatomic, copy, readonly)void(^backToOriginal)(void);
@end

NS_ASSUME_NONNULL_END
