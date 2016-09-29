//
//  ANSUserCell.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTableViewSell.h"

@class ANSUser;

@interface ANSUserCell : ANSTableViewSell

@property (nonatomic, strong) IBOutlet  UILabel      *userNameLabel;
@property (nonatomic, strong) IBOutlet  UIImageView  *userPhotoView;

@property (nonatomic, strong)           ANSUser      *userObject;

- (void)fillWithModel:(ANSUser*)user; 

@end
