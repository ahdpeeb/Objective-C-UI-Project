//
//  ANSAnimatedView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSAnimatedView.h"

static const NSTimeInterval kANSAnimatioDuration = 0.5;

static const NSTimeInterval kANSInterval = 1.5f;
static const NSTimeInterval kANSDelay = 0;

@interface ANSAnimatedView ()
@property (nonatomic, strong) UIImageView       *animation;
@property (nonatomic, assign) ANSViewPosition   nexPosition;

// returns new cutted CGRect from superView rect
- (CGRect)newRect;

// generate point from position
- (CGPoint)position:(ANSViewPosition)position;

@end

@implementation ANSAnimatedView

#pragma mark -
#pragma mark Accsessors

- (void)setViewPosition:(ANSViewPosition)viewPosition {
    if (_viewPosition != viewPosition) {
        _viewPosition = viewPosition;

        CGPoint point = [self position:viewPosition];
        NSLog(@"%@", NSStringFromCGPoint(point));
        self.center = point;
    }
}

- (void)setViewPosition:(ANSViewPosition)viewPosition
         isAnimated:(BOOL)value
               with:(ANSCompletionHandler)block
{
    if (!value) {
        self.viewPosition = viewPosition;
    }
    
    [UIView animateWithDuration:kANSInterval
                          delay:kANSDelay
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.viewPosition = viewPosition;
                     } completion:block];
}

//____________________________________________________________
- (void)setViewPosition:(ANSViewPosition)viewPosition
             isAnimated:(BOOL)value
{
    [self setViewPosition:viewPosition isAnimated:value with:nil];
}

#pragma mark -
#pragma mark Public methods

- (void)startAnimation {
    [self.animation startAnimating];
    
    ANSViewPosition position = self.nexPosition;
    
   __weak ANSAnimatedView *weakSelf = self;
    [self setViewPosition:position isAnimated:YES with:^(BOOL finished) {
        if (finished) {
            NSLog(@"finished block");
            __strong ANSAnimatedView *strongSelf = weakSelf;
            
            ANSViewPosition next = (strongSelf.nexPosition + 1) % 5;
            NSLog(@"%d", next);
            ANSViewPosition currect = strongSelf.viewPosition;
            NSLog(@"%d", currect);
            
            strongSelf.nexPosition = next;
            
            [strongSelf startAnimation];
        }
    }];
}

- (void)stopAnimation {
    [self.layer removeAllAnimations];
    self.viewPosition = ANSDefaultPosition;
    [self.animation stopAnimating];
}
    
#pragma mark -
#pragma mark Ptivate methods

- (CGPoint)position:(ANSViewPosition)position {
    CGRect rect = [self newRect];
    switch (position) {
        case ANSLeftTopPosition:
           return CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
        case ANSRightTopPosition:
            return CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
        case ANSRightButtomPosition:
            return CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        case ANSLeftButtomPosition:
            return CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
        default:
            return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    }
}

- (CGRect)newRect {
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
    
    NSMutableArray *animations = [NSMutableArray new];
    for (int index = 0; index < [imageNames count]; index++) {
        [animations addObject:[UIImage imageNamed:imageNames[index]]];
    }
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:self.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.animation = view;
    
    view.animationImages = animations;
    view.animationDuration = kANSAnimatioDuration;
    
    [self addSubview:view];
}

@end
