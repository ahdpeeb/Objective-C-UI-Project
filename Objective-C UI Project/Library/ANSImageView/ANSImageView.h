//
//  ANSImageView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANSImageModel;

@interface ANSImageView : UIView
@property (nonatomic, retain) IBOutlet  UIImageView     *contentImageView;
@property (nonatomic, retain)           ANSImageModel   *imageModel;

@end
