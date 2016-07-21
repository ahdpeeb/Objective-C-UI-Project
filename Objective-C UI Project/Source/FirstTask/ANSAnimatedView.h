//
//  ANSAnimatedView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ANSCompletionHandler)(BOOL finished);

typedef enum {
    ANSDefaultPosition,
    
    ANSFirsPosition,
    ANSSecondPosition,
    ANSThirdPosition,
    ANSFourthPosition,
} ANSViewPosition;

@interface ANSAnimatedView : UIView

- (void)setWiewPosition:(ANSViewPosition)position
             isAnimated:(BOOL)value;

- (void)setWiewPosition:(ANSViewPosition)position
             isAnimated:(BOOL)value
                   with:(ANSCompletionHandler)block;

- (void)startAnimation; 
- (void)stopAnimation;

- (void)initDancer;
@end
