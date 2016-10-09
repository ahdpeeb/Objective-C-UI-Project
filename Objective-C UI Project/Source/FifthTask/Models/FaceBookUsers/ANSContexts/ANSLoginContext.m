//
//  ANSFBLoginContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSLoginContext.h"

#import "ANSUser.h"
#import "ANSFBConstatns.h"
#import "ANSJSONRepresentation.h"
#import "ANSLoginViewController.h"
#import "ANSLoginInterection.h"

@interface ANSLoginContext ()
@property (nonatomic, weak) ANSLoginViewController *viewController;

@end

@implementation ANSLoginContext

- (instancetype)initWithModel:(id)model controller:(ANSLoginViewController *)controller {
    self = [super initWithModel:model];
    self.viewController = controller;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods (reloaded)

- (void)execute {
    ANSUser *user = self.model;
    ANSLoginInterection *interection = [ANSLoginInterection interectionWithUser:user];
    FBSDKLoginManager *manager = [FBSDKLoginManager new];
    [manager logInWithReadPermissions:@[kANSPublicProfile, kANSUserFriends]
                   fromViewController:self.viewController
                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                  if (!error && !result.isCancelled) {
                                      [interection execute];
                                  } else {
                                      user.state = ANSUserDidFailLoading;
                                  }
                              }];
}

@end
