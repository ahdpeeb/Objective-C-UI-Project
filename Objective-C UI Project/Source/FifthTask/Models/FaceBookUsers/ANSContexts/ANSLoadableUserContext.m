//
//  ANSUserLoadContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "ANSLoadableUserContext.h"

#import "ANSFaceBookUser.h"

@interface ANSLoadableUserContext ()
@property (nonatomic, strong) FBSDKGraphRequestConnection *requestConnection;

- (void)fillUserFromResult:(NSDictionary *)result;

@end

@implementation ANSLoadableUserContext

#pragma mark -
#pragma mark Private Methods;

- (void)performProcessing {
    ANSFaceBookUser *user = self.model;
    NSString *graphPath = [NSString stringWithFormat:@"/{user-%lu}", user.ID];

    FBSDKGraphRequest *request = nil;
    request = [[FBSDKGraphRequest alloc]
               initWithGraphPath:graphPath
               parameters:@{@"fields": @"first_name, last_name, picture.type(large)"}
               HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              NSDictionary *result,
                                              NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            self.state = ANSContextDidFailedExecution;
            return;
        }
        
        [self fillUserFromResult:result];
        self.state = ANSContextDidFinishExecution;
    }];
}

- (void)fillUserFromResult:(NSDictionary *)result {
    ANSFaceBookUser *user = self.model;
    user.firsName = [result objectForKey:@"first_name"];
    user.lastName = [result objectForKey:@"last_name"];
    
    NSDictionary * dataPicture = [[result objectForKey:@"picture"] objectForKey:@"data"];
    NSString *URLString = [dataPicture objectForKey:@"url"];
    user.imageUrl = [NSURL URLWithString:URLString];
    
    NSLog(@"user id = %lu, fullName - %@ %@, picture - %@",user.ID,
          user.firsName,
          user.lastName,
          user.imageUrl);
}

@end
