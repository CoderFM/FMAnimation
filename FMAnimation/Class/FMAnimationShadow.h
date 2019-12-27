//
//  FMAnimationShadow.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationShadow : NSObject
@property(nonatomic, assign)CGSize shadowOffset;
@property(nonatomic, strong)UIColor *shadowColor;
@property(nonatomic, assign)CGFloat shadowOpacity;
@property(nonatomic, assign)CGFloat shadowRadius;
@property(nonatomic, strong)UIBezierPath *shadowPath;

+ (instancetype)shadowColor:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius;

@property(nonatomic, copy, readonly)FMAnimationShadow *(^path)(UIBezierPath *);
@property(nonatomic, copy, readonly)FMAnimationShadow *(^offset)(CGSize);
@end

NS_ASSUME_NONNULL_END
