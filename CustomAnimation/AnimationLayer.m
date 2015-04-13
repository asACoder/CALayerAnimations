//
//  AnimationLayer.m
//  CustomAnimation
//
//  Created by 付世健 on 14-11-9.
//  Copyright (c) 2014年 fsj. All rights reserved.
//

#import "AnimationLayer.h"

//static int count;

@implementation AnimationLayer


//-(void)setProgress:(CGFloat)progress
//{
//    _progress = progress;
//    [self setNeedsDisplay];
//}

//-(void)drawInContext:(CGContextRef)ctx
//{
//    
//    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
//    CGContextSetLineWidth(ctx, 1);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    
////    CGContextAddEllipseInRect(ctx, self.bounds);
//    
//    // note：弧度制
//    CGContextAddArc(ctx, center.x, center.y, 40, 0, (135 / 180) * M_PI, 0);
//    CGContextStrokePath(ctx);
//    
//    
////    UIBezierPath *path = [UIBezierPath bezierPath];
////    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
////    [path addArcWithCenter:center radius:40 startAngle:0 endAngle:360 * self.progress clockwise:NO];
////    
////    [path setLineWidth:2];
////    [[UIColor redColor] set];
////    [path stroke];
//}



// note
@dynamic progress;

+ (BOOL)needsDisplayForKey:(NSString *)key
{

    if ([key isEqualToString:@"progress"]) {
        return YES;
    }else{
        return [super needsDisplayForKey:key];
    }
}



-(id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"progress"]) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = 12.0f;
//        NSLog(@"[self presentationLayer] progress] %f",[[self presentationLayer] progress]);
        animation.fromValue = @([[self presentationLayer] progress]);
        return animation;
        
    }else {
        return [super actionForKey:event];
    }
}


-(void)display
{
//    NSLog(@"%d",count++);
//    NSLog(@"self.progress %f",self.progress);
    
    CGFloat progress = [self.presentationLayer progress];
//    NSLog(@"progress  = %f",progress);

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);

    CGFloat endAngle =  2 * M_PI * progress;

    CGContextAddArc(ctx, center.x, center.y, 40, 0, endAngle, 0);
    CGContextAddArc(ctx, center.x, center.y, 0, endAngle, 0, 1);

//    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
    
    self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    
    UIGraphicsEndImageContext();
}



//-(id)init
//{
//    self = [super init];
//    if (self) {
//        return self;
//    }
//    return self;
//}

// use as presentation layers
//-(id)initWithLayer:(id)layer
//{
//    self = [super initWithLayer:layer];
//    
//    if (self) {
//        if ([layer isKindOfClass:[AnimationLayer class]]) {
//            
//            self.progress =  [(AnimationLayer*)layer progress];
//            NSLog(@"self.progress %f ",self.progress);
//        }
//    }
//    return self;
//}

@end
