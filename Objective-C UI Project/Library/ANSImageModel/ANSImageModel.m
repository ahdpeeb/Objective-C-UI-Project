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
    NSString *imageName = [self.url.path lastPathComponent];
    
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
        }
        
        if ([imageExtension isEqual: @"jpeg"]) {
            cachedImage = UIImageJPEGRepresentation(image, 1);
        }
        
        return [cachedImage writeToFile:self.imagePath atomically:YES];
    }
   
    return NO;
}

#pragma mark -
#pragma mark Public Methods

- (void)load {
    [self loadWithBlock:^BOOL{
       UIImage *image = [UIImage imageWithContentsOfFile:self.imagePath];
        if (!image) {
            BOOL succsess = [self uploadImage];
            if (!succsess) {
                return NO;
            }
        
            image = [UIImage imageWithContentsOfFile:self.imagePath];
        }
        
        self.image = image;
        if (image) {
            return YES;
        }
        
        return NO;
    }];
}

- (void)dump {
    @synchronized(self) {
        self.image = nil;
        self.state = ANSLoadableModelUnloaded;
    }
}

#pragma mark -
#pragma mark NSCoding protocol

//saving name of image
- (void)encodeWithCoder:(NSCoder *)aCoder {
    self.imageName = self.url.path.lastPathComponent;
    [aCoder encodeObject:self.imageName forKey:kANSImageName];
}
//restore image from mainBundle after backup using image name;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSString *imageName = [aDecoder decodeObjectForKey:kANSImageName];
        NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
        self.url = [NSURL fileURLWithPath:imagePath isDirectory:YES];
    }
    
    return self;
}

@end
