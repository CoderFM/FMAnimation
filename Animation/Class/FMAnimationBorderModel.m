//
//  FMAnimationBorderModel.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationBorderModel.h"

@implementation FMAnimationBorderModel

+ (instancetype)modelWithWidth:(CGFloat)width color:(UIColor *)color{
    FMAnimationBorderModel *model = [[FMAnimationBorderModel alloc] init];
    model.borderColor = color;
    model.borderWidth = width;
    return model;
}

@end
