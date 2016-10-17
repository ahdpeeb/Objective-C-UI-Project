//
//  UIAlertController+ANSExtenison.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UIAlertController+ANSExtenison.h"

@implementation UIAlertController (ANSExtenison)

+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                    leffAcitonTitle:(NSString *)leffTitle
                        leftHandler:(ANSActionHandler)leftHandler
                   rigntAcitonTitle:(NSString *) rigntTitle
                       rigntHandler:(ANSActionHandler)rigntHandler

{
    UIAlertController *controller =
    [self controllerWithTitle:title message:massage acitonTitle:leffTitle acitonHandler:leftHandler];
    UIAlertAction* rigntAction = [UIAlertAction actionWithTitle:rigntTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             rigntHandler(action);
                                                         }];
    
    [controller addAction:rigntAction];
    
    return controller;
}

+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                        acitonTitle:(NSString *)acitonTitle
                      acitonHandler:(ANSActionHandler)handler {
    
    UIAlertController *controller =
    [UIAlertController alertControllerWithTitle:title
                                        message:massage
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* leftAction = [UIAlertAction actionWithTitle:acitonTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action) {
                                                           handler(action);
                                                       }];
    [controller addAction:leftAction];
    return controller;
}

@end
