//
//  ANSFBFriendsContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBFriendsContext.h"

#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSFBConstatns.h"

@interface ANSFBFriendsContext ()
- (NSArray *)friendsFromResult:(NSDictionary *)result;

@end

@implementation ANSFBFriendsContext

#pragma mark -
#pragma mark Reloaded Methods

- (NSString *)graphPathInit {
    ANSFBUser *user = self.user;
    return [NSString stringWithFormat:@"%lu/%@", (long)user.ID, kANSFriends];
}

- (NSString *)HTTPMethodInit {
    return kANSGet;
}

- (NSDictionary *)parametresInit {
    return @{kANSFields:[NSString stringWithFormat:@"%@, %@, %@, %@", kANSID,
                                                                      kANSFirstName,
                                                                      kANSLastName,
                                                                      kANSLargePicture]};
}

- (void)fillModelFromResult:(NSDictionary *)result {
    ANSFBFriends *friends = self.model;
    if (friends.state == ANSLoadableModelDidLoad) {
        return;
    }
    
    [friends performBlockWithoutNotification:^{
        NSArray *frinds = [self friendsFromResult:result];
        [friends addObjectsInRange:frinds];
    }];
    
    friends.state = ANSLoadableModelDidLoad;
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)friendsFromResult:(NSDictionary *)result {
    NSMutableArray *mutableUsers = [NSMutableArray new];
    
    NSArray *dataUsers = result[kANSData];
    for (id dataUser in dataUsers) {
        ANSFBUser *user = [ANSFBUser new];
        user.ID = (NSUInteger)dataUser[kANSID];
        user.firstName = dataUser[kANSFirstName];
        user.lastName = dataUser[kANSLastName];
        
        NSDictionary * dataPicture = dataUser[kANSPicture][kANSData];
        NSString *URLString = dataPicture[kANSURL];
        user.imageUrl = [NSURL URLWithString:URLString];
        [mutableUsers addObject:user];
    }
    
    return [mutableUsers copy];
}

@end
