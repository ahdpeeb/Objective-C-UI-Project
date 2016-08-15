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
    @interface viewControllerClass (__ANSPrivateBaseView) \
    ANSViewPropertySynthesize(baseViewClass, propertyName) \
    \
    @end \
    \
    @implementation viewControllerClass (__ANSPrivateBaseView) \
    @dynamic propertyName; \
    \
    ANSViewGetterSynthesize(baseViewClass, propertyName) \
    @end \

//empty result
#define ANSEmptyResult

//Weakify and Strongify object before using in block
#define ANSWeakify(object) \
    __weak __typeof(object) __ANSWeekified_##object = object \

//you should call this method after you called ANSWeakify for the same object
#define ANSStrongify(object) \
    __strong __typeof(object) object = __ANSWeekified_##object \

#define ANSStrongifyAndReturnValue(object, value) \
    ANSStrongify(object); \
    if(!object) { \
        return value; \
    } \

//you should call this method after you called ANSWeakify for the same object
#define ANSStrongifyAndReturnNil(object) \
    ANSStrongifyAndReturnValue(object, nil) \

#define ANSStrongifyAndReturn(object) \
    ANSStrongifyAndReturnValue(object, ANSEmptyResult) \



