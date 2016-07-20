//
//  ANSAnimatedView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSAnimatedView.h"

static const NSTimeInterval kANSInterval = 1.5f;
static const NSTimeInterval kANSDelay = 0;

@interface ANSAnimatedView ()
@property (nonatomic, assign) ANSViewPosition wiewPosition;

// returns new cutted CGRect from superView rect
- (CGRect)cuttedSuperRect;

// generate point from position
- (CGPoint)position:(ANSViewPosition)position;

// get next position
- (ANSViewPosition)nextViewPosition:(ANSViewPosition)position;

@end


@implementation ANSAnimatedView

#pragma mark -
#pragma mark Accsessors 
    //_______________________________
- (void)setWiewPosition:(ANSViewPosition)wiewPosition {
    if (_wiewPosition == wiewPosition) {
        return;
    }
    _wiewPosition = wiewPosition;
    CGPoint point = [self position:wiewPosition];
    NSLog(@"%@", NSStringFromCGPoint(point));
    self.center = point;
}
    //_______________________________
- (void)setWiewPosition:(ANSViewPosition)wiewPosition
         isAnimated:(BOOL)value
{
    if (!value) {
        self.wiewPosition = wiewPosition;
    }
    
    [UIView animateWithDuration:kANSInterval animations:^{
        self.wiewPosition = wiewPosition;
    }];
}
    //_______________________________
- (void)setWiewPosition:(ANSViewPosition)wiewPosition
         isAnimated:(BOOL)value
               with:(ANSCompletionHandler)block
{
    if (!value) {
        self.wiewPosition = wiewPosition;
    }
    
    [UIView animateWithDuration:kANSInterval
                          delay:kANSDelay
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.wiewPosition = wiewPosition;
                     } completion:block];
}

#pragma mark -
#pragma mark Public methods

- (void)startAnimation {
    ANSViewPosition current = self.wiewPosition;
    
   __weak ANSAnimatedView *weakSelf = self;
    [self setWiewPosition:[self nextViewPosition:current] isAnimated:YES with:^(BOOL finished) {
        if (finished) {
            NSLog(@"finished");
            if (self.wiewPosition == ANSDefaultPosition) {
                return;
            }
            
            __strong ANSAnimatedView *strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeRotation(M_PI_2);
            [strongSelf startAnimation];
        }
    }];
}

- (void)stopAnimation {
    self.wiewPosition = ANSDefaultPosition;
}

- (void)nextPosition {

}

#pragma mark -
#pragma mark Ptivate methods

- (CGPoint)position:(ANSViewPosition)position {
    CGRect rect = [self cuttedSuperRect];
    switch (position) {
        case ANSFirsPosition:
           return CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
        case ANSSecondPosition:
            return CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        case ANSThirdPosition:
            return CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
        case ANSFourthPosition:
            return CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
        default:
            return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    }
}

- (ANSViewPosition)nextViewPosition:(ANSViewPosition)position {
    switch (position) {
        case ANSFirsPosition:       return ANSSecondPosition;
        case ANSSecondPosition:     return ANSThirdPosition;
        case ANSThirdPosition:      return ANSFourthPosition;
        case ANSFourthPosition:     return ANSFirsPosition;
        default:
            return ANSFirsPosition;
    }
}

- (CGRect)cuttedSuperRect {
    CGRect superRect = self.superview.bounds;
    CGFloat halfWidth = CGRectGetWidth(self.frame) / 2;
    CGFloat halfheight = CGRectGetHeight(self.frame) / 2;
    
   return CGRectInset(superRect, halfWidth, halfheight);
}

@end
