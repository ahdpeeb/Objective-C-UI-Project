//
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFaceBookUser.h"

#import "NSString+ANSExtension.h"
#import "ANSLoadableUserContext.h"

static NSString * const kANSIDKey        = @"kANSIDKey";
static NSString * const kANSFirstNameKey = @"kANSFirstNameKey";
static NSString * const kANSLastNameKey  = @"kANSLastNameKey";
static NSString * const kANSImageUrlKey  = @"kANSImageUrlKey";

@interface ANSFaceBookUser ()
@property (nonatomic, assign)    NSInteger    ID;

@end

@implementation ANSFaceBookUser

@dynamic fullName;

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)initWithID:(NSUInteger)ID {
    self = [super init];
    if (self) {
        self.ID = ID;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)fullName {
    return [self.firsName stringByAppendingString:self.lastName];
}

- (ANSImageModel *)imageModel {
    return [ANSImageModel imageFromURL:self.imageUrl];
}

#pragma mark -
#pragma mark PublicMethods

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.ID forKey:kANSIDKey];    
    [aCoder encodeObject:self.firsName forKey:kANSFirstNameKey];
    [aCoder encodeObject:self.lastName forKey:kANSLastNameKey];
    [aCoder encodeObject:self.imageUrl forKey:kANSImageUrlKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.ID       = [aDecoder decodeIntegerForKey:kANSIDKey];
        self.firsName = [aDecoder decodeObjectForKey:kANSFirstNameKey];
        self.lastName = [aDecoder decodeObjectForKey:kANSLastNameKey];
        self.imageUrl = [aDecoder decodeObjectForKey:kANSImageUrlKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (ANSFaceBookUser *)copyWithZone:(NSZone *)zone {
    ANSFaceBookUser* copy = [[self class] new];
    if (copy) {
        copy.ID = self.ID;
        copy.firsName = self.firsName;
        copy.lastName = self.lastName;
        copy.imageUrl = self.imageUrl;
    }
    
    return copy;
}

@end
