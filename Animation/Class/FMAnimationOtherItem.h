//
//  FMAnimationOtherItem.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationItem.h"
#import "FMAnimationShadowModel.h"
#import "FMAnimationBorderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationOtherItem : FMAnimationItem
// 背景色
@property(nonatomic, strong)UIColor *viewBgColor;
// 圆角
@property(nonatomic, assign)CGFloat layerCornerRadius;
// 阴影
@property(nonatomic, strong)FMAnimationShadowModel *layerShadow;
// 边框
@property(nonatomic, strong)FMAnimationBorderModel *layerBorder;
// 透明度
@property(nonatomic, assign)CGFloat viewOpaque;
/*
 self.redView.layer.borderWidth = 1;
 self.redView.layer.borderColor = [UIColor greenColor].CGColor;
 self.redView.layer.cornerRadius = 20;
 
 self.redView.layer.shadowColor = [UIColor purpleColor].CGColor;
 self.redView.layer.shadowOffset = CGSizeMake(0, 0);
 self.redView.layer.shadowRadius = 10;
 self.redView.layer.shadowOpacity = 0.7;
 
 */

@end

NS_ASSUME_NONNULL_END
