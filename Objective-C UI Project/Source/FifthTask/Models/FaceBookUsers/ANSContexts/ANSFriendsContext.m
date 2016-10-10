//
//  ANSFBFriendsContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFriendsContext.h"

#import "ANSUser.h"
#import "ANSFBConstatns.h"

#import "NSDictionary+ANSJSONRepresentation.h"
#import "NSFileManager+ANSExtension.h"
#import "NSManagedObject+ANSExtension.h"

#import "ANSGCD.h"

@interface ANSFriendsContext ()
- (ANSUser *)userFromResult:(NSDictionary *)result;
- (NSSet *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result;

@end

@implementation ANSFriendsContext

#pragma mark -
#pragma mark Private Methods (reloaded)

- (NSString *)graphPath {
    return [NSString stringWithFormat:@"%lld/%@",self.model.idNumber, kANSFriends];
}

- (NSString *)HTTPMethod {
    return kANSGet;
}

- (NSDictionary *)parametres {
    return @{kANSFields:[NSString stringWithFormat:@"%@, %@, %@, %@", kANSID,
                                                                      kANSFirstName,
                                                                      kANSLastName,
                                                                      kANSLargePicture]};
}

- (BOOL)isModelLoadedWithState:(NSUInteger)state {
    ANSUser *user = self.model;
    NSLog(@"user state = %lu", (unsigned long)user.state);
    if (user.state == state) {
    //HAVE TO BE Changed
//        [user notifyOfStateChange:state];
//
//        return YES;
    }
    
    return NO;
}

- (BOOL)isModelLoaded {
    return [self isModelLoadedWithState:ANSUserDidLoadID];
}

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result {
    ANSUser *user = self.model;
    [user addFriends:[self friendsFromResult:result]];
    
    user.state = ANSUserDidLoadFriends;
    
    NSLog(@"%lu", user.friends.count);
}

#pragma mark -
#pragma mark Private methods

- (ANSUser *)userFromResult:(NSDictionary *)result {
    NSUInteger ID = (NSUInteger)[result[kANSID] integerValue];
    ANSUser *user = [ANSUser objectWithID:ID];
    user.firstName = result[kANSFirstName];
    user.lastName = result[kANSLastName];
    
    NSDictionary * dataPicture = result[kANSPicture][kANSData] ;
    user.imageURL = dataPicture[kANSURL];
    
    [user save];
    
    return user;
}

- (NSSet *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result {
    NSMutableSet *mutableUsers = [NSMutableSet new];
    NSDictionary *parsedResult = [result JSONRepresentation];
    
    NSArray *dataUsers = parsedResult[kANSData];
    for (NSDictionary *dataUser in dataUsers) {
        ANSUser *user = [self userFromResult:dataUser];
        [user save];
        
        [mutableUsers addObject:user];
    }
    
    return [mutableUsers copy];
}

@end
