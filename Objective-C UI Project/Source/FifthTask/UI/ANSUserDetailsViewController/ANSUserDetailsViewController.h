//
//  ANSUserDetailsViewController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSUser.h"

@interface ANSUserDetailsViewController : UIViewController <ANSUserObserver>
@property (nonatomic, strong) ANSUser *user;

@end
