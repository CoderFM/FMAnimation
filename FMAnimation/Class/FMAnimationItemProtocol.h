//
//  FMAnimationItemProtocol.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FMAnimationFrameItem, FMAnimationTransformItem, FMAnimationOtherItem, FMAnimationCenterItem, FMAnimationTransform3DItem, FMAnimationBorder, FMAnimationShadow;
@protocol FMAnimationItemProtocol

// frame
@property(readonly)FMAnimationFrameItem *(^addX)(CGFloat x);
@property(readonly)FMAnimationFrameItem *(^addY)(CGFloat y);
@property(readonly)FMAnimationFrameItem *(^addW)(CGFloat w);
@property(readonly)FMAnimationFrameItem *(^addH)(CGFloat h);

@property(readonly)FMAnimationFrameItem *(^toX)(CGFloat x);
@property(readonly)FMAnimationFrameItem *(^toY)(CGFloat y);
@property(readonly)FMAnimationFrameItem *(^toW)(CGFloat w);
@property(readonly)FMAnimationFrameItem *(^toH)(CGFloat h);

// transform
@property(readonly)FMAnimationTransformItem *(^translateX)(CGFloat x);
@property(readonly)FMAnimationTransformItem *(^translateY)(CGFloat y);
@property(readonly)FMAnimationTransformItem *(^scaleX)(CGFloat x);
@property(readonly)FMAnimationTransformItem *(^scaleY)(CGFloat y);
@property(readonly)FMAnimationTransformItem *(^rotation)(CGFloat rotation);

// other
@property(readonly)FMAnimationOtherItem *(^bgColor)(UIColor *color);
@property(readonly)FMAnimationOtherItem *(^cornerRadius)(CGFloat radius);
@property(readonly)FMAnimationOtherItem *(^shadow)(FMAnimationShadow *shadow);
@property(readonly)FMAnimationOtherItem *(^border)(FMAnimationBorder *border);
@property(readonly)FMAnimationOtherItem *(^opaque)(CGFloat opaque);

//center
@property(readonly)FMAnimationCenterItem *(^moveX)(CGFloat x);
@property(readonly)FMAnimationCenterItem *(^moveY)(CGFloat y);
@property(readonly)FMAnimationCenterItem *(^moveToX)(CGFloat x);
@property(readonly)FMAnimationCenterItem *(^moveToY)(CGFloat y);

//transform3D
@property(readonly)FMAnimationTransform3DItem *(^rotate3DX)(CGFloat rotation);
@property(readonly)FMAnimationTransform3DItem *(^rotate3DY)(CGFloat rotation);
@property(readonly)FMAnimationTransform3DItem *(^rotate3DZ)(CGFloat rotation);
@property(readonly)FMAnimationTransform3DItem *(^rotate3D)(CGFloat rotation, CGFloat x, CGFloat y, CGFloat z);

@property(readonly)FMAnimationTransform3DItem *(^scale3DX)(CGFloat scale);
@property(readonly)FMAnimationTransform3DItem *(^scale3DY)(CGFloat scale);

@end

NS_ASSUME_NONNULL_END
