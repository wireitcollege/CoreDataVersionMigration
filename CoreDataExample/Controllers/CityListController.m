//
//  CityListController.m
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "CityListController.h"
#import "NSManagedObject+CoreData.h"
#import "NSManagedObjectContext+MainContext.h"
#import "City+CoreDataProperties.h"


@interface CityListController ()
@property (nonatomic, strong, readwrite) NSFetchedResultsController *fetchedResultsController;
@end

@implementation CityListController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.country.name;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"country == %@", self.country];
        _fetchedResultsController = [City fetchedResultsSortedBy:@"name"
                                                       ascending:YES
                                                       predicate:predicate
                                                       groupedBy:nil
                                                       inContext:[NSManagedObjectContext mainContext]];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseCityCellIdentifier = @"City Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCityCellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - User Actions

- (IBAction)addNewCity:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add City" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input city name...";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"Create" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        
        City *city = [City createEntity];
        city.name = textField.text;
        city.country = self.country;
        
        [NSManagedObjectContext saveContext];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Fetched Results Controller Delegate

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    City *city = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = city.name;
}

@end
