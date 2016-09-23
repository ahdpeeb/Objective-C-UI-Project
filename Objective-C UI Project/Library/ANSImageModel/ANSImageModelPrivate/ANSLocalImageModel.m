//
//  ANSLocalImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLocalImageModel.h"

#import "ANSImageModel+ANSPrivatExtension.h"

typedef void(^ANSImageHandler)(void);

@implementation ANSLocalImageModel

#pragma mark -
#pragma mark Privat methods

- (void)performLoading {
    self.image = [UIImage imageWithContentsOfFile:self.imagePath];
}
    
@end
