//
//  ANSViewControllerFirstTask.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSViewControllerFirstTask.h"

#import "ANSRootView.h"
#import "ANSAnimationView.h"

@interface ANSViewControllerFirstTask ()

@end

@implementation ANSViewControllerFirstTask

@dynamic rootView;

#pragma mark -
#pragma mark Accsessors

- (ANSRootView *)rootView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[ANSRootView class]]) {
        return (ANSRootView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Buttons

- (IBAction)onAnimation:(UISwitch *)sender {
    ANSAnimationView *view = self.rootView.animationView;
    view.animating = sender.on;
}

@end
