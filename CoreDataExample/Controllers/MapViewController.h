//
//  MapViewController.h
//  CoreDataExample
//
//  Created by Admin on 21.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray <Country <MKAnnotation> *> *coutries;
@end
