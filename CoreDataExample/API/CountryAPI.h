//
//  CountryAPI.h
//  CoreDataExample
//
//  Created by Admin on 12/14/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryAPI : NSObject

+ (instancetype)sharedService;
- (void)loadCountries:(void (^)(id result, NSError *error))completion;

@end
