//
//  CountryMapViewController.m
//  CoreDataExample
//
//  Created by Admin on 21.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "CountryMapViewController.h"

@interface CountryMapViewController ()
@property (strong, nonatomic) NSArray <Country <MKAnnotation> *> *coutries;
@end

@implementation CountryMapViewController

@synthesize coutries = _coutries;

- (NSArray<Country<MKAnnotation> *> *)coutries {
    if (_coutries) {
        return _coutries;
    }
    
    _coutries = @[self.country];
    return _coutries;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.scrollEnabled = NO;
    self.mapView.rotateEnabled = NO;
    self.mapView.zoomEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView showAnnotations:self.coutries animated:animated];
    MKCoordinateRegion region;
    region.center = [(id <MKAnnotation>)self.country coordinate];
    region.span = MKCoordinateSpanMake(15.0, 15.0);
    [self.mapView setRegion:region animated:YES];
}

@end
