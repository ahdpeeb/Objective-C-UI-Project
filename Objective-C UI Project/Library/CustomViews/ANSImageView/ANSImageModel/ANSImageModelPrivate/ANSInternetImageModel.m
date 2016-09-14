//
//  ANSInternetImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSInternetImageModel.h"

#import "ANSImageModel.h"

#import "ANSMacros.h"
#import "ANSRandom.h"
#import "NSFileManager+ANSExtension.h"
#import "UIImage+ANSExtension.h"

@interface ANSImageModel ()

- (BOOL)downloadImageToFileReturnIsSuccess;
- (UIImage *)imageFromInternet; 
- (void)removeCorruptedFile;
- (UIImage *)loadImage;

@end

@implementation ANSInternetImageModel

#pragma mark -
#pragma mark Accsessors

- (NSString *)imageName {
    NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)imagePath {
    return [[NSFileManager documentDirectoryPath] stringByAppendingPathComponent:self.imageName];
}

#pragma mark -
#pragma mark Privat methods

- (BOOL)downloadImageToFileReturnIsSuccess {
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
    
    isRemoved ? NSLog(@"Removed [OK]") : NSLog(@"Removed [ERROR]");
}

- (UIImage *)imageFromInternet {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:self.url]];
}

- (UIImage *)loadImage {
    UIImage *image = nil;
    
    BOOL isSuccess = [self downloadImageToFileReturnIsSuccess];
    if (isSuccess) {
        image = [UIImage imageWithContentsOfFile:self.imagePath];
    }
    
    if (!image && isSuccess) {
        [self removeCorruptedFile];
    } else if (!image && !isSuccess) {
        image = [self imageFromInternet];
    }
    
    return image;
}

@end
