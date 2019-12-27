//
//  FMAnimationBorder.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationBorder.h"

@implementation FMAnimationBorder

+ (instancetype)borderWidth:(CGFloat)width color:(UIColor *)color{
    FMAnimationBorder *model = [[FMAnimationBorder alloc] init];
    model.borderColor = color;
    model.borderWidth = width;
    return model;
}

@end
