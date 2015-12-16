//
//  CountryListController.m
//  CoreDataExample
//
//  Created by Admin on 12/9/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "CountryListController.h"
#import "NSManagedObjectContext+MainContext.h"
#import "NSManagedObject+CoreData.h"
#import "Country+CoreDataProperties.h"
#import "CityListController.h"
#import "CountryAPI.h"
#import "Region+CoreDataProperties.h"

@interface CountryListController ()
@property (nonatomic, strong, readwrite) NSFetchedResultsController *fetchedResultsController;
@end

@implementation CountryListController

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        _fetchedResultsController = [Country fetchedResultsSortedBy:@"name"
                                                          ascending:YES
                                                          predicate:nil
                                                          groupedBy:nil
                                                          inContext:[NSManagedObjectContext mainContext]];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh:nil];
}

- (IBAction)refresh:(id)sender {
    [self.refreshControl beginRefreshing];
    [[CountryAPI sharedService] loadCountries:^(id result, NSError *error) {
        if (error) {
            //TODO: Show error ...
        }
        [self.refreshControl endRefreshing];
    }];
    
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const reuseIdentifier = @"Country Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = country.region.name;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSArray <UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [country deleteEntity];
    }];
    return @[deleteAction];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[CityListController class]] &&
        [sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [(CityListController *)segue.destinationViewController setCountry:country];
    }
}

@end