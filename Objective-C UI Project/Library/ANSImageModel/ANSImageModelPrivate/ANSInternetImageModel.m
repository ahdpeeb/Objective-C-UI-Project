//
//  ANSInternetImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSInternetImageModel.h"

@implementation ANSInternetImageModel

#import "ANSImageModel.h"

#import "ANSMacros.h"
#import "ANSRandom.h"
#import "NSFileManager+ANSExtension.h"
#import "UIImage+ANSExtension.h"

@interface ANSImageModel ()

- (BOOL)isDownloadedImageToFile;
- (UIImage *)loadedImageFromInternet;
- (void)removeCorruptedFile;
- (UIImage *)loadImage;

@end

@implementation ANSImageModel

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

- (UIImage *)loadImage {
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

@end
