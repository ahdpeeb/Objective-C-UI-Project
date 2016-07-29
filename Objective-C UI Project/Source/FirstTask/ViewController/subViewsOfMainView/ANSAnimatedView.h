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
    ANSDefaultPosition       = 0,
    
    ANSLeftTopPosition       = 1,
    ANSRightTopPosition      = 2,
    ANSRightButtomPosition   = 3,
    ANSLeftButtomPosition    = 4,
    
    ANSPositionCount         = 5,
} ANSViewPosition;

@interface ANSAnimatedView : UIView
@property (nonatomic, assign) ANSViewPosition   viewPosition;

- (void)setViewPosition:(ANSViewPosition)position
             isAnimated:(BOOL)value;

- (void)setViewPosition:(ANSViewPosition)position
             isAnimated:(BOOL)value
                   with:(ANSCompletionHandler)block;

- (void)startAnimation; 
- (void)stopAnimation;

- (void)initDancer;

@end
