//
//  ANSUser.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ANSImageModel.h"

@interface ANSUser : NSObject <NSCoding, NSCopying>
@property (nonatomic, readonly) NSString        *name;
@property (nonatomic, readonly) ANSImageModel   *imageModel;

@end
