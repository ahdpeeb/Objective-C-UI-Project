//
//  ANSUser.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUser.h"

#import "NSString+ANSExtension.h"

static const NSUInteger kANSStringLength    = 10;
static NSString * const kANSImageLink = @"https://d13yacurqjgara.cloudfront.net/users/146798/screenshots/2843164/pikatchu-dribbble-final_1x.png";

static NSString * const kANSStringKey = @"kANSStringKey";


@interface ANSUser ()
@property (nonatomic, copy) NSString *mutableString;

@end

@implementation ANSUser

@dynamic name;
@dynamic imageModel;

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *alphabet = [NSString alphanumericAlphabet];
        self.mutableString = [NSString randomStringWithLength:kANSStringLength alphabet:alphabet];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)name {
    return self.mutableString;
}

- (ANSImageModel *)imageModel {
    NSURL *url = [NSURL URLWithString:kANSImageLink];
    return [ANSImageModel imageFromURL:url];
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kANSStringKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.mutableString = [aDecoder decodeObjectForKey:kANSStringKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (ANSUser *)copyWithZone:(NSZone *)zone {
    ANSUser * copy = [[self class] new];
    if (copy) {
        [copy setMutableString:self.mutableString];
    }
    
    return copy;
}

@end
