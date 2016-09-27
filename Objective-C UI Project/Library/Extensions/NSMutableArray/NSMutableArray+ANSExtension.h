//
//  NSMutableArray+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSJSONRepresentationProtocol.h"

@interface NSMutableArray (ANSExtension) <ANSJSONRepresentationProtocol>

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

//remove all NSNULL objects from array
- (instancetype)JSONRepresentation;

@end
