//
//  NSMutableDictionary+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSJSONRepresentationProtocol.h"

@interface NSMutableDictionary (Extension)

- (instancetype)JSONRepresentation;

@end
