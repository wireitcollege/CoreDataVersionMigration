//
//  CountryViewController.m
//  CoreDataExample
//
//  Created by Admin on 21.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "CountryViewController.h"
#import "Region+CoreDataProperties.h"
#import "CityListController.h"

@interface CountryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *populationLabel;
@property (weak, nonatomic) IBOutlet UILabel *capitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *citiesCountLabel;
@end

@implementation CountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.country.nativeName;
    self.nameLabel.text = self.country.name;
    self.regionLabel.text = self.country.region.name;
    self.areaLabel.text = self.country.area.stringValue;
    self.populationLabel.text = self.country.population.stringValue;
    self.capitalLabel.text = self.country.capital;
    self.citiesCountLabel.text = @(self.country.cities.count).stringValue;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[CityListController class]]) {
        CityListController *cc = segue.destinationViewController;
        cc.country = self.country;
    }
}

@end
