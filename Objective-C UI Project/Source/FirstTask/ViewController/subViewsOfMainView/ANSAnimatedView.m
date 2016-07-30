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

static NSString * const kANSImageFormat = @".png";
static const NSUInteger KANSImageCount = 16;

@interface ANSAnimatedView ()
@property (nonatomic, assign, getter=isAnimate) BOOL                animate;
@property (nonatomic, strong)                   UIImageView       *animationImage;
@property (nonatomic, assign)                   ANSViewPosition   nextPosition;

// returns new cutted CGRect from superView rect
- (CGRect)newRect;

// generate point from position
- (CGPoint)pointFromPosition:(ANSViewPosition)position;

@end

@implementation ANSAnimatedView

#pragma mark -
#pragma mark Accsessors

- (void)setPosition:(ANSViewPosition)position {
    if (_position != position) {
        _position = position;
        
        CGPoint point = [self pointFromPosition:position];
        NSLog(@"%@", NSStringFromCGPoint(point));
        self.center = point;
    }
}


- (void)setPosition:(ANSViewPosition)position
         isAnimated:(BOOL)value
            withHandler:(ANSCompletionHandler)block
{
    if (!value) {
        self.position = self.position; // or viewPosition.
    }
    
    [UIView animateWithDuration:kANSInterval
                          delay:kANSDelay
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.position = position;
                     } completion:block];
}

- (void)setPosition:(ANSViewPosition)position
             isAnimated:(BOOL)value
{
    [self setPosition:position isAnimated:value withHandler:nil];
}

#pragma mark -
#pragma mark Public methods

- (void)startAnimation {
    self.animate = YES;
    
    [self.animationImage startAnimating];
    
    ANSViewPosition position = self.nextPosition;
    
   __weak ANSAnimatedView *weakSelf = self;
    [self setPosition:position isAnimated:YES withHandler:^(BOOL finished) {
        if (finished) {
            __strong ANSAnimatedView *strongSelf = weakSelf;
            
            if (!strongSelf.isAnimate) {
                [strongSelf.animationImage stopAnimating];
                return ;
            }

            strongSelf.nextPosition = (strongSelf.nextPosition + 1) % ANSPositionCount;
            [strongSelf startAnimation];
        }
    }];
}

- (void)stopAnimation {
    self.animate = NO;
}

- (void)initDancer {
    NSMutableArray *animations = [NSMutableArray new];
    for (int index = 0; index < KANSImageCount; index++) {
        
        NSString *stirng = [NSString stringWithFormat:@"%d", index + 1];
        NSString *path = [[NSBundle mainBundle] pathForResource:stirng ofType:kANSImageFormat];
        [UIImage imageWithContentsOfFile:path];
        
        [animations addObject:[UIImage imageNamed:stirng]];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.animationImage = imageView;
    
    imageView.animationImages = animations;
    imageView.animationDuration = kANSAnimatioDuration;
    
    [self addSubview:imageView];
}

#pragma mark -
#pragma mark Ptivate methods

- (CGPoint)pointFromPosition:(ANSViewPosition)position {
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

@end
