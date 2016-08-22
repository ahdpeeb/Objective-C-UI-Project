//
//  ANSLoadingView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLoadingView.h"

static const NSTimeInterval kANSInterval = 1.0f;

@interface ANSLoadingView ()
@property (nonatomic, assign) ANSLoadingViewState state;

- (void)action:(CGFloat)alpha shouldHide:(BOOL)value state:(ANSLoadingViewState)state;

@end

@implementation ANSLoadingView

#pragma mark -
#pragma mark Class methods

+ (void)attachToView:(id)view {
    if ([view isKindOfClass:[UIView class]]) {
        ANSLoadingView *view = [[ANSLoadingView alloc] initWithFrame:view.bounds];
        [view addSubview:view];
    }
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bounds = self.superview.bounds;
}

#pragma mark -
#pragma mark Private methods

- (void)action:(CGFloat)alpha shouldHide:(BOOL)value state:(ANSLoadingViewState)state {
    [UIView animateWithDuration:kANSInterval animations:^{
        self.alpha = alpha;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.state = state;
    }];
}
#pragma mark -
#pragma mark Public method

- (void)activate {
    [self action:1 shouldHide:NO state:ANSActive];
}

- (void)deactivate {
    [self action:0 shouldHide:YES state:ANSInactive];
}

@end
