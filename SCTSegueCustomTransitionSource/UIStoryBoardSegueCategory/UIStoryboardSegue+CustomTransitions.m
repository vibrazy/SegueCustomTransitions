//
//  UIStoryboardSegue+CustomTransitions.m
//  SegueCustomTransitions (Inspired by MHNatGeoViewControllerTransition https://github.com/michaelhenry/MHNatGeoViewControllerTransition)
//
//  Created by Daniel Tavares on 19/06/2013.
//  Copyright (c) 2013 Daniel Tavares. All rights reserved. (vibrazy@hotmail.com)
//

#import "UIStoryboardSegue+CustomTransitions.h"

static NSTimeInterval duration = 0.45f;

@implementation UIStoryboardSegue (CustomTransitions)

-(void)performCustomAnimation
{
    [[self sourceViewController] presentViewController:[self destinationViewController] withSegue:self completion:nil];
}

-(void)sourceStartAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:duration animations:^{
        [layer setPosition:CGPointMake(-layer.frame.size.width*0.5, layer.frame.size.height*0.5)];
    }completion:^(BOOL finished) {
        if (completion) {
            completion(finished);  
        }
    }];
}
-(void)destinationStartAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion
{
    [layer setPosition:CGPointMake(layer.frame.size.width*1.5, layer.frame.size.height*0.5)];
    
    [UIView animateWithDuration:duration animations:^{
        [layer setPosition:CGPointMake(layer.frame.size.width*0.5, layer.frame.size.height*0.5)];
    }completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}
-(void)sourceDismissAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:duration animations:^{
        [layer setPosition:CGPointMake(layer.frame.size.width*0.5, layer.frame.size.height*0.5)];
    }completion:^(BOOL finished) {
        if (completion)
        {
            completion(finished);
        }
    }];
}
-(void)destinationDismissAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:duration animations:^{
          [layer setPosition:CGPointMake(layer.frame.size.width*1.5, layer.frame.size.height*0.5)];
    }completion:^(BOOL finished) {
        if (completion)
        {
            completion(finished);
        }
    }];
}

#pragma mark - Math Utils
CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
};

CGFloat RadiansToDegrees(CGFloat radians)
{
    return radians * 180 / M_PI;
};
@end
