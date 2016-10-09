//
//  ANSUserDetailsView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUserDetailsView.h"

#import "ANSUser.h"
#import "ANSImageView.h"

@implementation ANSUserDetailsView

#pragma mark -
#pragma mark Public methods

- (void)fillBasicInfoFromUser:(ANSUser *)user {
    self.imageView.imageModel =user.imageModel;
    self.fullNameLabel.text = user.fullName;
}

- (void)fillFullInfoFromUser:(ANSUser *)user {
    self.genderLabel.text = user.gender;
}

@end
