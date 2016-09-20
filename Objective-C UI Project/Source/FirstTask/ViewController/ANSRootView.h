//
//  ANSRootView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANSAnimationView;

@interface ANSRootView : UIView
@property (nonatomic, strong) IBOutlet ANSAnimationView *animationView;
@property (nonatomic, strong) IBOutlet UISwitch         *animationSwitcher;

@end
