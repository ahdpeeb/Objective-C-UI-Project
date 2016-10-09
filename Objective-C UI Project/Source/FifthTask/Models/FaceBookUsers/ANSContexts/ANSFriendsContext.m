//
//  ANSFBFriendsContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFriendsContext.h"

#import "ANSUser.h"
#import "ANSFBFriends.h"
#import "ANSFBConstatns.h"

#import "NSDictionary+ANSJSONRepresentation.h"
#import "NSFileManager+ANSExtension.h"
#import "NSManagedObject+ANSExtension.h"

static NSString * const kANSPlistName = @"aaa";

@interface ANSFriendsContext ()
- (ANSUser *)userFromResult:(NSDictionary *)result;
- (NSArray *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result;

@end

@implementation ANSFriendsContext

#pragma mark -
#pragma mark Private Methods (reloaded)

- (NSString *)graphPath {
    return [NSString stringWithFormat:@"%lld/%@",self.user.idNumber, kANSFriends];
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
    ANSObservableObject *model = self.model;
    if (model.state == ANSLoadableModelDidLoad) {
        [model notifyOfStateChange:ANSLoadableModelDidLoad];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isModelLoaded {
    return [self isModelLoadedWithState:ANSLoadableModelDidLoad];
}

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result; {
    ANSFBFriends *fbFriends = self.model;
    [fbFriends performBlockWithoutNotification:^{
        NSArray *friends = [self friendsFromResult:result];
        [fbFriends addObjectsInRange:friends];
    }];
    
    [self saveFriends];
    fbFriends.state = ANSLoadableModelDidLoad;
}

- (void)loadFromCache {
    ANSFBFriends *friends = self.model;
    NSArray *users = [self usersFromFileSystem];
    [friends performBlockWithoutNotification:^{
        [friends addObjectsInRange:users];
    }];
    
    friends.state = users ?  ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
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
    
    user.state = ANSUserDidLoadBasic;
    
    return user;
}

- (NSArray *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result {
    NSMutableArray *mutableUsers = [NSMutableArray new];
    NSDictionary *parsedResult = [result JSONRepresentation];
    
    NSArray *dataUsers = parsedResult[kANSData];
    for (NSDictionary *dataUser in dataUsers) {
        ANSUser *user = [self userFromResult:dataUser];
        [user save];
        
        [mutableUsers addObject:user];
    }
    
    return [mutableUsers copy];
}

- (void)saveFriends {
    ANSFBFriends *friends = self.model;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistWithName:@(self.user.idNumber).stringValue inSearchPathDirectory:NSDocumentDirectory];
    BOOL isSuccessfully = [NSKeyedArchiver archiveRootObject:friends.objects toFile:plistPath];
    NSLog(@"%@", (isSuccessfully) ? @"saved successfully" : @"save failed");
}

- (id)usersFromFileSystem  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:@(self.user.idNumber).stringValue
                                 inSearchPathDirectory:NSDocumentDirectory];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
}

@end
