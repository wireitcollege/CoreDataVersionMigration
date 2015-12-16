//
//  CityListController.h
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import "FetchedTableViewController.h"
@interface CityListController : FetchedTableViewController
@property (strong, nonatomic) Country *country;
@end
