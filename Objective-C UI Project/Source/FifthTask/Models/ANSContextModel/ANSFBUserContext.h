//
//  ANSContextModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSFBUser.h"

#import "ANSJSONRepresentation.h"

@interface ANSFBUserContext : NSObject
@property (nonatomic, readonly) id model;

- (instancetype)initWithModel:(id)model;

- (void)execute;
- (void)cancel;

//need to be reloaded
- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result;

// next methods need to me reloaded in child classes:
// return's graphPath string
- (NSString *)graphPath;

//return value must be: @"GET", @"POST", @"DELETE". default is @"GET"
- (NSString *)HTTPMethod;

// return's dictionaty with parametres;
- (NSDictionary *)parametres;

//need to be reloaded, for model notyfication if loading failed
- (void)notifyIfLoadingFailed;

//need to be reloaded, for model notyfication if model already loaded.
//if loaded, shoulds return YES.
- (BOOL)notifyIfLoaded;

@end
