//
//  ANSContextModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//


#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "ANSFBUserContext.h"

#import "ANSFacebookUser.h"
#import "ANSGCD.h"

#import "ANSMacros.h"

@interface ANSFBUserContext ()
@property (nonatomic, strong) id                           model;
@property (nonatomic, strong) FBSDKGraphRequestConnection *requestConnection;

@end

@implementation ANSFBUserContext

- (instancetype)initWithModel:(id)model; {
    self = [super init];
    self.model = model;
    
    return self;
}

#pragma mark -
#pragma mark Public methods
- (NSString *)graphPathInit {
    return nil;
}

- (NSDictionary *)parametresInit {
    return nil;
}

- (NSString *)HTTPMethodInit {
    return nil;
}

- (void)fillModelFromResult:(NSDictionary *)result {
    
}

#pragma mark -
#pragma mark Public methods

- (void)execute {
    @synchronized (self) {
        FBSDKGraphRequest *request = nil;
        request = [[FBSDKGraphRequest alloc]
                   initWithGraphPath:[self graphPathInit]
                   parameters:[self parametresInit]
                   HTTPMethod:[self HTTPMethodInit]];
        
        self.requestConnection = [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                                       NSDictionary *result,
                                                                       NSError *error) {
            if (error) {
                NSLog(@"[ERROR] %@", error);
                return;
            }
            
            [self fillModelFromResult:result];
        }];
    }
}

- (void)cancel {
    @synchronized (self) {
        [self.requestConnection cancel];
    }
}

@end
