//
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ANSImageModel.h"

@interface ANSFaceBookUser : NSObject <NSCoding, NSCopying>
@property (nonatomic, readonly)  NSInteger    ID;
@property (nonatomic, readonly)  NSURL        *imageUrl;

@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, readonly) ANSImageModel   *imageModel;

- (void)loadUser;

@end
