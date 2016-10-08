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
#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSFriendListViewController.h"
#import "ANSFBLoginContext.h"
#import "ANSProtocolObservationController.h"
#import "ANSFBConstatns.h"
#import "ANSLoginInterection.h"
#import "ANSUser.h"

#import "UIViewController+ANSExtension.h"
#import "NSManagedObject+ANSExtension.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) ANSFBLoginContext                     *loginContext;

@property (nonatomic, strong) ANSFBUser                             *user;
@property (nonatomic, strong) ANSProtocolObservationController      *userContoller;

@property (nonatomic, strong) ANSUser                               *testUser;
@property (nonatomic, strong) ANSProtocolObservationController      *testUserContoller;

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

- (void)setUser:(ANSFBUser *)user {
    if (_user != user) {
        _user = user;

        self.userContoller = [user protocolControllerWithObserver:self];
    }
}

- (void)setTestUser:(ANSUser *)testUser {
    if (_testUser != testUser) {
        _testUser = testUser;
        
        self.testUserContoller = [testUser protocolControllerWithObserver:self];
    }
}


#pragma mark -
#pragma mark Private metods

- (void)autoLogin {
    self.user = [ANSFBUser new];
    ANSLoginInterection *interection = [ANSLoginInterection interectionWithUser:self.user];
    [interection execute];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    self.user = [ANSFBUser new];
    self.loginContext = [[ANSFBLoginContext alloc] initWithModel:self.user controller:self];
    [self.loginContext execute];
}

- (IBAction)onCoreDataTest:(UIButton *)sender {
    for (NSUInteger index = 0; index < 100; index ++) {
        ANSUser *user = [ANSUser object];
        self.testUser = user;
        [user fillWithRandom];
        user.state = ANSUserDidLoadID;
        user.state = ANSUserDidLoadID;
        user.state = ANSUserDidLoadBasic;
        user.state = ANSUserDidLoadDetails;
    }
}

#pragma mark -
#pragma mark ANSUserStateObserver ptotocol 

//- (void)userDidLoadID:(ANSFBUser *)user {
//    ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
//    controller.user = user;
//    [self.navigationController pushViewController:controller animated:YES];
//}

- (void)userDidLoadID:(ANSUser *)user {
    NSLog(@"userDidLoadID");
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
