//
//  ANSViewControllerFirstTask.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSViewControllerFirstTask.h"

#include "ANSLableView.h"

@interface ANSViewControllerFirstTask ()
@property (nonatomic, readonly) ANSLableView *lableView;

@end

@implementation ANSViewControllerFirstTask

#pragma mark -
#pragma mark Initializations and dealocations



#pragma mark -
#pragma mark Accsessors

- (ANSLableView *)lableView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[ANSLableView class]]) {
        return (ANSLableView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lableView.lable.text = @"blia";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
