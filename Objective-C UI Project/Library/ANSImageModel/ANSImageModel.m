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
@property (nonatomic, strong)       NSFileManager       *fileManager;

@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

@end

@implementation ANSImageModel

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
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _fileManager = [NSFileManager defaultManager];
        });
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)load {
    [self loadWithBlock:^BOOL{
        NSString *urlPath = self.url.path;
        NSString *directoryPath = [NSFileManager documentDirectoryPath];
        
        NSString *imageName = [urlPath lastPathComponent];
        NSString *imagePathInDirectory = [directoryPath stringByAppendingPathComponent:imageName];
        
        UIImage *image = [UIImage imageWithContentsOfFile:imagePathInDirectory];
        // REMOVE SLEEP
        sleep((float)ANSRandomIntegerWithValues(1, 4));
        if (!image) {
            BOOL succsess = [self.fileManager copyFileAtPath:urlPath toSearchPathDirectory:NSDocumentDirectory];
            if (!succsess) {
                return NO;
            }
        
            image = [UIImage imageWithContentsOfFile:imagePathInDirectory];
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
