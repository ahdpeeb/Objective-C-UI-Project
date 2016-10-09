//
//  ANSLoginViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreData/CoreData.h>

#import "ANSLoginViewController.h"

#import "ANSLoginView.h"
#import "ANSUser.h"
#import "ANSFriendListViewController.h"
#import "ANSLoginContext.h"
#import "ANSProtocolObservationController.h"
#import "ANSFBConstatns.h"
#import "ANSLoginInterection.h"

#import "UIViewController+ANSExtension.h"
#import "NSManagedObject+ANSExtension.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) ANSLoginContext                     *loginContext;

@property (nonatomic, strong) ANSUser                               *user;
@property (nonatomic, strong) ANSProtocolObservationController      *userController;

- (void)autoLogin;

@end

@implementation ANSLoginViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self autoLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUser:(ANSUser *)user {
    if (_user != user) {
        _user = user;
        
        self.userController = [user protocolControllerWithObserver:self];
    }
}

#pragma mark -
#pragma mark Private metods

- (void)autoLogin {
    self.user = [ANSUser object];
    ANSLoginInterection *interection = [ANSLoginInterection interectionWithUser:self.user];
    [interection execute];
    [self userDidLoadID:self.user];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    self.user = [ANSUser object];
    self.loginContext = [[ANSLoginContext alloc] initWithModel:self.user controller:self];
    [self.loginContext execute];
}

#pragma mark -
#pragma mark ANSUserObserver ptotocol

- (void)userDidLoadID:(ANSUser *)user {    
    ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
    controller.user = user;
    ANSPerformInMainQueue(dispatch_async, ^{
        [self.navigationController pushViewController:controller animated:YES];
    }); 
}

@end
