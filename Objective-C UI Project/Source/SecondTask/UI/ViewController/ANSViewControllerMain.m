//
//  ANSViewControllerMain.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSViewControllerMain.h"

@interface ANSViewControllerMain ()

@end

@implementation ANSViewControllerMain

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
    
}

- (void)didReceiveMemoryWarning {
    
}

@end
