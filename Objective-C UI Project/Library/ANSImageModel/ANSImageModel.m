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
@property (nonatomic, strong)   UIImage   *image;
@property (nonatomic, strong)   NSURL     *url;

@property (nonatomic, readonly) NSString  *imageName;
@property (nonatomic, readonly) NSString  *imagePath;

@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

- (BOOL)downloadImage;

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
    NSString *name = [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
    NSLog(@"%@", name);
    
    return name;
}

- (NSString *)imagePath {
    return [[NSFileManager documentDirectoryPath] stringByAppendingPathComponent:self.imageName];
}

#pragma mark -
#pragma mark Privat methods

- (BOOL)downloadImage {
    NSData *imageData = [NSData dataWithContentsOfURL:self.url];
    return [imageData writeToFile:self.imagePath atomically:YES];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.imagePath]) {
        BOOL isLoaded = [self downloadImage];
        isLoaded ? NSLog(@"isLoaded [OK]") : NSLog(@"isLoaded [ERROR]");
    }
    
    self.image = [UIImage imageWithContentsOfFile:self.imagePath];
    UIImage *image = self.image;
    if (!image) {
        BOOL isRemove = [fileManager removeFile:self.imageName fromSearchPathDirectory:NSDocumentDirectory];
        isRemove ? NSLog(@"remove [OK]") : NSLog(@"remove [ERROR]");
    }

    self.state = image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}

@end
