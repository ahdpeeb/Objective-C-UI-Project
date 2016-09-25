//
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSObservableObject.h"

@class ANSFacebookUser;
@class ANSImageModel;

@protocol ANSUserStateObserver <NSObject>

@optional;
- (void)userDidLoadID:(ANSFacebookUser *)user;
- (void)userDidLoadBasic:(ANSFacebookUser *)user;
- (void)userDidLoadDetails:(ANSFacebookUser *)user;

@end

typedef NS_ENUM(NSUInteger, ANSUserState) {
    ANSUserUnloaded,
    ANSUserDidLoadID,
    ANSUserDidLoadBasic,
    ANSUserDidLoadDetails,
    
    ANSUserStateCount,
};

@interface ANSFacebookUser : ANSObservableObject  <NSCoding, NSCopying>
@property (nonatomic, assign)    NSInteger      ID;
@property (nonatomic, strong)    NSString       *firsName;
@property (nonatomic, strong)    NSString       *lastName;
@property (nonatomic, strong)    NSURL          *imageUrl;

@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, readonly) ANSImageModel   *imageModel;

@end
