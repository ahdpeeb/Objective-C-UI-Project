//
//  ANSUserCell.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUserCell.h"

#import "ANSUser.h"

@implementation ANSUserCell

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

//It calls after fully established hierarchy of subwiews
- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark -
#pragma mark Accsessors

- (void)setUser:(ANSUser *)userObject {
    if (_userObject != userObject) {
        _userObject = userObject;
        
        [self fillWithModel:userObject];
    }
}

#pragma mark -
#pragma mark Public 

- (void)fillWithModel:(ANSUser *)user {
    self.userNameLabel.text = self.userObject.fullName;
    self.userPhotoView.image = self.userObject.userImage;
}

@end
