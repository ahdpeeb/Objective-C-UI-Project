//
//  ANSViewControllerFirstTask.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSViewControllerFirstTask.h"

@interface ANSViewControllerFirstTask ()

@end

@implementation ANSViewControllerFirstTask

@dynamic mainView;

#pragma mark -
#pragma mark Accsessors

- (ANSMainView *)mainView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[ANSMainView class]]) {
        return (ANSMainView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ANSAnimatedView *view = self.mainView.view;
    [view initDancer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Buttons 

- (IBAction)onTransition:(id)sender {
    ANSAnimatedView *view = self.mainView.view;
    [self.mainView bringSubviewToFront:view];
    [view startAnimation];
}

- (IBAction)offTransition:(id)sender {
    ANSAnimatedView *view = self.mainView.view;
    [view stopAnimation];
}

@end
