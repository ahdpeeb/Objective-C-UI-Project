//
//  ANSDataCell.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSData.h"

@class ANSImageView;

@interface ANSDataCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel          *label;
@property (nonatomic, strong) IBOutlet ANSImageView     *userImageView; 

- (void)fillInfoFromObject:(ANSData *)object; 

@end
