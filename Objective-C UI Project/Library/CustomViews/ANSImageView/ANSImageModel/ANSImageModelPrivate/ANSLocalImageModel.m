//
//  ANSLocalImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLocalImageModel.h"

#import "ANSImageModel_ANSPrivatExtension.h"

#import "NSFileManager+ANSExtension.h"

@implementation ANSLocalImageModel

#pragma mark -
#pragma mark Accsessors

- (NSString *)imageName {
    return self.url.lastPathComponent;
}

- (NSString *)imagePath {
    return self.url.path;
}

#pragma mark -
#pragma mark Privat methods

- (UIImage *)loadImage {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    UIImage *image = nil;
    
    NSString *imagePath = self.imageName;
    if ([fileManager fileExistsAtPath:imagePath]) {
        image = [UIImage imageWithContentsOfFile:self.imagePath];
        if (image) {
            NSError *error = nil;
            [fileManager removeItemAtPath:self.imagePath error:&error];
            [self.cacheStorage removeObjectForKey:self.imageName];
        }
    }
    
    return image;
}

@end
