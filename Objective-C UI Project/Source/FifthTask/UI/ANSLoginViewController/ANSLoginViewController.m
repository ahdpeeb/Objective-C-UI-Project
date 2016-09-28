//
//  ANSLoginViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSLoginViewController.h"

#import "ANSLoginView.h"
#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSFriendListViewController.h"
#import "ANSFBLoginContext.h"
#import "ANSProtocolObservationController.h"
#import "ANSFBConstatns.h"

#import "UIViewController+ANSExtension.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) FBSDKLoginManager                     *loginManager;
@property (nonatomic, strong) ANSFBLoginContext                     *loginContext;

@property (nonatomic, strong) ANSFBUser                             *user;
@property (nonatomic, strong) ANSProtocolObservationController      *contoller;

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
        
        self.contoller = [user protocolControllerWithObserver:self];
    }
}

#pragma mark -
#pragma mark Private metods

- (void)loadUser {
    ANSFBUser *user = [ANSFBUser new];
    self.user = user;
    self.loginContext =  [[ANSFBLoginContext alloc] initWithModel:user];
    [self.loginContext execute];
}

- (void)autoLogin {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    if (token) {
        ANSFBUser *user = [ANSFBUser new];
        self.user = user;
        user.ID = token.userID.doubleValue;
        [self userDidLoadID:user];
    }
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    FBSDKLoginManager *manager = [FBSDKLoginManager new];
    self.loginManager = manager;
    [manager logInWithReadPermissions:@[kANSPublicProfile, kANSUserFriends, kANSEmail]
                   fromViewController:self
                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                  BOOL value = result.isCancelled;
                                  if (!error && !value) {
                                      NSLog(@"Loggined");
                                      [self loadUser];
                                  }
                              }];
}

#pragma mark -
#pragma mark ANSUserStateObserver ptotocol 

- (void)userDidLoadID:(ANSFBUser *)user {
    ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
