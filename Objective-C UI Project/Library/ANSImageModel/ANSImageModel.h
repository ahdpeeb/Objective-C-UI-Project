//
//  ANSImageModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSObservableObject.h"

typedef NS_ENUM(NSUInteger, ANSImageModelState) {
    ANSImageModelUnloaded,
    ANSImageModelLoading,
    ANSImageModelLoaded,
    ANSImageModelFailedLoadin
};

@interface ANSImageModel : ANSObservableObject <NSCoding>
@property (nonatomic, readonly)                  UIImage *image;
@property (nonatomic, readonly)                  NSURL *url;

+ (instancetype)imageFromURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (void)load;
- (void)dump;

@end
