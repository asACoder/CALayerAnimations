//
//  SJSaveAnimationState.m
//  CustomAnimation
//
//  Created by 付世健 on 14-11-10.
//  Copyright (c) 2014年 fsj. All rights reserved.
//

#import "SJSaveAnimationState.h"

@implementation SJSaveAnimationState

+(id)saveStateWithLayer:(CALayer *)layer keyPath:(NSString *)keyPath
{
    SJSaveAnimationState *savedSate = [[SJSaveAnimationState alloc] init];
    savedSate.layer = layer;
    savedSate.keyPath = keyPath;
    savedSate.oldValue = [layer valueForKey:keyPath];
    
    return savedSate;
}

@end
