//
//  SCTTransitionViewController.h
//  SegueCustomTransitions (Inspired by MHNatGeoViewControllerTransition https://github.com/michaelhenry/MHNatGeoViewControllerTransition)
//
//  Created by Daniel Tavares on 18/06/2013.
//  Copyright (c) 2013 Daniel Tavares. All rights reserved. (vibrazy@hotmail.com)
//

#import <Foundation/Foundation.h>
#import "UIStoryboardSegue+CustomTransitions.h"

@interface SCTTransitionViewController : NSObject

@property (assign, nonatomic, getter = isDimissing) BOOL dismissing;

@property (strong, nonatomic) UIView *sourceView;
@property (strong, nonatomic) UIView *destinationView;
@property (strong, nonatomic) UIStoryboardSegue *segue;
@property (assign, nonatomic) NSTimeInterval duration;


+ (void)dismissViewController:(UIViewController *)viewController
                   completion:(void (^)(BOOL finished))completion;

+ (void) presentViewControllerTransition:(UIViewController*)destination
                                  source:(UIViewController*)source                                
                                   segue:(UIStoryboardSegue *)segue
                              completion:(void (^)(BOOL finished))completion;

- (void)perform;
- (void)perform:(void (^)(BOOL finished))completion;

@end

#pragma mark - UIViewController(SCTTransitionViewController)
@interface UIViewController(SCTTransitionViewController)

@property(nonatomic,retain) UIViewController * presentedFromViewController;
@property(nonatomic,retain) UIStoryboardSegue * segue;

-(void) dismissCustomSegueViewControllerWithCompletion:(void (^)(BOOL finished))completion;
-(void) dismissCustomSegueViewController;


/*custom segue*/
- (void)presentViewController:(UIViewController *)viewController
                    withSegue:(UIStoryboardSegue *)segue
                   completion:(void (^)(BOOL finished))completion;

- (void)presentViewController:(UIViewController *)viewController
                    withSegueClass:(Class)segueClass
                   completion:(void (^)(BOOL finished))completion;

@end;
