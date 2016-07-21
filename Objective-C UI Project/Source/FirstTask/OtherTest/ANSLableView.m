//
//  ANSLableView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLableView.h"

@interface ANSLableView ()
@property (nonatomic, strong) UITouch *touch;

- (void)processTouches:(NSSet *)touches;

@end

@implementation ANSLableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lable.text = @"VASIA";
}

- (void)rotateLabel {
    self.lable.transform = CGAffineTransformMakeRotation((float)arc4random()/ UINT32_MAX * 2 * M_PI);
}

#pragma mark -
#pragma mark Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.touch = [touches anyObject];
    
    [self processTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self processTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self processTouches:touches];
    
    self.touch = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self processTouches:touches];
    
    self.touch = nil;
}

#pragma mark -
#pragma mark Private

- (void)processTouches:(NSSet *)touches {
    UITouch *mainTouch = self.touch;
    CGPoint location = [mainTouch locationInView:self];
    
    CGRect frame = self.frame;
    frame.origin = location;
    self.frame = frame;
}

@end
