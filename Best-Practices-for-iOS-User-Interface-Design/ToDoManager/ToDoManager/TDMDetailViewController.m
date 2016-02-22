//
//  TDMDetailViewController.m
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/21/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "TDMDetailViewController.h"

@interface TDMDetailViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) NSManagedObjectContext *moc;
@property (nonatomic) ToDoEntity *item;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *statusPicker;


@property (nonatomic) BOOL hasDeleted;

@end

@implementation TDMDetailViewController

#pragma mark - View Controller Life Cycle
#

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.titleField.text = self.item.title;
    [self.priorityPicker selectRow:self.item.priority inComponent:0 animated:NO];
    [self.statusPicker selectRow:self.item.done inComponent:0 animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (!self.hasDeleted) {
        self.item.title = self.titleField.text;
        [self save];
    }
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
    self.item.title = sender.text;
    [self save];
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

#pragma mark - Picker View Delegate
#

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.priorityPicker) {
        return 3;
    } else {
        return 2;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == self.priorityPicker) {
        
        if (row == 0) {
            return @"Low";
        } else if (row == 1) {
            return @"Medium";
        } else {
            return @"High";
        }
        
    } else {
        
        if (row == 0) {
            return @"Not Finished";
        } else {
            return @"Finished";
        }
        
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.priorityPicker) {
        
        if (row == 0) {
            self.item.priority = ToDoEntityPriorityLow;
        } else if (row == 1) {
            self.item.priority = ToDoEntityPriorityMedium;
        } else {
            self.item.priority = ToDoEntityPriorityHigh;
        }
        
    } else {
        
        if (row == 0) {
            self.item.done = NO;
        } else {
            self.item.done = YES;
        }
        
    }
}

@end
