//
//  ANSAnimatedView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSAnimationView.h"

static const NSTimeInterval kANSAnimatioDuration = 0.5;

static const NSTimeInterval kANSInterval = 1.5f;
static const NSTimeInterval kANSDelay = 0;

static NSString * const kANSImageFormat = @".png";
static const NSUInteger KANSImageCount = 16;

@interface ANSAnimationView ()
@property (nonatomic, assign, getter=isAnimating)   BOOL          animating;
@property (nonatomic, strong)                       UIImageView   *animationImage;

// returns new cutted CGRect from superView rect
- (CGRect)insectedFrame;

// generate point from position
- (CGPoint)pointFromPosition:(ANSViewPosition)position;
- (ANSViewPosition)nextPosition;

@end

@implementation ANSAnimationView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initAnimationImage];
}

#pragma mark -
#pragma mark Accsessors

- (void)setPosition:(ANSViewPosition)position {
    [self setPosition:position animated:YES];
}

- (void)setPosition:(ANSViewPosition)position
           animated:(BOOL)animatad
{
    [self setPosition:position animated:animatad completion:nil];
}

- (void)setPosition:(ANSViewPosition)position
           animated:(BOOL)animatad
         completion:(ANSCompletionHandler)block
{
    if (_position == position) {
        return;
    }
    
    [UIView animateWithDuration:animatad ? kANSInterval : 0
                          delay:kANSDelay
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.center = [self pointFromPosition:position];
                     } completion:^(BOOL finished){
                         _position = position;
                         
                         if (block) {
                             block(finished);
                         }
                     }];
}

#pragma mark -
#pragma mark Public methods

- (void)startAnimation {
    self.animating = YES;
    
    [self.animationImage startAnimating];
    
    __weak ANSAnimationView *weakSelf = self;
    [self setPosition:[self nextPosition] animated:YES completion:^(BOOL finished) {
        if (finished) {
            __strong ANSAnimationView *strongSelf = weakSelf;
            
            if (!strongSelf.animating) {
                [strongSelf.animationImage stopAnimating];
                return ;
            }

            [strongSelf startAnimation];
        }
    }];
}

- (void)stopAnimation {
    self.animating = NO;
}

- (void)initAnimationImage {
    NSMutableArray *animations = [NSMutableArray new];
    for (int index = 0; index < KANSImageCount; index++) {
        
        NSString *name = [NSString stringWithFormat:@"%d", index + 1];
        [animations addObject:[UIImage imageNamed:name]];
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
    CGRect rect = [self insectedFrame];
    
    CGPoint point = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint maxPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    switch (position) {
        case ANSLeftTopPosition:
            point = point;
            break;
        case ANSRightTopPosition:
            point.x = maxPoint.x;
            break;
        case ANSRightButtomPosition:
            point = maxPoint;
            break;
        case ANSLeftButtomPosition:
            point.y = maxPoint.y;
            break;
        default:
            point = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
            break;
    }
    
    return point;
}

- (CGRect)insectedFrame {
    CGRect superBounds = self.superview.bounds;
    CGFloat halfWidth = CGRectGetWidth(self.frame) / 2;
    CGFloat halfheight = CGRectGetHeight(self.frame) / 2;
    
   return CGRectInset(superBounds, halfWidth, halfheight);
}

- (ANSViewPosition)nextPosition {
   return (self.position + 1) % ANSPositionCount;
}

@end
