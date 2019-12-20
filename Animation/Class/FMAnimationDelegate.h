//
//  FMAnimationDelegate.h
//  Animation
//
//  Created by 郑桂华 on 2019/12/9.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^FMAnimationStartBlock)(CAAnimation * _Nullable anim);
typedef void(^FMAnimationStopBlock)(CAAnimation * _Nullable anim, BOOL finished);

NS_ASSUME_NONNULL_BEGIN

@interface FMAnimationDelegate : NSObject

@property(nonatomic, copy)FMAnimationStartBlock start;
@property(nonatomic, copy)FMAnimationStopBlock stop;

@end

NS_ASSUME_NONNULL_END
