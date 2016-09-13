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
#import "UIImage+ANSExtension.h"


static NSString * const kANSImageName = @"kANSImageName";

@interface ANSImageModel ()
@property (nonatomic, strong)   UIImage   *image;
@property (nonatomic, strong)   NSURL     *url;

@property (nonatomic, readonly) NSString  *imageName;
@property (nonatomic, readonly) NSString  *imagePath;

- (BOOL)isDownloadedImageToFile;
- (UIImage *)loadedImageFromInternet;
- (void)removeCorruptedFile;
- (UIImage *)loadedImage;

@end

@implementation ANSImageModel

@dynamic imagePath;
@dynamic imageName;

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

- (NSString *)imageName {
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}

- (NSString *)imagePath {
    return [[NSFileManager documentDirectoryPath] stringByAppendingPathComponent:self.imageName];
}

#pragma mark -
#pragma mark Privat methods

- (BOOL)isDownloadedImageToFile {
    BOOL downloaded = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.imagePath]) {
        NSData *imageData = [NSData dataWithContentsOfURL:self.url];
        downloaded = [imageData writeToFile:self.imagePath atomically:YES];
        downloaded ? NSLog(@"Loaded [OK]") : NSLog(@"Loaded [ERROR]");
    }
    
    return downloaded;
}

- (void)removeCorruptedFile {
    BOOL isRemoved = [[NSFileManager defaultManager] removeFile:self.imageName
                                        fromSearchPathDirectory:NSDocumentDirectory];
    
    isRemoved ? NSLog(@"Remove [OK]") : NSLog(@"Remove [ERROR]");
}

- (UIImage *)loadedImageFromInternet {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:self.url]];
}

- (UIImage *)loadedImage {
    UIImage *image = nil;
    
    BOOL downloaded = [self isDownloadedImageToFile];
    if (downloaded) {
        image = [UIImage imageWithContentsOfFile:self.imagePath];
    }
    
    if (!image && downloaded) {
        [self removeCorruptedFile];
    } else if (!image && !downloaded) {
        image = [self loadedImageFromInternet];
    }
    
    return image;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    self.image = [self loadedImage];
    self.state = self.image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}

@end
