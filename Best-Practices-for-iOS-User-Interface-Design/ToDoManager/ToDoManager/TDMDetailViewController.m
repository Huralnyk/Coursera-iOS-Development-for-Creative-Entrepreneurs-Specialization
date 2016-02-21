//
//  TDMDetailViewController.m
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/21/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "TDMDetailViewController.h"

@interface TDMDetailViewController ()

@property (nonatomic) NSManagedObjectContext *moc;
@property (nonatomic) ToDoEntity *item;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailsField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;

@property (nonatomic) BOOL hasDeleted;

@end

@implementation TDMDetailViewController

#pragma mark - View Controller Life Cycle
#

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.titleField.text = self.item.title;
    self.detailsField.text = self.item.details;
    if (self.item.dueDate) {
        self.dateField.date = self.item.dueDate;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailsFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (!self.hasDeleted) {
        self.item.title = self.titleField.text;
        self.item.details = self.detailsField.text;
        self.item.dueDate = self.dateField.date;
        [self save];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)save {
    NSError *error;
    BOOL success = [self.moc save:&error];
    if (!success) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Couldn't save" userInfo:@{NSUnderlyingErrorKey : error}];
    }
}


#pragma mark - Actions
#

- (IBAction)titleFieldDidEndEditing:(UITextField *)sender {
    NSLog(@"*** %@", NSStringFromSelector(_cmd));
    self.item.title = sender.text;
    [self save];
}

- (IBAction)dateFieldDidEndEditing:(UIDatePicker *)sender {
    NSLog(@"*** %@", NSStringFromSelector(_cmd));
    self.item.dueDate = sender.date;
    [self save];
}

- (void)detailsFieldDidEndEditing:(NSNotification *)notification {
    NSLog(@"*** %@", NSStringFromSelector(_cmd));
    if (notification.object == self) {
        self.item.details = self.detailsField.text;
        [self save];
    }
}

- (IBAction)deleteTapped:(UIBarButtonItem *)sender {
    self.hasDeleted = YES;
    [self.moc deleteObject:self.item];
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MOC Handler
#

- (void)setMOC:(NSManagedObjectContext *)context {
    self.moc = context;
}

#pragma mark - ToDo Entity Handler
#

- (void)setToDoItem:(ToDoEntity *)item {
    self.item = item;
}

@end
