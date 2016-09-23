//
//  ANSUserLoadContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKMacros.h>

#import "ANSLoadableUserContext.h"


@interface ANSLoadableUserContext ()
@property (nonatomic, strong) FBSDKGraphRequestConnection *requestConnection;

@end

@implementation ANSLoadableUserContext

- (void)execute {
    FBSDKGraphRequest *request = nil;
    request = [[FBSDKGraphRequest alloc]
               initWithGraphPath:@"me/friends"
               parameters:@{@"fields": @"id, first_name, last_name, picture.type(large)"}
               HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          NSDictionary *result,
                                          NSError *error) {
    }];
}

@end
