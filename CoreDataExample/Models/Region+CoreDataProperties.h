//
//  Region+CoreDataProperties.h
//  CoreDataExample
//
//  Created by Admin on 16.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Region.h"

NS_ASSUME_NONNULL_BEGIN

@interface Region (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Country *> *countries;

@end

@interface Region (CoreDataGeneratedAccessors)

- (void)addCountriesObject:(Country *)value;
- (void)removeCountriesObject:(Country *)value;
- (void)addCountries:(NSSet<Country *> *)values;
- (void)removeCountries:(NSSet<Country *> *)values;

@end

NS_ASSUME_NONNULL_END
