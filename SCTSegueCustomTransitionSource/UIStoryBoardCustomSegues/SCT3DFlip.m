//
//  SCT3DFlip.m
//  SegueCustomTransitions (Inspired by MHNatGeoViewControllerTransition https://github.com/michaelhenry/MHNatGeoViewControllerTransition)
//
//  Created by Daniel Tavares on 19/06/2013.
//  Copyright (c) 2013 Daniel Tavares. All rights reserved. (vibrazy@hotmail.com)
//

#import "SCT3DFlip.h"

@implementation SCT3DFlip

-(void)perform
{
    [self performCustomAnimation];
}

#pragma mark - Custom Transforms
-(CATransform3D)sourceInitialTransform
{
    return CATransform3DIdentity;
}


-(CATransform3D)sourceEndTransform
{
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, M_PI_2, 0.0,1.0,0.0);
    t = CATransform3DTranslate(t, -10.f, 0, 0);
    return t;
}

-(CATransform3D)destinationInitialTransform
{
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, M_PI_2, 0.0,1.0,0.0);
    t = CATransform3DTranslate(t, 620.f, 0, 0);
    
    return t;
}

-(CATransform3D)destinationEndTransform
{
    return CATransform3DIdentity;
}


#pragma mark - Animation
-(void)sourceStartAnimationForLayer:(CALayer*)layer completionBlock:(void (^)(BOOL finished))completion
{
        [UIView animateWithDuration:0.45 animations:^{
            [layer setTransform:[self sourceEndTransform]];
            [layer setOpacity:0.0];
        } completion:completion];
}

-(void)destinationStartAnimationForLayer:(CALayer*)layer
                         completionBlock:(void (^)(BOOL finished))completion
{
    
   [layer setTransform:[self destinationInitialTransform
                        ]];
    [layer setOpacity:0.0];
    
    [UIView animateWithDuration:0.45 animations:^{
        [layer setTransform:[self destinationEndTransform]];
         [layer setOpacity:1.0];
    } completion:completion];   
    
       
}

-(void)sourceDismissAnimationForLayer:(CALayer*)layer
                      completionBlock:(void (^)(BOOL finished))completion
{
    
    [UIView animateWithDuration:0.45 animations:^{
        [layer setTransform:[self sourceInitialTransform]];
        [layer setOpacity:1.0];
    } completion:completion];
}

-(void)destinationDismissAnimationForLayer:(CALayer*)layer
                           completionBlock:(void (^)(BOOL finished))completion
{
  
    [UIView animateWithDuration:0.45 animations:^{
        [layer setTransform:[self destinationInitialTransform]];
        [layer setOpacity:0.0];
    } completion:completion];
    
  
}
@end
