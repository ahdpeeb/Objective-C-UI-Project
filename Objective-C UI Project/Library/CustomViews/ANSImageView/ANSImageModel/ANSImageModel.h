//
//  ANSImageModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSLoadableModel.h"

@interface ANSImageModel : ANSLoadableModel

//This property readonly
@property (nonatomic, strong)      NSURL        *url;

//This property readonly
@property (nonatomic, strong)      UIImage      *image;

@property (nonatomic, readonly)    NSString     *imageName;
@property (nonatomic, readonly)    NSString     *imagePath;

+ (instancetype)imageFromURL:(NSURL *)url;

//Privat method, have to reloaded in child classes
- (UIImage *)loadImage;

@end
