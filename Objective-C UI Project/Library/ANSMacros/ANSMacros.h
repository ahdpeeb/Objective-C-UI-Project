//
//  Header.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

// Macros generate readonly property for UIView class
#define ANSViewPropertySynthesize(viewClass, propertyName) \
    @property (nonatomic, readonly) viewClass * propertyName;

// Macros generate getter for UIView property 
#define ANSViewGetterSynthesize(viewClass, selector) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define ANSViewControllerBaseViewProperty(viewControllerClass, baseViewClass, propertyName) \
    @interface viewControllerClass (ANSPrivateBaseView) \
    ANSViewPropertySynthesize(baseViewClass, propertyName) \
    \
    @end \
    \
    @implementation viewControllerClass (ANSPrivateBaseView) \
    @dynamic propertyName; \
    \
    ANSViewGetterSynthesize(baseViewClass, propertyName) \
    @end \
    

