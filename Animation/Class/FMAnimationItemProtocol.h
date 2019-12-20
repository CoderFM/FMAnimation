//
//  FMAnimationItemProtocol.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FMAnimationFrameItem, FMAnimationTransformItem, FMAnimationOtherItem, FMAnimationBorderModel, FMAnimationShadowModel;
@protocol FMAnimationItemProtocol

// frame
@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^addX)(CGFloat x);
@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^addY)(CGFloat y);
@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^addW)(CGFloat w);
@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^addH)(CGFloat h);

@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^toX)(CGFloat x);
@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^toY)(CGFloat y);
@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^toW)(CGFloat w);
@property(nonatomic, copy, readonly)FMAnimationFrameItem *(^toH)(CGFloat h);

// transform
@property(nonatomic, copy, readonly)FMAnimationTransformItem *(^translateX)(CGFloat x);
@property(nonatomic, copy, readonly)FMAnimationTransformItem *(^translateY)(CGFloat y);
@property(nonatomic, copy, readonly)FMAnimationTransformItem *(^scaleX)(CGFloat x);
@property(nonatomic, copy, readonly)FMAnimationTransformItem *(^scaleY)(CGFloat y);
@property(nonatomic, copy, readonly)FMAnimationTransformItem *(^rotation)(CGFloat rotation);

// other
@property(nonatomic, copy, readonly)FMAnimationOtherItem *(^bgColor)(UIColor *color);
@property(nonatomic, copy, readonly)FMAnimationOtherItem *(^cornerRadius)(CGFloat radius);
@property(nonatomic, copy, readonly)FMAnimationOtherItem *(^shadow)(FMAnimationShadowModel *shadow);
@property(nonatomic, copy, readonly)FMAnimationOtherItem *(^border)(FMAnimationBorderModel *border);
@property(nonatomic, copy, readonly)FMAnimationOtherItem *(^opaque)(CGFloat opaque);

@end

NS_ASSUME_NONNULL_END
