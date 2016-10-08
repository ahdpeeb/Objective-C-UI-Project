//
//  ANSFBLoginContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSFBLoginContext.h"

#import "ANSFBUser.h"
#import "ANSFBConstatns.h"
#import "ANSJSONRepresentation.h"
#import "ANSLoginViewController.h"
#import "ANSLoginInterection.h"

@interface ANSFBLoginContext ()
@property (nonatomic, weak) ANSLoginViewController *viewController;

@end

@implementation ANSFBLoginContext

- (instancetype)initWithModel:(id)model controller:(ANSLoginViewController *)controller {
    self = [super initWithModel:model];
    self.viewController = controller;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods (reloaded)

- (void)execute {
    ANSFBUser *user = self.model;
    ANSLoginInterection *interection = [ANSLoginInterection interectionWithUser:user];
    FBSDKLoginManager *manager = [FBSDKLoginManager new];
    [manager logInWithReadPermissions:@[kANSPublicProfile, kANSUserFriends, kANSEmail]
                   fromViewController:self.viewController
                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                  if (!error && !result.isCancelled) {
                                      [interection execute];
                                  } else {
                                      user.state = ANSFBUserDidFailLoading;
                                  }
                              }];
}

@end
