//
//  ANSContextModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "ANSFBContext.h"

#import "ANSUser.h"
#import "ANSGCD.h"

#import "ANSMacros.h"

@interface ANSFBContext ()
@property (nonatomic, strong) id                          model;
@property (nonatomic, strong) FBSDKGraphRequestConnection *requestConnection;

- (void)executeRequest;

@end

@implementation ANSFBContext

- (void)dealloc {
    self.requestConnection = nil;
}

- (instancetype)initWithModel:(id)model; {
    self = [super init];
    self.model = model;
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setRequestConnection:(FBSDKGraphRequestConnection *)requestConnections {
    if (_requestConnection != requestConnections) {
        
        [_requestConnection cancel];
        _requestConnection = requestConnections;
    }
}

#pragma mark -
#pragma mark Ptivate methods

- (NSString *)graphPath {
    return nil;
}

- (NSDictionary *)parametres {
    return nil;
}

- (NSString *)HTTPMethod {
    return nil;
}

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result; {
    return;
}

- (void)loadFromCache {
    return;
}

- (BOOL)isModelLoaded {
    [self doesNotRecognizeSelector:_cmd];
    
    return NO;
}

- (void)executeRequest {
    if ([self isModelLoaded]) {
        return;
    }
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:[self graphPath]
                                                                   parameters:[self parametres]
                                                                   HTTPMethod:[self HTTPMethod]];
    
    self.requestConnection = [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                                        NSDictionary <ANSJSONRepresentation>  *result,
                                                                        NSError *error) {
        if (error) {
            NSLog(@"[ERROR] %@", error);
            [self loadFromCache];
            
            return;
        }
        
        [self fillModelFromResult:result];
    }];
}

#pragma mark -
#pragma mark Public methods

- (void)execute {
    [self executeRequest];
}

- (void)cancel {
    [self.requestConnection cancel];
}

@end
