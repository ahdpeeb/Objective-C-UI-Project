//
//  ANSDataCell.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSUser.h"

@class ANSImageView;

@interface ANSUserCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel          *label;
@property (nonatomic, strong) IBOutlet ANSImageView     *userImageView; 

- (void)fillWithModel:(ANSUser *)user;

@end
