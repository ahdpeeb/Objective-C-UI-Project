//
//  UIImage+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (ANSExtension)

//save UIIimage object with PNG Representation to Document directory
- (NSString *)pathToPNGRepresentationWithName:(NSString *)name;

//save UIIimage object with JPEG Representation to Document directory
- (NSString *)pathToJPEGRepresentationWithName:(NSString *)name quality:(CGFloat)quality;

@end
