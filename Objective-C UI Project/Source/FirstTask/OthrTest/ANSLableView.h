//
//  ANSLableView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANSLableView : UIView
@property (nonatomic, strong) IBOutlet UILabel *lable;
@property (nonatomic, strong) IBOutlet UIButton *rotate;

- (void)rotateLabel; 

@end
