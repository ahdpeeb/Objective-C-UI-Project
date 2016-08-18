//
//  ANSLoadingView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANSLoadingView : UIView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicator;

- (void)dissapearWithAnimation; 

@end
