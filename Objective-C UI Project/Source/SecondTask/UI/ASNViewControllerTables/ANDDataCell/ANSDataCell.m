//
//  ANSDataCell.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
// UILabel      *label;
// UIImageView  *imageView;


#import "ANSDataCell.h"

@implementation ANSDataCell

#pragma mark -
#pragma mark Initialization and deallocation

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 1.0f;
    
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height /2;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
