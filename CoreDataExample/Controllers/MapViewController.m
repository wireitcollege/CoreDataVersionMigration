//
//  MapViewController.m
//  CoreDataExample
//
//  Created by Admin on 21.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "NSManagedObject+CoreData.h"
#import "Country.h"
#import "CountryViewController.h"

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray <Country <MKAnnotation> *> *coutries;
@end

@implementation MapViewController

- (void)setMapView:(MKMapView *)mapView {
    _mapView = mapView;
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}

- (NSArray <Country <MKAnnotation> *> *)coutries {
    if (_coutries) {
        return _coutries;
    }
    
    _coutries = [Country allObjects];
    return _coutries;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView addAnnotations:self.coutries];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView removeAnnotations:self.coutries];
}

#pragma mark - MapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *const reuseCountryIdentifier = @"Country Annotation";
    MKPinAnnotationView *view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseCountryIdentifier];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseCountryIdentifier];
        view.canShowCallout = YES;
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    }
    view.annotation = annotation;
    
    return view;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)view.leftCalloutAccessoryView;
        Country *country = view.annotation;
        UIImage *flag = [UIImage imageNamed:country.name];
        imageView.image = flag;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"Show Country" sender:view];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[MKAnnotationView class]] &&
        [segue.destinationViewController isKindOfClass:[CountryViewController class]]) {
        MKAnnotationView *view = sender;
        CountryViewController *cvc = segue.destinationViewController;
        cvc.country = view.annotation;
    }
}

@end
