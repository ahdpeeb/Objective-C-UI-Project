//
//  ANSDataCell.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
// UILabel      *label;
// UIImageView  *imageView;

#import "ANSUserCell.h"

#import "ANSImageView.h"
#import "ANSFaceBookUser.h"
#import "ANSLoadingView.h"
#import "UIView+ANSExtension.h"

#import "ANSMacros.h"

@interface ANSUserCell ()

- (void)customizeUserPicture;

@end

@implementation ANSUserCell

#pragma mark -
#pragma mark Initialization and deallocation

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Acsessors

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark -
#pragma mark Private methods

- (void)customizeUserPicture {
    UIImageView *picture = self.userImageView.contentImageView;
    
    [picture roundedLayer];
}

#pragma mark -
#pragma mark Public methods

- (void)fillWithUser:(ANSFaceBookUser *)user {
    self.label.text = user.fullName;
    self.userImageView.imageModel = user.imageModel;
    
    [self customizeUserPicture];
}

@end
