//
//  ANSLocalImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLocalImageModel.h"

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
    return [UIImage imageWithContentsOfFile:self.imagePath];
}

@end
