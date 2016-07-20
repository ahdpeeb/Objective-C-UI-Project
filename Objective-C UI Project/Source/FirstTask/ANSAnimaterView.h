//
//  ANSAnimaterView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ANSCompletionHandler)(void);

typedef enum {
    ANSFirsPosition,
    ANSSecondPosition,
    ANSThirdPosition,
    ANSFourthPosition,
} ANSViewPosition;

@interface ANSAnimaterView : UIView


@end
