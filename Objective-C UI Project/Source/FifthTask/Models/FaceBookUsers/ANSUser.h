//
//  ANSUser.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 07.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ANSUser : NSManagedObject
@property (nonatomic, readonly) NSString      *fullName;
@property (nonatomic, readonly) NSURL         *imageUrl;

- (void)fillWithRandom;

@end

#import "ANSUser+CoreDataProperties.h"
