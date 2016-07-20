//
//  ANSAnimaterView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSAnimaterView.h"

@interface ANSAnimaterView ()
@property (nonatomic, assign) CGPoint position;

- (CGRect)cuttedSuperRect;

@end

@implementation ANSAnimaterView

#pragma mark -
#pragma mark Accsessors 

- (void)setPosition:(CGPoint)position {
    self.center = position;
}

- (void)setPosition:(CGPoint)position
         isAnimated:(BOOL)flag
{
    
}

- (void)setPosition:(CGPoint)position
         isAnimated:(BOOL)flag
               with:(ANSCompletionHandler)block
{
    
}

#pragma mark -
#pragma mark Ptivate 

- (CGPoint)newPosition:(ANSViewPosition)position {
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

- (CGRect)cuttedSuperRect {
    CGRect superRect = self.superview.bounds;
    CGFloat halfWidth = CGRectGetWidth(self.frame) / 2;
    CGFloat halfheight = CGRectGetHeight(self.frame) / 2;
    
   return CGRectInset(superRect, halfWidth, halfheight);
}

@end
