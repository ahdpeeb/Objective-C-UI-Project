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

@interface ANSFaceBookUser : NSObject <NSCoding, NSCopying>
@property (nonatomic, assign)  NSInteger    ID;
@property (nonatomic, strong)  NSString     *firsName;
@property (nonatomic, strong)  NSString     *lastName;
@property (nonatomic, strong)  NSURL        *imageUrl;

@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, readonly) ANSImageModel   *imageModel;


@end
