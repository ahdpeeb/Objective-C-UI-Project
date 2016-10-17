//
//  UIAlertController+ANSExtenison.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ANSActionHandler)(UIAlertAction *);

@interface UIAlertController (ANSExtenison)

//Two-buttons controller
+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                    leffAcitonTitle:(NSString *)leffTitle
                        leftHandler:(ANSActionHandler)leftHandler
                   rigntAcitonTitle:(NSString *) rigntTitle
                       rigntHandler:(ANSActionHandler)rigntHandler;

//one-button controller
+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                        acitonTitle:(NSString *)acitonTitle
                      acitonHandler:(ANSActionHandler)handler;

@end
