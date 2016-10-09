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
#import "ANSFBFriends.h"
#import "ANSFriendListViewController.h"
#import "ANSLoginContext.h"
#import "ANSProtocolObservationController.h"
#import "ANSFBConstatns.h"
#import "ANSLoginInterection.h"

#import "UIViewController+ANSExtension.h"
#import "NSManagedObject+ANSExtension.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) ANSLoginContext                     *loginContext;

@property (nonatomic, strong) ANSUser                               *user;
@property (nonatomic, strong) ANSProtocolObservationController      *userContoller;

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
        
        self.userContoller = [user protocolControllerWithObserver:self];
    }
}

#pragma mark -
#pragma mark Private metods

- (void)autoLogin {
    self.user = [ANSUser object];
    ANSLoginInterection *interection = [ANSLoginInterection interectionWithUser:self.user];
    [interection execute];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    self.user = [ANSUser object];
    self.loginContext = [[ANSLoginContext alloc] initWithModel:self.user controller:self];
    [self.loginContext execute];
}

//test Button
- (IBAction)onCoreDataTest:(UIButton *)sender {
    for (NSUInteger index = 0; index < 100; index ++) {
        ANSUser *user = [ANSUser object];
        self.user = user;
        [user fillWithRandom];
    }
}

#pragma mark -
#pragma mark ANSUserObserver ptotocol

- (void)userDidLoadID:(ANSUser *)user {
    ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)userDidLoadBasic:(ANSUser *)user {
     NSLog(@"userDidLoadBasic");
}
- (void)userDidLoadDetails:(ANSUser *)user {
     NSLog(@"userDidLoadDetails");
}
- (void)userDidFailLoading:(ANSUser *)user {
     NSLog(@"userDidFailLoading");
}

@end
