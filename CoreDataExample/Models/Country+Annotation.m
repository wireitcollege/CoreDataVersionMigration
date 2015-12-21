//
//  Country+Annotation.m
//  CoreDataExample
//
//  Created by Admin on 21.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "Country+Annotation.h"

@implementation Country (Annotation)

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude.doubleValue;
    coordinate.longitude = self.longitude.doubleValue;
    return coordinate;
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.capital;
}

@end
