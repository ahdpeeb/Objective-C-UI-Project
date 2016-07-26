//
//  ANSTablesView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANSTableView : UIView
@property (nonatomic, strong) IBOutlet UITableView  *table;

@property (nonatomic, strong) IBOutlet UIButton     *editButton;
@property (nonatomic, strong) IBOutlet UIButton     *addButton;

@end
