//
//  ViewController.m
//  CoreDataCoursera
//
//  Created by Alexey Huralnyk on 12/7/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ChoreMO.h"
#import "PersonMO.h"
#import "ChoreLogMO.h"
#import "PickerViewHelper.h"

@interface ViewController ()

@property (nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UITextField *choreField;
@property (weak, nonatomic) IBOutlet UITextField *personField;
@property (weak, nonatomic) IBOutlet UILabel *persistedData;
@property (weak, nonatomic) IBOutlet UIPickerView *choreRoller;
@property (weak, nonatomic) IBOutlet UIPickerView *personRoller;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic) PickerViewHelper *choreRollerHelper;
@property (nonatomic) PickerViewHelper *personRollerHelper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.choreRollerHelper = [[PickerViewHelper alloc] init];
    [self.choreRoller setDataSource:self.choreRollerHelper];
    [self.choreRoller setDelegate:self.choreRollerHelper];
    
    self.personRollerHelper = [[PickerViewHelper alloc] init];
    [self.personRoller setDataSource:self.personRollerHelper];
    [self.personRoller setDelegate:self.personRollerHelper];
    
    [self updateLogList];
    [self updateChoreRoller];
    [self updatePersonRoller];
}

- (IBAction)choreTapped:(id)sender {
    ChoreMO *c = [self.appDelegate createChoreMO];
    c.chore_name = self.choreField.text;
    
    [self.appDelegate saveContext];
    [self updateChoreRoller];
}

- (IBAction)personTapped:(id)sender {
    PersonMO *p = [self.appDelegate createPersonMO];
    p.person_name = self.personField.text;
    
    [self.appDelegate saveContext];
    [self updatePersonRoller];
}

- (IBAction)choreLogTapped:(id)sender {
    NSInteger choreRow = [self.choreRoller selectedRowInComponent:0];
    NSInteger personRow = [self.personRoller selectedRowInComponent:0];
    ChoreMO *chore = (ChoreMO *)[self.choreRollerHelper getItemFromArray:choreRow];
    PersonMO *person = (PersonMO *)[self.personRollerHelper getItemFromArray:personRow];
    ChoreLogMO *choreLog = [self.appDelegate createChoreLogMO];
    
    choreLog.person_who_did_it = person;
    choreLog.chore_done = chore;
    choreLog.when = [self.datePicker date];
    
    [self.appDelegate saveContext];
    [self updateLogList];
}

- (IBAction)deleteTapped:(id)sender {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Chore objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreMO *c in results) {
        [moc deleteObject:c];
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    error = nil;
    results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Person objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (PersonMO *p in results) {
        [moc deleteObject:p];
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
    
    error = nil;
    results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching ChoreLog objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreLogMO *cl in results) {
        [moc deleteObject:cl];
    }
    
    [self.appDelegate saveContext];
    [self updateLogList];
    [self updateChoreRoller];
    [self updatePersonRoller];

}

- (void)updateLogList {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching ChoreLog objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (ChoreLogMO *cl in results) {
        [buffer appendFormat:@"\n%@", cl];
    }
    
    self.persistedData.text = buffer;
}

- (void)updateChoreRoller {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Chore objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    [self.choreRollerHelper setArray:results];
    [self.choreRoller reloadAllComponents];
}

- (void)updatePersonRoller {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Person objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    [self.personRollerHelper setArray:results];
    [self.personRoller reloadAllComponents];
}

@end
