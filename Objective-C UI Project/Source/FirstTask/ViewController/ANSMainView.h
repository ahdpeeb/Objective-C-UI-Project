//
//  ANSMainView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSAnimatedView.h"

@interface ANSMainView : UIView
@property (nonatomic, strong) IBOutlet ANSAnimatedView  *view;
@property (nonatomic, strong) IBOutlet UIButton         *startButton;
@property (nonatomic, strong) IBOutlet UIButton         *stopButton;
@property (nonatomic, strong) IBOutlet UIButton         *nextButton;

@end
