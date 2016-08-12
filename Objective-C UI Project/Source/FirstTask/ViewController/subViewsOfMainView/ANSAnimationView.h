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
    ANSLeftTopPosition,
    ANSRightTopPosition,
    ANSRightButtomPosition,
    ANSLeftButtomPosition,
    
    ANSPositionCount
} ANSViewPosition;

@interface ANSAnimationView : UIView
@property (nonatomic, assign)                        ANSViewPosition     position;
@property (nonatomic, readonly, getter=isAnimating)  BOOL                animating;

- (void)setPosition:(ANSViewPosition)position
           animated:(BOOL)animatad;

- (void)setPosition:(ANSViewPosition)position
           animated:(BOOL)animatad
         completion:(ANSCompletionHandler)block;

- (void)startAnimation;
- (void)stopAnimation;

- (void)initAnimationImage;

@end
