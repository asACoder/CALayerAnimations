//
//  UIView+SJCustomBlockAnimation.h
//  CustomAnimation
//
//  Created by 付世健 on 14-11-10.
//  Copyright (c) 2014年 fsj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SJCustomBlockAnimation)


-(id<CAAction>) SJ_actionForLayer:(CALayer*)lay forKey:(NSString*)key;

+(NSMutableArray*)SJ_savedAnimationStates;

+(void)SJ_animationWithDuration:(NSTimeInterval)duration
                      animation:(void (^)(void))animation;


@end
