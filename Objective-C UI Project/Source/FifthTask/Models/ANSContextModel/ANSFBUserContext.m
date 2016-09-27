//
//  ANSContextModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//


#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "ANSFBUserContext.h"

#import "ANSFBUser.h"
#import "ANSGCD.h"

#import "ANSMacros.h"

@interface ANSFBUserContext ()
@property (nonatomic, strong) id                           model;

@property (nonatomic, strong) FBSDKGraphRequestConnection *requestConnection;
@property (nonatomic, strong) FBSDKGraphRequest           *request;

- (void)initRequest;
- (void)executeRequest;

@end

@implementation ANSFBUserContext

- (void)dealloc {
    [self cancel];
}

- (instancetype)initWithModel:(id)model; {
    self = [super init];
    self.model = model;
    
    return self;
}

#pragma mark -
#pragma mark Public methods

- (NSString *)graphPath {
    return nil;
}

- (NSDictionary *)parametres {
    return nil;
}

- (NSString *)HTTPMethod {
    return nil;
}

- (void)fillModelFromResult:(NSDictionary *)result {
    return;
}

- (void)notifyIfLoadingFailed {
    return;
}

- (void)notifyIfLoaded {
    return;
}

#pragma mark -
#pragma mark Ptivate methods

- (void)initRequest {
    self.request = [[FBSDKGraphRequest alloc] initWithGraphPath:[self graphPath]
                                                     parameters:[self parametres]
                                                     HTTPMethod:[self HTTPMethod]];
}

- (void)executeRequest {
    self.requestConnection = [self.request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                                   NSDictionary *result,
                                                                   NSError *error) {
        if (error) {
            NSLog(@"[ERROR] %@", error);
            [self notifyIfLoadingFailed];
            
            return;
        }
        
        [self fillModelFromResult:result];
    }];
}

#pragma mark -
#pragma mark Public methods

- (void)execute {
    @synchronized (self) {
        [self notifyIfLoaded];
        [self initRequest];
        [self executeRequest];
    }
}

- (void)cancel {
    @synchronized (self) {
        [self.requestConnection cancel];
    }
}

@end
