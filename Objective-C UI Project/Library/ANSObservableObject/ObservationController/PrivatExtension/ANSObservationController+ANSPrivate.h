//
//  ANSObservationController_ANSPrivateExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 02.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservationController.h"

@interface ANSObservationController ()

- (void)notifyWithState:(NSUInteger)state;
- (void)notifyWithState:(NSUInteger)state withObject:(id)object;

@end
