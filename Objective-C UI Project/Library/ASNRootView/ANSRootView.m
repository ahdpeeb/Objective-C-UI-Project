//
//  ANSRootView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSRootView.h"

#import "ANSLoadingView.h"

@implementation ANSRootView

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self attachDefaultLodingView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if (!self.loadingView) {
        [self attachDefaultLodingView];
    }
}

#pragma mark -
#pragma mark Accsessors

- (void)setLoadingView:(ANSLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = loadingView;
    }
}

- (void)setActiveLoadingView:(BOOL)activeLoadingView {
    if (_activeLoadingView != activeLoadingView) {
        _loadingView.visible = activeLoadingView;
        _activeLoadingView = activeLoadingView; 
    }
}

#pragma mark -
#pragma mark Private

- (void)attachDefaultLodingView {
    self.loadingView  = [ANSLoadingView loadingViewOnSuperView:self];
}

@end
