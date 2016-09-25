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
#import "ANSFacebookUser.h"
#import "ANSFaceBookFriends.h"
#import "ANSFriendListViewController.h"
#import "ANSFBLoginContext.h"
#import "ANSProtocolObservationController.h"

#import "UIViewController+ANSExtension.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) ANSFBLoginContext                *loginContext;

@property (nonatomic, strong) ANSFacebookUser                  *user;
@property (nonatomic, strong) ANSProtocolObservationController *contoller;

@end

@implementation ANSLoginViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUser:(ANSFacebookUser *)user {
    if (_user != user) {
        _user = user;
        
        self.contoller = [user protocolControllerWithObserver:self];
    }
}

#pragma mark -
#pragma mark Private metods
- (void)loadUser {
    ANSFacebookUser *user = [ANSFacebookUser new];
    self.user = user;
    ANSFBLoginContext *context = [[ANSFBLoginContext alloc] initWithModel:user];
    
    [context execute];
}


#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    [[FBSDKLoginManager new] logInWithReadPermissions:@[@"public_profile", @"user_friends"]
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

- (void)userDidLoadID:(ANSFacebookUser *)user {
    ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
