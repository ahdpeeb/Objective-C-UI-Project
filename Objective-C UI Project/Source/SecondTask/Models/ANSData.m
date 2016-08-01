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

static NSString * const kANSString          = @"kANSString";
static NSString * const kANSImage           = @"kANSImage";

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
        
        self.mutableImage = nil;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

    //this method will instal default image;
- (void)setMutableImage:(UIImage *)mutableImage {
    if (_mutableImage != mutableImage || !_mutableImage) {
        NSString *path = [[NSBundle mainBundle] pathForResource:kANSImageName ofType:kANSImageFormat];
        
        _mutableImage = [UIImage imageWithContentsOfFile:path];
    }
}

- (NSString *)string {
    return self.mutableString;
}

- (UIImage *)image {
    return self.mutableImage;
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.string forKey:kANSString];
    [aCoder encodeObject:self.image forKey:kANSImage];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.mutableString = [aDecoder decodeObjectForKey:kANSString];
        self.mutableImage = [aDecoder decodeObjectForKey:kANSImage];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (id)copyWithZone:(NSZone *)zone {
    id copy = [[self class] new];
    if (copy) {
        [copy setMutableString:[self.mutableString copyWithZone:zone]];
    }
    
    return copy;
}

@end
