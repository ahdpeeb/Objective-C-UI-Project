//
//  ANSUser.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANSUser : NSObject
@property (nonatomic, copy)     NSString *name;
@property (nonatomic, copy)     NSString *surname;
@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) UIImage  *userImage;

@end
