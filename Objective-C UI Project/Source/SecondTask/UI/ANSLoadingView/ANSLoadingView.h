//
//  ANSLoadingView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>


static const NSTimeInterval kANSInterval = 1.0f;
static const NSTimeInterval kANSDelay = 0;
static const CGFloat        kANSMinAlpha = 0;
static const CGFloat        kANSMaxAlpha = 1;

typedef void(^ANSComplititionBlock)(void);

@interface ANSLoadingView : UIView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, assign, getter=isVisible) BOOL visible;

//argument view must be subclass of UIView 
+ (instancetype)loadingViewOnSuperView:(UIView *)view;

// defauld setVisible (animated = YES)
- (void)setVisible:(BOOL)visible animated:(BOOL)animated;

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
 complititionBlock:(ANSComplititionBlock)block;

@end
