//
//  ANSTablesView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANSLoadingView;

@interface ANSTableView : UIView
@property (nonatomic, strong) IBOutlet UITableView      *table;
@property (nonatomic, strong) IBOutlet UISearchBar      *searchBar;
@property (nonatomic, strong) IBOutlet ANSLoadingView   *loadingView;

@end
