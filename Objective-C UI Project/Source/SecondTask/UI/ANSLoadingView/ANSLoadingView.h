//
//  ANSLoadingView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ANSLoadingViewState) {
    ANSActive,
    ANSInactive,
};

@interface ANSLoadingView : UIView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, readonly) ANSLoadingViewState state;
@property (nonatomic, assign, getter=isVisible) BOOL visible; 

//argument view must be subclass of UIView 
+ (instancetype)loadingViewOnSuperView:(UIView *)view;

- (void)activate;
- (void)deactivate;

@end
