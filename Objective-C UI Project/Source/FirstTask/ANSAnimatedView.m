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
@property (nonatomic, assign) ANSViewPosition   wiewPosition;
@property (nonatomic, strong) UIImageView       *animation;

// returns new cutted CGRect from superView rect
- (CGRect)cuttedSuperRect;

// generate point from position
- (CGPoint)position:(ANSViewPosition)position;

// get next position
- (ANSViewPosition)nextViewPosition:(ANSViewPosition)position;

@end


@implementation ANSAnimatedView

#pragma mark -
#pragma mark

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
    //____________________________________________________________
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
    //______________________________________________________________
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
    [self.animation startAnimating];
    
    ANSViewPosition current = self.wiewPosition;
    
   __weak ANSAnimatedView *weakSelf = self;
    [self setWiewPosition:[self nextViewPosition:current] isAnimated:YES with:^(BOOL finished) {
        if (finished) {
            NSLog(@"finished");
            if (self.wiewPosition == ANSDefaultPosition) {
                return;
            }
            __strong ANSAnimatedView *strongSelf = weakSelf;
//            strongSelf.transform = CGAffineTransformMakeRotation(M_PI_2);
            [strongSelf startAnimation];
        }
    }];
}

- (void)stopAnimation {
    [self.layer removeAllAnimations];
    self.wiewPosition = ANSDefaultPosition;
    [self.animation stopAnimating];
}
    
#pragma mark -
#pragma mark Ptivate methods

- (CGPoint)position:(ANSViewPosition)position {
    CGRect rect = [self cuttedSuperRect];
    switch (position) {
        case ANSFirsPosition:
           return CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
        case ANSSecondPosition:
            return CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
        case ANSThirdPosition:
            return CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        case ANSFourthPosition:
            return CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
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

- (void)initDancer {
    NSArray *imageNames = @[@"1.png", @"2.png", @"3.png", @"4.png",
                            @"5.png", @"6.png", @"7.png", @"8.png",
                            @"9.png", @"10.png", @"11.png", @"12.png",
                            @"13.png", @"14.png", @"15.png", @"16.png"];
    
    NSMutableArray *animations = [[NSMutableArray alloc] init];
    for (int indexx = 0; indexx < [imageNames count]; indexx++) {
        [animations addObject:[UIImage imageNamed:[imageNames objectAtIndex:indexx]]];
    }
    CGRect rect = self.bounds;
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 86, 193)];
    self.animation = view;
    
    view.animationImages = animations;
    view.animationDuration = 0.5;
    
    [self addSubview:view];
}

@end
