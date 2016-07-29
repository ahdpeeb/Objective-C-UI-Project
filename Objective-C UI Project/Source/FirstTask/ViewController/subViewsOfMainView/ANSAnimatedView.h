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
    ANSLeftTopPosition       = 0,
    ANSRightTopPosition      = 1,
    ANSRightButtomPosition   = 2,
    ANSLeftButtomPosition    = 3,
    
    ANSPositionCount         = 4,
} ANSViewPosition;

@interface ANSAnimatedView : UIView
@property (nonatomic, assign)                      ANSViewPosition     position;
@property (nonatomic, readonly, getter=isAnimate)  BOOL                animate;

- (void)setPosition:(ANSViewPosition)position
         isAnimated:(BOOL)value;

- (void)setPosition:(ANSViewPosition)position
         isAnimated:(BOOL)value
        withHandler:(ANSCompletionHandler)block;

- (void)startAnimation; 
- (void)stopAnimation;

- (void)initDancer;

@end
