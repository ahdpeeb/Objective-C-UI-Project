//
//  ANSLoadingView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLoadingView.h"

#import "ANSMacros.h"

static const NSTimeInterval kANSInterval = 1.0f;
static const NSTimeInterval kANSDelay = 0;

@interface ANSLoadingView ()
@property (nonatomic, assign) ANSLoadingViewState state;
@property (nonatomic, assign, getter=isVisible) BOOL visible;

@end

@implementation ANSLoadingView

#pragma mark -
#pragma mark Class methods

+ (instancetype)loadingViewOnSuperView:(UIView *)view {
    ANSLoadingView *loadingView = [[[self class] alloc] initWithFrame:view.bounds];
    loadingView.autoresizingMask =    UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleRightMargin
                                    | UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleHeight
                                    | UIViewAutoresizingFlexibleBottomMargin;
    loadingView.backgroundColor = [UIColor grayColor];
    [view addSubview:loadingView];
    
    return loadingView;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark -
#pragma mark Accsessors

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:NO];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
    [self setVisible:visible animated:animated complititionBlock:nil];
}

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
 complititionBlock:(ANSComplititionBlock)block {
    if (_visible != visible) {
        _visible = visible;
    }
    
    [UIView animateWithDuration:animated ? kANSInterval : 0
                          delay:kANSDelay
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.alpha = visible;
                         if (visible) {
                             [[self superview] bringSubviewToFront:self];
                         }
                         
                         self.state = visible;
                     } completion:^(BOOL finished) {
                         self.hidden = !visible;
                         ANSPerformBlockWithoutArguments(block);
                     }];
}

#pragma mark -
#pragma mark Public method

- (void)activate {
    [self setVisible:YES animated:YES];
}

- (void)deactivate {
    [self setVisible:NO animated:YES];
}

@end
