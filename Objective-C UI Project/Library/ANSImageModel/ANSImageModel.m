//
//  ANSImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModel.h"

#import "ANSMacros.h"
#import "ANSRandom.h"
#import "NSFileManager+ANSExtension.h"

static NSString * const kANSImageName = @"kANSImageName";

@interface ANSImageModel ()
@property (nonatomic, strong)       NSString            *imageName;
@property (nonatomic, strong)       UIImage             *image;
@property (nonatomic, strong)       NSURL               *url;
@property (nonatomic, readonly)     NSString            *imagePath;

@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

- (BOOL)uploadImage;

@end

@implementation ANSImageModel

@dynamic imagePath;

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageFromURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)imagePath {
    NSString *directoryPath = [NSFileManager documentDirectoryPath];
    NSString *imageName = [self.url.path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
    return [directoryPath stringByAppendingPathComponent:imageName];
}

#pragma mark -
#pragma mark Privat methods

- (BOOL)uploadImage {
    NSString *imageExtension = self.url.pathExtension;
    NSData *imageData = [NSData dataWithContentsOfURL:self.url];
    UIImage *image = [UIImage imageWithData:imageData];
    NSData *cachedImage = nil;
    if (image) {
        if ([imageExtension isEqual: @"png"]) {
            cachedImage = UIImagePNGRepresentation(image);
        } else if ([imageExtension isEqual: @"jpeg"]) {
            cachedImage = UIImageJPEGRepresentation(image, 1);
        }
        
        return [cachedImage writeToFile:self.imagePath atomically:YES];
    }
   
    return NO;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.imagePath]) {
        NSLog(@"NOImage");
        BOOL isSuccess = [self uploadImage];
        NSLog(@"isSuccess = %d", isSuccess);
    }
    
    self.image = [UIImage imageWithContentsOfFile:self.imagePath];
    sleep((int)ANSRandomUnsignedInteget(7));
    self.state = self.image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}

- (void)dump {
    @synchronized(self) {
        self.image = nil;
        self.state = ANSLoadableModelUnloaded;
    }
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    self.imageName = self.url.URLByStandardizingPath.path;
    [aCoder encodeObject:self.imageName forKey:kANSImageName];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSString *imageName = [aDecoder decodeObjectForKey:kANSImageName];
        self.url = [NSURL URLWithString:imageName];
    }
    
    return self;
}

@end
