//
//  FMAnimationFrameItem.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/11.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationFrameItem : FMAnimationItem

@property(nonatomic, assign)BOOL isAdd;

@property(nonatomic, assign)CGFloat frameX;
@property(nonatomic, assign)CGFloat frameY;
@property(nonatomic, assign)CGFloat sizeW;
@property(nonatomic, assign)CGFloat sizeH;

@property(nonatomic, assign)CGRect endFrame;


@end

NS_ASSUME_NONNULL_END
