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
/// X方向增加  改变Frame
@property(readonly)FMAnimationFrameItem *(^addX)(CGFloat x);
/// Y方向增加  改变Frame
@property(readonly)FMAnimationFrameItem *(^addY)(CGFloat y);
/// 增加宽度 -> 右  改变Frame
@property(readonly)FMAnimationFrameItem *(^addW)(CGFloat w);
/// 增加高度 -> 下  改变Frame
@property(readonly)FMAnimationFrameItem *(^addH)(CGFloat h);

/// X移动到该值  改变Frame
@property(readonly)FMAnimationFrameItem *(^toX)(CGFloat x);
/// Y移动到该值  改变Frame
@property(readonly)FMAnimationFrameItem *(^toY)(CGFloat y);
/// 宽度指定大小  改变Frame
@property(readonly)FMAnimationFrameItem *(^toW)(CGFloat w);
/// 高度指定大小  改变Frame
@property(readonly)FMAnimationFrameItem *(^toH)(CGFloat h);
/// 至该Frame  改变Frame
@property(readonly)FMAnimationFrameItem *(^toFrame)(CGRect frame);
/// 至该Size  改变Frame
@property(readonly)FMAnimationFrameItem *(^toSize)(CGSize size);
/// 至该origin  改变Frame
@property(readonly)FMAnimationFrameItem *(^toOrigin)(CGPoint origin);

// transform
///平移X和Y  改变Transform
@property(readonly)FMAnimationTransformItem *(^translate)(CGFloat x, CGFloat y);
///平移X 改变Transform
@property(readonly)FMAnimationTransformItem *(^translateX)(CGFloat x);
///平移Y 改变Transform
@property(readonly)FMAnimationTransformItem *(^translateY)(CGFloat y);
///缩放X和Y 改变Transform
@property(readonly)FMAnimationTransformItem *(^scale)(CGFloat x, CGFloat y);
///缩放X 改变Transform
@property(readonly)FMAnimationTransformItem *(^scaleX)(CGFloat x);
///缩放Y 改变Transform
@property(readonly)FMAnimationTransformItem *(^scaleY)(CGFloat y);
///旋转 改变Transform
@property(readonly)FMAnimationTransformItem *(^rotation)(CGFloat rotation);

// other
///背景色
@property(readonly)FMAnimationOtherItem *(^bgColor)(UIColor *color);
///圆角
@property(readonly)FMAnimationOtherItem *(^cornerRadius)(CGFloat radius);
///阴影
@property(readonly)FMAnimationOtherItem *(^shadow)(FMAnimationShadow *shadow);
///边框
@property(readonly)FMAnimationOtherItem *(^border)(FMAnimationBorder *border);
///透明度
@property(readonly)FMAnimationOtherItem *(^opaque)(CGFloat opaque);

//center
/// 移动(增加X和Y) 改变Center
@property(readonly)FMAnimationCenterItem *(^move)(CGFloat x, CGFloat y);
/// 增加X 改变Center
@property(readonly)FMAnimationCenterItem *(^moveX)(CGFloat x);
/// 增加Y 改变Center
@property(readonly)FMAnimationCenterItem *(^moveY)(CGFloat y);
/// 至X 改变Center
@property(readonly)FMAnimationCenterItem *(^moveToX)(CGFloat x);
/// 至Y 改变Center
@property(readonly)FMAnimationCenterItem *(^moveToY)(CGFloat y);

//transform3D
///围绕X轴旋转 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^rotate3DX)(CGFloat rotation) API_AVAILABLE(ios(12.0),tvos(12.0));
///围绕Y轴旋转 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^rotate3DY)(CGFloat rotation) API_AVAILABLE(ios(12.0),tvos(12.0));
///围绕Z轴旋转 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^rotate3DZ)(CGFloat rotation) API_AVAILABLE(ios(12.0),tvos(12.0));
///3D旋转 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^rotate3D)(CGFloat rotation, CGFloat x, CGFloat y, CGFloat z) API_AVAILABLE(ios(12.0),tvos(12.0));

///3D缩放 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^scale3D)(CGFloat x, CGFloat y, CGFloat z) API_AVAILABLE(ios(12.0),tvos(12.0));
///X轴缩放 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^scale3DX)(CGFloat scale) API_AVAILABLE(ios(12.0),tvos(12.0));
///Y轴缩放 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^scale3DY)(CGFloat scale) API_AVAILABLE(ios(12.0),tvos(12.0));
///Z轴缩放 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^scale3DZ)(CGFloat scale) API_AVAILABLE(ios(12.0),tvos(12.0));

///3D平移 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^translate3D)(CGFloat x, CGFloat y, CGFloat z) API_AVAILABLE(ios(12.0),tvos(12.0));
///X轴平移 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^translate3DX)(CGFloat x) API_AVAILABLE(ios(12.0),tvos(12.0));
///Y轴平移 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^translate3DY)(CGFloat y) API_AVAILABLE(ios(12.0),tvos(12.0));
///Z轴平移 改变Transform3D
@property(readonly)FMAnimationTransform3DItem *(^translate3DZ)(CGFloat z) API_AVAILABLE(ios(12.0),tvos(12.0));

@end

NS_ASSUME_NONNULL_END
