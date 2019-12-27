//
//  FMAnimationOtherItem.m
//  Animation
//
//  Created by 郑桂华 on 2019/12/19.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "FMAnimationOtherItem.h"
#import "FMAnimation.h"

@implementation FMAnimationOtherItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layerCornerRadius = FMAnimationDefault;
        self.viewOpaque = FMAnimationDefault;
    }
    return self;
}

- (void)startAnimation{
    [UIView animateWithDuration:self.aniDuration delay:self.aniDelay options:UIViewAnimationOptionCurveLinear animations:^{
        FMAnimationVerify(self.layerCornerRadius, ^{
            self.next.target.layer.cornerRadius = self.layerCornerRadius;
        });
        FMAnimationVerify(self.viewOpaque, ^{
            self.next.target.opaque = self.viewOpaque;
        });
        if (self.layerBorder) {
            self.next.target.layer.borderColor = self.layerBorder.borderColor.CGColor;
            self.next.target.layer.borderWidth = self.layerBorder.borderWidth;
        }
        if (self.layerShadow) {
            self.next.target.layer.shadowColor = self.layerShadow.shadowColor.CGColor;
            self.next.target.layer.shadowOffset = self.layerShadow.shadowOffset;
            self.next.target.layer.shadowPath = self.layerShadow.shadowPath.CGPath;
            self.next.target.layer.shadowOpacity = self.layerShadow.shadowOpacity;
            self.next.target.layer.shadowRadius = self.layerShadow.shadowRadius;
        }
        if (self.viewBgColor) {
            self.next.target.backgroundColor = self.viewBgColor;
        }
    } completion:^(BOOL finished){
        
    }];
}


@end
