//
//  SCTViewController.m
//  SegueCustomTransitions (Inspired by MHNatGeoViewControllerTransition https://github.com/michaelhenry/MHNatGeoViewControllerTransition)
//
//  Created by Daniel Tavares on 18/06/2013.
//  Copyright (c) 2013 Daniel Tavares. All rights reserved. (vibrazy@hotmail.com)
//

#import "SCTViewController.h"

@interface SCTViewController ()

@end

@implementation SCTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(UIButton *)sender
{
    [self dismissCustomSegueViewControllerWithCompletion:^(BOOL finished) {
        NSLog(@"Dismiss complete!");
    }];
}

- (IBAction)actionCustomPresentViewControllerExample2:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    SCTViewController *controller = [story instantiateViewControllerWithIdentifier:@"SCTViewControllerKey"];
    
    NSLog(@"About to Present : %@", controller);
    
    [self presentViewController:controller withSegue:[[SCT3DFlip alloc] init] completion:^(BOOL finished) {
        NSLog(@"Finishes");
    }];
}

- (IBAction)actionCustomPresentViewController:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    SCTViewController *controller = [story instantiateViewControllerWithIdentifier:@"SCTViewControllerKey"];
    
    NSLog(@"About to Present : %@", controller);
    
    [self presentViewController:controller withSegueClass:[SCT3DFlip class] completion:^(BOOL finished) {
        NSLog(@"Finished");
    }];
}

@end
