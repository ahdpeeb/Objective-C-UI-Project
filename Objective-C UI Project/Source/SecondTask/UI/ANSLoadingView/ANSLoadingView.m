//
//  ANSLoadingView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLoadingView.h"

static const NSTimeInterval kANSInterval = 1.0f;

@implementation ANSLoadingView

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
}

- (void)dissapearWithAnimation {
    [UIView animateWithDuration:kANSInterval animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.indicator stopAnimating];
         self.hidden = YES;
    }];
}
@end
