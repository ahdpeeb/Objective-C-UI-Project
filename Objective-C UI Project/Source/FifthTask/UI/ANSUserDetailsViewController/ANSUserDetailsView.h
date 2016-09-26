//
//  ANSUserDetailsView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSRootView.h"

@class ANSImageView;

@interface ANSUserDetailsView : ANSRootView

@property (nonatomic, strong) IBOutlet ANSImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel      *fullName;
@property (nonatomic, strong) IBOutlet UILabel      *gender;


@end
