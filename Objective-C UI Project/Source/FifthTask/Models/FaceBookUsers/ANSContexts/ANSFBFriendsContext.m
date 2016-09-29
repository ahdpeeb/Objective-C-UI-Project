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
#import "ANSJsonParser.h"

#import "NSFileManager+ANSExtension.h"

static NSString * const kANSPlistName = @"aaa";

@interface ANSFBFriendsContext ()

- (NSArray *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result;

@end

@implementation ANSFBFriendsContext

#pragma mark -
#pragma mark Private Methods (reloaded)

- (NSString *)graphPath {
    ANSFBUser *user = self.user;
    return [NSString stringWithFormat:@"%lu/%@", (long)user.ID, kANSFriends];
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

- (void)notifyIfLoadingFailed {
    ANSFBFriends *friends = self.model;
    //loading Users FromFileSystem if fail loading from internet
    NSArray *users = [self usersFromFileSystem];
    [friends performBlockWithoutNotification:^{
        [friends addObjectsInRange:users];
    }];
    
    friends.state = users ?  ANSLoadableModelDidFailLoading : ANSLoadableModelDidFailLoading;
}

- (BOOL)notifyIfLoaded {
    ANSFBFriends *friends = self.model;
    if (friends.state == ANSLoadableModelDidLoad) {
        [friends notifyOfStateChange:ANSLoadableModelDidLoad];
        
        return YES;
    }
    
    return NO;
}

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result; {
    ANSFBFriends *friends = self.model;
    [friends performBlockWithoutNotification:^{
        NSArray *frinds = [self friendsFromResult:result];
        [friends addObjectsInRange:frinds];
    }];
    
    [self saveFriends];
    friends.state = ANSLoadableModelDidLoad;
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result {
    NSMutableArray *mutableUsers = [NSMutableArray new];
    NSDictionary *parsedResult = [result JSONRepresentation];
    
    NSArray *dataUsers = parsedResult[kANSData];
    for (NSDictionary *dataUser in dataUsers) {
        ANSFBUser *fbUser = [ANSFBUser new];
        fbUser.ID = ((NSString *)dataUser[kANSID]).doubleValue;
        fbUser.firstName = dataUser[kANSFirstName];
        fbUser.lastName = dataUser[kANSLastName];
        
        NSDictionary * dataPicture = dataUser[kANSPicture][kANSData] ;
        NSString *URLString = dataPicture[kANSURL];
        fbUser.imageUrl = [NSURL URLWithString:URLString];
        [mutableUsers addObject:fbUser];
    }
    
    return [mutableUsers copy];
}

- (void)saveFriends {
    ANSFBFriends *friends = self.model;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistWithName:@(self.user.ID).stringValue inSearchPathDirectory:NSDocumentDirectory];
    BOOL isSuccessfully = [NSKeyedArchiver archiveRootObject:friends.objects toFile:plistPath];
    NSLog(@"%@", (isSuccessfully) ? @"saved successfully" : @"save failed");
}

- (id)usersFromFileSystem  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:@(self.user.ID).stringValue
                                 inSearchPathDirectory:NSDocumentDirectory];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
}

@end
