//
//  ANSDataCollection.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSDataCollection.h"

@interface ANSUsersCollection : ANSDataCollection

- (NSArray *)descendingSortedUsers; 
- (ANSUsersCollection *)sortedCollectionByString:(NSString *)filterStirng;

@end
