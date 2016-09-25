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

@interface ANSFBFriendsContext ()
- (NSArray *)friendsFromResult:(NSDictionary *)result;

@end

@implementation ANSFBFriendsContext

#pragma mark -
#pragma mark Reloaded Methods

- (NSString *)graphPathInit {
    ANSFBUser *user = self.user;
    return [NSString stringWithFormat:@"%lu/friends", (long)user.ID];
}

- (NSString *)HTTPMethodInit {
    return @"GET";
}

- (NSDictionary *)parametresInit {
    return @{@"fields":@"id, first_name, last_name, picture.type(large)"};
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
    
    NSArray *dataUsers = result[@"data"];
    for (id dataUser in dataUsers) {
        ANSFBUser *user = [ANSFBUser new];
        user.ID = (NSUInteger)dataUser[@"id"];
        user.firstName = dataUser[@"first_name"];
        user.lastName = dataUser[@"last_name"];
        
        NSDictionary * dataPicture = dataUser[@"picture"][@"data"];
        NSString *URLString = dataPicture[@"url"];
        user.imageUrl = [NSURL URLWithString:URLString];
        [mutableUsers addObject:user];
    }
    
    return [mutableUsers copy];
}

@end
