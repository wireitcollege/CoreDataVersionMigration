//
//  Country+Mapping.h
//  CoreDataExample
//
//  Created by Admin on 12/14/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "Country.h"

@interface Country (Mapping)

+ (instancetype)countryWithDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context;

@end
