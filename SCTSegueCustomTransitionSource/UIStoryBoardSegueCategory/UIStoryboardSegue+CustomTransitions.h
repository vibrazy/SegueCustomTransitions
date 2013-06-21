//
//  UIStoryboardSegue+CustomTransitions.h
//  SegueCustomTransitions (Inspired by MHNatGeoViewControllerTransition https://github.com/michaelhenry/MHNatGeoViewControllerTransition)
//
//  Created by Daniel Tavares on 19/06/2013.
//  Copyright (c) 2013 Daniel Tavares. All rights reserved. (vibrazy@hotmail.com)
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SCTTransitionViewController.h"

/*
 Extra Classes to be used when creating custom animations
 */

@interface UIStoryboardSegue (CustomTransitions)
-(void)sourceStartAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion;
-(void)destinationStartAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion;
-(void)sourceDismissAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion;
-(void)destinationDismissAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion;
-(void)performCustomAnimation;
CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);
@end
