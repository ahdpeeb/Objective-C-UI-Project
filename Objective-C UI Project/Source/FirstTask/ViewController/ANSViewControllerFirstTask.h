//
//  ANSViewControllerFirstTask.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANSRootView;

@interface ANSViewControllerFirstTask : UIViewController
@property (nonatomic, readonly) ANSRootView *rootView;

- (IBAction)onAnimation:(id)sender;

@end
