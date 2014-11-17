//
//  UIView+SJCustomBlockAnimation.m
//  CustomAnimation
//
//  Created by 付世健 on 14-11-10.
//  Copyright (c) 2014年 fsj. All rights reserved.
//

#import "UIView+SJCustomBlockAnimation.h"
#import <objc/runtime.h>
#import "SJSaveAnimationState.h"
static void *SJ_currentAnimationContent = NULL;
static void *SJ_AnimationContent = &SJ_AnimationContent;

static NSMutableArray *savedStateArr;

@implementation UIView (SJCustomBlockAnimation)

+(void)load
{
    
    SEL originalSel = @selector(actionForLayer:forKey:);
    SEL extendedSel = @selector(SJ_actionForLayer:forKey:);
    
    Method originalMethod = class_getInstanceMethod([self class], originalSel);
    Method extendedMethod = class_getInstanceMethod([self class], extendedSel);
    
    const char *originalType = method_getTypeEncoding(originalMethod);
    const char *extendedType = method_getTypeEncoding(extendedMethod);

    // 覆盖父类的Sel的IMP，不能修改该类的Sel的IMP
    if (class_addMethod([self class], originalSel, method_getImplementation(extendedMethod), extendedType)) {
        
        class_replaceMethod([self class], extendedSel, method_getImplementation(originalMethod), originalType);
        
    }else{
       /*
        *  IMP imp1 = method_getImplementation(m1);
        *  IMP imp2 = method_getImplementation(m2);
        *  method_setImplementation(m1, imp2);
        *  method_setImplementation(m2, imp1);
        */
        method_exchangeImplementations(originalMethod, extendedMethod);
    }
}


-(id<CAAction>)SJ_actionForLayer:(CALayer *)layer forKey:(NSString *)key
{
    if (SJ_currentAnimationContent == SJ_AnimationContent) {
        
        SJSaveAnimationState *savedState = [SJSaveAnimationState saveStateWithLayer:layer keyPath:key];
        [[UIView SJ_savedAnimationStates] addObject:savedState];
        
        return (id <CAAction>) [NSNull null];
    }
    
    return [self SJ_actionForLayer:layer forKey:key];
    
}

+(NSMutableArray *)SJ_savedAnimationStates
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        savedStateArr = [[NSMutableArray alloc] init];
    });
    return savedStateArr;
}


+(void)SJ_animationWithDuration:(NSTimeInterval)duration animation:(void (^)(void))animation
{
    SJ_currentAnimationContent = SJ_AnimationContent;
    
    // 执行动画 (它将触发交换后的 delegate 方法)
    animation();
    
    
    [[self SJ_savedAnimationStates] enumerateObjectsUsingBlock:^(SJSaveAnimationState *obj, NSUInteger idx, BOOL *stop) {
       
        CALayer *layer = obj.layer;
        NSString *keyPath = obj.keyPath;
        id oldValue = obj.oldValue;
        id newValue = [layer valueForKey:keyPath];
        
        // 关键帧动画
        CGFloat easing = 0.2;
        CAMediaTimingFunction *easeIn = [CAMediaTimingFunction functionWithControlPoints:1.0 :0.0 :(1.0 - easing) :easing];
        CAMediaTimingFunction *easeOut = [CAMediaTimingFunction functionWithControlPoints:easing :0.0 :0.0 :1.0];
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keyPath];
        
        anim.duration = duration;
        anim.keyTimes = @[@(0),@(0.35),@(1)];
        anim.values = @[oldValue,newValue,oldValue];
        anim.timingFunctions = @[easeIn,easeOut];
        
        //不带动画地返回原来的值
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [layer setValue:oldValue forKey:keyPath];
        [CATransaction commit];
        
        [layer addAnimation:anim forKey:keyPath];
    }];

    [[self SJ_savedAnimationStates] removeAllObjects];
    SJ_currentAnimationContent = NULL;
}


@end
