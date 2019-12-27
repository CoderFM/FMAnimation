//
//  FMAnimationCenterItem.h
//  FMAnimation
//
//  Created by 郑桂华 on 2019/12/23.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationCenterItem : FMAnimationItem

@property(nonatomic, assign)BOOL isAdd;

@property(nonatomic, assign)CGFloat _centerX;
@property(nonatomic, assign)CGFloat _centerY;

@property(nonatomic, assign)CGPoint endCenter;

@end

NS_ASSUME_NONNULL_END
