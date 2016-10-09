//
//  ANSFBFriends.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSFBFriends.h"

#import "ANSNameFilterModel.h"
#import "ANSUser.h"

#import "NSArray+ANSExtension.h"
#import "NSFileManager+ANSExtension.h"
#import "ANSGCD.h"

#import "ANSMacros.h"

static NSString * const kANSPlistName = @"aaa";

@interface ANSFBFriends ()
@property (nonatomic, strong) NSMutableDictionary *observationHandlers;

- (SEL)selectorForState:(NSUInteger)state;

@end

@implementation ANSFBFriends

#pragma mark -
#pragma mark Private methods (reloaded)

- (SEL)selectorForState:(NSUInteger)state {
    return [super selectorForState:state];
}

#pragma mark -
#pragma mark Private Methods


#pragma mark -
#pragma mark Private Methods (reloaded)

//- (void)performLoading {
//    id users = [self loadUsersModel];
//    self.state = users ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
//}

@end
