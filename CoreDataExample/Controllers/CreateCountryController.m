//
//  CreateCountryController.m
//  CoreDataExample
//
//  Created by Admin on 12/9/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "CreateCountryController.h"
#import "Country+CoreDataProperties.h"
#import "NSManagedObjectContext+MainContext.h"
#import "NSManagedObject+CoreData.h"
#import "TextFieldCell.h"

@interface CreateCountryController () <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *populationTextField;
@property (nonatomic, weak) IBOutlet UITextField *capitalTextField;
@end

@implementation CreateCountryController

#pragma mark - TextField View Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.populationTextField becomeFirstResponder];
    }
    
    if (textField == self.populationTextField) {
        [self.capitalTextField becomeFirstResponder];
    }
    
    if (textField == self.capitalTextField) {
        [textField resignFirstResponder];
        [self createObject];
    }
    return YES;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TextFieldCell *cell = (TextFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell.textField becomeFirstResponder];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.section == 1) {
        [self createObject];
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    return [NSManagedObjectContext mainContext];
}

- (void)createObject {
    
    Country *country = [Country createEntity];
    
    country.name = self.nameTextField.text;
    country.population = @([self.populationTextField.text integerValue]);
    country.capital = self.capitalTextField.text;
    
    [NSManagedObjectContext saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
