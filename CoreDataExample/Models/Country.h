//
//  Country.h
//  CoreDataExample
//
//  Created by Admin on 16.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Region;

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@property (nonatomic, strong, readonly) NSString *regionName;

@end

NS_ASSUME_NONNULL_END

#import "Country+CoreDataProperties.h"
