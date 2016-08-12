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
static NSString * const kANSImageName       = @"Gomer_2";
static NSString * const kANSImageFormat     = @"png";

static NSString * const kANSStringKey        = @"kANSStringKey";
static NSString * const kANSImageModelKey    = @"kANSImageModelKey";


@interface ANSUser ()
@property (nonatomic, copy) NSString *mutableString;

@end

@implementation ANSUser

@dynamic string;
@dynamic image;

#pragma mark -
#pragma mark Initialization and deallocation 

- (void)dealloc {
    self.imageModel = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *alphabet = [NSString alphanumericAlphabet];
        self.mutableString = [NSString randomStringWithLength:kANSStringLength alphabet:alphabet];
        
        NSURL *ulr = [[NSBundle mainBundle] URLForResource:kANSImageName withExtension:kANSImageFormat];
        self.imageModel = [ANSImageModel imageFromURL:ulr];;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)string {
    return self.mutableString;
}

- (UIImage *)image {
    return self.imageModel.image;
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.string forKey:kANSStringKey];
    [aCoder encodeObject:self.imageModel forKey:kANSImageModelKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.mutableString = [aDecoder decodeObjectForKey:kANSStringKey];
        self.imageModel = [aDecoder decodeObjectForKey:kANSImageModelKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (ANSUser *)copyWithZone:(NSZone *)zone {
    ANSUser * copy = [[self class] new];
    if (copy) {
        [copy setMutableString:self.mutableString];
        [copy setImageModel:self.imageModel];
    }
    
    return copy;
}

@end
