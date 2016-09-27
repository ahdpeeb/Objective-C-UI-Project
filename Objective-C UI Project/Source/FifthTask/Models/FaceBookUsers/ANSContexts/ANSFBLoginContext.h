//
//  ANSFBLoginContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSFBUserContext.h"

@interface ANSFBLoginContext : ANSFBUserContext
@property (nonatomic, strong) FBSDKLoginManager *loginManager;

@end
