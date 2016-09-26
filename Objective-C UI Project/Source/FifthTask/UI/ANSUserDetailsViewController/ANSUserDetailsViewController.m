//
//  ANSUserDetailsViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUserDetailsViewController.h"

#import "ANSUserDetailsView.h"
#import "ANSFBUserDetailsContext.h"
#import "ANSProtocolObservationController.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSUserDetailsViewController, ANSUserDetailsView, detailsView);

@interface ANSUserDetailsViewController ()
@property (nonatomic, strong) ANSFBUserDetailsContext *detailsContext;
@property (nonatomic, strong) ANSProtocolObservationController *userController;

@end

@implementation ANSUserDetailsViewController

#pragma mark -
#pragma mark view lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.detailsView fillBasicInfoFromUser:self.user];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark view lifeCycle

- (void)setUser:(ANSFBUser *)user {
    if (_user != user) {
        _user = user;
        
        self.userController = [user protocolControllerWithObserver:self];
        
        ANSFBUserDetailsContext *context = nil;
        context = [[ANSFBUserDetailsContext alloc] initWithModel:user];
        self.detailsContext = context;
        [context execute];
    }
}
 
#pragma mark -
#pragma mark ANSUserStateObserver protocol

- (void)userDidLoadDetails:(ANSFBUser *)user {
    [self.detailsView fillFullInfoFromUser:user];
    self.detailsView.loadingViewVisible = NO;
}

@end
