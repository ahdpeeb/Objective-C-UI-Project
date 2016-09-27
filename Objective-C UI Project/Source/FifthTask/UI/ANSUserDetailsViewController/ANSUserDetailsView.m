//
//  ANSUserDetailsView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUserDetailsView.h"

#import "ANSFBUser.h"
#import "ANSImageView.h"

@implementation ANSUserDetailsView

#pragma mark -
#pragma mark Public methods

- (void)fillBasicInfoFromUser:(ANSFBUser *)user {
    self.imageView.imageModel =user.imageModel;
    self.fullNameLabel.text = user.fullName;
}

- (void)fillFullInfoFromUser:(ANSFBUser *)user {
    self.genderLabel.text = user.gender;
    self.emailLabel.text = user.email;
}

@end
