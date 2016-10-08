//
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBUser.h"

#import "ANSImageModel.h"
#import "NSString+ANSExtension.h"
#import "NSFileManager+ANSExtension.h"

static NSString * const kANSIDKey        = @"kANSIDKey";
static NSString * const kANSFirstNameKey = @"kANSFirstNameKey";
static NSString * const kANSLastNameKey  = @"kANSLastNameKey";
static NSString * const kANSImageUrlKey  = @"kANSImageUrlKey";

static NSString * const kANSUserID = @"userID";

@interface ANSFBUser ()

@end

@implementation ANSFBUser

@dynamic fullName;
@dynamic imageModel; 

#pragma mark -
#pragma mark Accsessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.lastName, self.firstName];
}

- (ANSImageModel *)imageModel {
    return [ANSImageModel imageFromURL:self.imageUrl];
}

#pragma mark -
#pragma mark Private Methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSFBUserDidLoadID:
            return @selector(userDidLoadID:);
            
        case ANSFBUserDidLoadBasic:
            return @selector(userDidLoadBasic:);
            
        case ANSFBUserDidLoadDetails:
            return @selector(userDidLoadDetails:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)save {
    NSString *plistName = [NSString stringWithFormat:@"%@ %lu", kANSUserID, self.ID];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistWithName:plistName inSearchPathDirectory:NSDocumentDirectory];
    BOOL isSuccessfully = [NSKeyedArchiver archiveRootObject:self toFile:plistPath];
    NSLog(@"%@", (isSuccessfully) ? @"saved successfully" : @"save failed");
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.ID forKey:kANSIDKey];    
    [aCoder encodeObject:self.firstName forKey:kANSFirstNameKey];
    [aCoder encodeObject:self.lastName forKey:kANSLastNameKey];
    [aCoder encodeObject:self.imageUrl forKey:kANSImageUrlKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.ID = [aDecoder decodeIntegerForKey:kANSIDKey];
        self.firstName = [aDecoder decodeObjectForKey:kANSFirstNameKey];
        self.lastName = [aDecoder decodeObjectForKey:kANSLastNameKey];
        self.imageUrl = [aDecoder decodeObjectForKey:kANSImageUrlKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (ANSFBUser *)copyWithZone:(NSZone *)zone {
    ANSFBUser* copy = [[self class] new];
    if (copy) {
        copy.ID = self.ID;
        copy.firstName = self.firstName;
        copy.lastName = self.lastName;
        copy.imageUrl = self.imageUrl;
    }
    
    return copy;
}

@end
