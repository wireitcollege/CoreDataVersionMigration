//
//  Country+CoreDataProperties.m
//  CoreDataExample
//
//  Created by Admin on 16.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Country+CoreDataProperties.h"
#import "Region+CoreDataProperties.h"

@implementation Country (CoreDataProperties)

@dynamic area;
@dynamic capital;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic nativeName;
@dynamic population;
@dynamic cities;
@dynamic region;

@end
