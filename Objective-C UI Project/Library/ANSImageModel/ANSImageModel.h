//
//  ANSImageModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSLoadableModel.h"

@interface ANSImageModel : ANSLoadableModel <NSCoding>
@property (nonatomic, readonly)                  UIImage *image;
@property (nonatomic, readonly)                  NSURL *url;

+ (instancetype)imageFromURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (void)dump;

@end
