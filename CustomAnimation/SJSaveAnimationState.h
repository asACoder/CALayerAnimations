//
//  SJSaveAnimationState.h
//  CustomAnimation
//
//  Created by 付世健 on 14-11-10.
//  Copyright (c) 2014年 fsj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJSaveAnimationState : NSObject

@property(nonatomic,retain) CALayer *layer;
@property(nonatomic,retain) NSString *keyPath;
@property(nonatomic,retain) id  oldValue;

+(id)saveStateWithLayer:(CALayer*)layer keyPath:(NSString *)keyPath;

@end
