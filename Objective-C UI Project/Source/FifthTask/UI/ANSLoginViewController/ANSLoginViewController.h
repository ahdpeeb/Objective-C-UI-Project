//
//  ANSLoginViewController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSFBUser.h"

@interface ANSLoginViewController : UIViewController <ANSUserStateObserver>

- (IBAction)onLogin:(UIButton *)sender;
- (IBAction)onCoreDataTest:(UIButton *)sender;

@end
