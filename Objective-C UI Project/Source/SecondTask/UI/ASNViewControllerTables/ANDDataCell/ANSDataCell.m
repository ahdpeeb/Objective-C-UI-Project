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

static const CGFloat kANSBorderWidth = 0.5;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)awakeFromNib {
    [super awakeFromNib];
    CALayer *imageLayer = self.imageView.layer;
    CALayer *selfLayer = self.layer;
    
    selfLayer.borderColor = [[UIColor blackColor] CGColor];
    selfLayer.borderWidth = kANSBorderWidth;
    
    imageLayer.cornerRadius = self.imageView.frame.size.height /2;
    imageLayer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
