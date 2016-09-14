//
//  ANSImageModel_ANSPrivatExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModel.h"

@interface ANSImageModel ()

//Privat property for ANSImageModel
@property (nonatomic, strong)       NSURL        *url;
@property (nonatomic, strong)       UIImage      *image;
@property (nonatomic, strong)       NSMapTable   *cacheStorage;

@end
