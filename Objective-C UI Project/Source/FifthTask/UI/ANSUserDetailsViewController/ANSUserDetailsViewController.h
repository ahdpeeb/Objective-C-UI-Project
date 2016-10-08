//
//  ANSUserDetailsViewController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSFBUser.h"

@interface ANSUserDetailsViewController : UIViewController <ANSFBUserStateObserver, ANSFBUserStateObserver>
@property (nonatomic, strong) ANSFBUser *user;

@end
