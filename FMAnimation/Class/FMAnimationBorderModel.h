//
//  FMAnimationBorderModel.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationBorderModel : NSObject

/*
 self.redView.layer.borderWidth = 1;
 self.redView.layer.borderColor = [UIColor greenColor].CGColor;
 */

@property(nonatomic, assign)CGFloat borderWidth;
@property(nonatomic, strong)UIColor *borderColor;

+ (instancetype)modelWithWidth:(CGFloat)width color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
