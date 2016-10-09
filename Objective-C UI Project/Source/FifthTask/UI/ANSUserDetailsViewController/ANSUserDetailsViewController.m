//
//  ANSUserDetailsViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUserDetailsViewController.h"

#import "ANSFriendListViewController.h"
#import "ANSUserDetailsView.h"
#import "ANSUserDetailsContext.h"
#import "ANSProtocolObservationController.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSUserDetailsViewController, ANSUserDetailsView, detailsView);

@interface ANSUserDetailsViewController ()
@property (nonatomic, strong) ANSUserDetailsContext *detailsContext;
@property (nonatomic, strong) ANSProtocolObservationController *userController;

- (void)initRightBarButton;
- (void)rightBarButtonAction:(UIBarButtonItem *)sender;

@end

@implementation ANSUserDetailsViewController

#pragma mark -
#pragma Initialization and deallocation

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initRightBarButton];
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self initRightBarButton];
    
    return self;
}

#pragma mark -
#pragma mark View lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.detailsView fillBasicInfoFromUser:self.user];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Accsessors

- (void)setUser:(ANSUser *)user {
    if (_user != user) {
        _user = user;
        
        self.userController = [user protocolControllerWithObserver:self];
        
        ANSUserDetailsContext *context = nil;
        context = [[ANSUserDetailsContext alloc] initWithModel:user];
        self.detailsContext = context;
        [context execute];
    }
}

#pragma mark -
#pragma mark - BarButton items

- (void)initRightBarButton {
    UIBarButtonItem * rightButton = nil;
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Friends" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)rightBarButtonAction:(UIBarButtonItem *)sender {
    ANSFriendListViewController *controller = [ANSFriendListViewController new];
    controller.user = self.user;
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark -
#pragma mark ANSUserStateObserver protocol

- (void)userDidLoadDetails:(ANSUser *)user {
    [self.detailsView fillFullInfoFromUser:user];
    self.detailsView.loadingViewVisible = NO;
}

@end
