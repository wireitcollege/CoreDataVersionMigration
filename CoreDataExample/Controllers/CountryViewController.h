//
//  CountryViewController.h
//  CoreDataExample
//
//  Created by Admin on 21.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country+CoreDataProperties.h"

@interface CountryViewController : UITableViewController
@property (nonatomic, strong) Country *country;
@end
