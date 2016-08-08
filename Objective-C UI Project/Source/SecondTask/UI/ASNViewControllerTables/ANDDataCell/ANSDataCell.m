//
//  ANSDataCell.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
// UILabel      *label;
// UIImageView  *imageView;


#import "ANSDataCell.h"
#import "ANSImageView.h"

@implementation ANSDataCell

#pragma mark -
#pragma mark Initialization and deallocation

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

#pragma mark -
#pragma mark acsessors

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark -
#pragma mark Private methods

- (void)roundUserPicture {
    UIImageView *picture = self.userImageView.contentImageView;
    
    picture.layer.cornerRadius = picture.frame.size.height /2;
    picture.layer.masksToBounds = YES;
    
    self.userImageView.backgroundColor = self.backgroundColor;
}

#pragma mark -
#pragma mark Public methods

- (void)fillInfoFromObject:(ANSData *)object {
    self.label.text = object.string;
    self.userImageView.imageModel = object.imageModel;
    
    [self roundUserPicture];
}

@end
