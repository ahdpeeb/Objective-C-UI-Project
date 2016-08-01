//
//  ANSUser.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSData.h"

#import "NSString+ANSExtension.h"

static const NSUInteger kANSStringLength    = 10;
static NSString * const kANSImageName       = @"Gomer_2";
static NSString * const kANSImageFormat     = @"png";

static NSString * const kANSStringKey          = @"kANSStringKey";
static NSString * const kANSImageKey           = @"kANSImageKey";

@interface ANSData ()
@property (nonatomic, copy)     NSString *mutableString;
@property (nonatomic, strong)   UIImage  *mutableImage;

@end

@implementation ANSData

@dynamic string;
@dynamic image;

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *alphabet = [NSString alphanumericAlphabet];
        self.mutableString = [NSString randomStringWithLength:kANSStringLength alphabet:alphabet];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:kANSImageName ofType:kANSImageFormat];
        self.mutableImage = [UIImage imageWithContentsOfFile:path];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)string {
    return self.mutableString;
}

- (UIImage *)image {
    return self.mutableImage;
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.string forKey:kANSStringKey];
    [aCoder encodeObject:self.image forKey:kANSImageKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.mutableString = [aDecoder decodeObjectForKey:kANSStringKey];
        self.mutableImage = [aDecoder decodeObjectForKey:kANSImageKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (id)copyWithZone:(NSZone *)zone {
    id copy = [[self class] new];
    if (copy) {
        [copy setMutableString:self.mutableString];
        [copy setMutableImage:self.mutableImage];
    }
    
    return copy;
}

@end
