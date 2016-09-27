//
//  ANSUserDetailsView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSRootView.h"

@class ANSImageView;
@class ANSFBUser;

@interface ANSUserDetailsView : ANSRootView
@property (nonatomic, strong) IBOutlet ANSImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel      *fullNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *genderLabel;
@property (nonatomic, strong) IBOutlet UILabel      *emailLabel;

- (void)fillBasicInfoFromUser:(ANSFBUser *)user;
- (void)fillFullInfoFromUser:(ANSFBUser *)user;

@end
