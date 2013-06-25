//
//  SCTTransitionViewController.m
//  SegueCustomTransitions (Inspired by MHNatGeoViewControllerTransition https://github.com/michaelhenry/MHNatGeoViewControllerTransition)
//
//  Created by Daniel Tavares on 18/06/2013.
//  Copyright (c) 2013 Daniel Tavares. All rights reserved. (vibrazy@hotmail.com)
//

#import "SCTTransitionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#pragma mark - Convert Degrees to Radian
double radianFromDegree(float degrees) {
    return (degrees / 180) * M_PI;
}

@interface SCTTransitionViewController() @end

@implementation SCTTransitionViewController

@synthesize sourceView = _sourceView;
@synthesize destinationView = _destinationView;
@synthesize dismissing = _dismissing;
@synthesize segue = _segue;

#pragma mark - Helper
+(UIWindow *)topWindow
{
    return [[[UIApplication sharedApplication] windows] lastObject];
}

- (id)initWithSourceView:(UIView *)sourceView
         destinationView:(UIView *)destinationView
                   segue:(UIStoryboardSegue *)segue
{
    self = [super init];
    
    if(self)
    {
        _sourceView = sourceView;
        _destinationView = destinationView;
        _segue = segue;
    }
    
    return self;
}

- (void) perform
{
    [self perform:nil];
}

- (void)perform:(void (^)(BOOL finished))completion
{
    if ([self isDimissing])
    {
       
        [self.segue destinationDismissAnimationForLayer:[_destinationView layer] completionBlock:nil];
        [self.segue sourceDismissAnimationForLayer:[_sourceView layer] completionBlock:^(BOOL finished) {
            completion(finished);
        }];
    }
    else
    {             
        [self.segue destinationStartAnimationForLayer:[_destinationView layer] completionBlock:^(BOOL finished) {
            completion(finished);            
        }];
        [self.segue sourceStartAnimationForLayer:[_sourceView layer] completionBlock:nil];
    }
}

#pragma mark - Segue
+ (void) presentViewControllerTransition:(UIViewController*)destination
                                  source:(UIViewController*)source
                                   segue:(UIStoryboardSegue *)segue
                              completion:(void (^)(BOOL finished))completion
{
    
    __block UIView * destinationView = [destination view];
    
    destinationView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    [[self topWindow]  addSubview:destinationView];
    
    SCTTransitionViewController * transition = [[SCTTransitionViewController alloc] initWithSourceView:[source view]
                                                                                             destinationView:[destination view]
                                                                                                       segue:segue];
    
        
    [transition perform:^(BOOL finished)
     {
         [destination setPresentedFromViewController:source];
        [destination setSegue:segue];
         [destinationView removeFromSuperview];
         destinationView = nil;
         [source presentViewController:destination animated:NO completion:^{
             if (completion)
                 completion(YES);
         }];
     }];
}


+ (void)dismissViewController:(UIViewController *)viewController
                   completion:(void (^)(BOOL finished))completion
{
    __block UIView * sourceView = [viewController.presentedFromViewController view];
    
    sourceView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [[self topWindow] addSubview:sourceView];
    
    SCTTransitionViewController * transition = [[SCTTransitionViewController alloc] initWithSourceView:sourceView
                                                                                             destinationView:[viewController view]
                                                                                                       segue:viewController.segue];
    
    [transition setDismissing:YES];
    
    [transition perform:^(BOOL finished)
    {
        if(finished)
        {
            [viewController setPresentedFromViewController:nil];
            
            [viewController setSegue:nil];
            
            [viewController dismissViewControllerAnimated:NO completion:^{
                if (completion)
                    completion(YES);
            }];
        }
    }];
}

@end

@implementation UIViewController(SCTTransitionViewController)

@dynamic presentedFromViewController, segue;

- (void)presentViewController:(UIViewController *)viewController
                    withSegue:(UIStoryboardSegue *)segue
                   completion:(void (^)(BOOL finished))completion
{
    [SCTTransitionViewController presentViewControllerTransition:viewController
                                                          source:self                                                        
                                                           segue:segue
                                                      completion:completion];
}

- (void)presentViewController:(UIViewController *)viewController
               withSegueClass:(Class)segueClass
                   completion:(void (^)(BOOL finished))completion
{
    UIStoryboardSegue* segue = [[segueClass alloc] init];
    
    NSAssert(segue!=nil, @"Unknown Segue");
    
    [SCTTransitionViewController presentViewControllerTransition:viewController
                                                          source:self
                                                           segue:segue
                                                      completion:completion];
}


-(void) dismissCustomSegueViewControllerWithCompletion:(void (^)(BOOL finished))completion
{
    [SCTTransitionViewController dismissViewController:self completion:completion];
}

- (void) dismissCustomSegueViewController
{
    [self dismissCustomSegueViewControllerWithCompletion:nil];
}

static char presentedFromViewControllerKey;
static char segueKey;

- (void) setSegue:(UIStoryboardSegue *)segue
{
    [self willChangeValueForKey:@"customSegue"];
    objc_setAssociatedObject( self,
                             &segueKey,
                             segue,
                             OBJC_ASSOCIATION_RETAIN );
    
    [self didChangeValueForKey:@"customSegue"];
}

- (UIStoryboardSegue*) segue {
    id controller = objc_getAssociatedObject( self,
                                             &segueKey);
    return controller;
}

- (void) setPresentedFromViewController:(UIViewController *)viewController
{
    [self willChangeValueForKey:@"presentedFromViewController"];
    objc_setAssociatedObject( self,
                             &presentedFromViewControllerKey,
                             viewController,
                             OBJC_ASSOCIATION_RETAIN );
    
    [self didChangeValueForKey:@"presentedFromViewController"];
}

- (UIViewController*) presentedFromViewController {
    id controller = objc_getAssociatedObject( self,
                                             &presentedFromViewControllerKey );
    return controller;
}


@end
