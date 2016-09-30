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

@implementation ANSFBLoginContext

#pragma mark -
#pragma mark Public Methods (reloaded)

- (void)execute {
    ANSFBUser *user = self.model;
    FBSDKLoginManager *manager = [FBSDKLoginManager new];
    [manager logInWithReadPermissions:@[kANSPublicProfile, kANSUserFriends, kANSEmail]
                   fromViewController:self.viewController
                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                  if (!error && !result.isCancelled) {
                                      [self fillUserID:user];
                                  } else {
                                      user.state = ANSUserDidFailLoading;
                                  }
                              }];
}

- (void)fillUserID:(ANSFBUser *)user {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    if (token) {
        user.ID = [token.userID integerValue];
        if (user.state != ANSUserDidLoadID) {
            user.state = ANSUserDidLoadID;
        } else {
            [user notifyOfStateChange:ANSUserDidLoadID];
        }
    }
}

@end
