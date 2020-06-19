//
//  FMAnimationConstant.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/7.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#ifndef FMAnimationConstant_h
#define FMAnimationConstant_h

#define WeakSelf __weak typeof(self) weakSelf = self
///动画同时该怎么做
typedef NS_ENUM(NSUInteger, FMAnimationGroupType) {
    //连续  一个个执行动画
    FMAnimationGroupTypeSeries,
    // 同时
    FMAnimationGroupTypeConcurrent,
};

static NSTimeInterval const FMAnimationDefaultDuration = 1;// 秒
static NSTimeInterval const FMAnimationDefaultDelay = 0;//

#endif /* FMAnimationConstant_h */
