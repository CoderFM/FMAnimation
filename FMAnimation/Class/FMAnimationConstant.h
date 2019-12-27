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

typedef NS_ENUM(NSUInteger, FMAnimationGroupType) {//动画同时该怎么做
    FMAnimationGroupTypeSeries, //连续
    FMAnimationGroupTypeConcurrent,// 同时
};

static NSTimeInterval const FMAnimationDefaultDuration = 1;// 秒
static NSTimeInterval const FMAnimationDefaultDelay = 0;//

#endif /* FMAnimationConstant_h */
